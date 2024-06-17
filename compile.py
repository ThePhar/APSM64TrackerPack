from json import JSONEncoder, dumps
from dataclasses import dataclass, is_dataclass, asdict
from typing import Optional, Literal

from locations import items, locations


class DataClassJSONEncoder(JSONEncoder):
    def default(self, o):
        if is_dataclass(o):
            return self.clean_nones(asdict(o))
        return super().default(o)

    @classmethod
    def clean_nones(cls, value):
        """
        Recursively remove all None values from dictionaries and lists, and returns
        the result as a new dictionary or list.
        """
        if isinstance(value, list):
            return [cls.clean_nones(x) for x in value if x is not None]
        elif isinstance(value, dict):
            return {key: cls.clean_nones(val) for key, val in value.items() if val is not None}
        else:
            return value


@dataclass
class StageDefinition:
    name: str
    img: Optional[str] = None
    img_mods: Optional[str] = None
    disabled_img_mods: Optional[str] = None
    disabled_img: Optional[str] = None
    codes: Optional[str] = None
    inherit_codes: Optional[bool] = None


@dataclass
class ItemDefinition:
    name: str
    type: Literal[
        "static",
        "progressive",
        "toggle",
        "consumable",
        "progressive_toggle",
        "composite_toggle",
        "toggle_badged",
    ]
    img: Optional[str] = None
    img_mods: Optional[str] = None
    disabled_img: Optional[str] = None
    disabled_img_mods: Optional[str] = None
    codes: Optional[str] = None
    stages: Optional[list[StageDefinition]] = None
    initial_stage_idx: Optional[int] = None
    loop: Optional[bool] = None
    allow_disabled: Optional[bool] = None


@dataclass
class MapLocationDefinition:
    map: str
    x: int
    y: int


@dataclass
class LocationDefinition:
    name: str
    chest_opened_img: str
    chest_unopened_img: str
    access_rules: str | list[str] = ""
    visibility_rules: str | list[str] = ""
    map_locations: Optional[list[MapLocationDefinition]] = None


from entrances import entrances


er_items: list[ItemDefinition] = [
    *[
        ItemDefinition(
            name=f"{entrance.name} - Entrance",
            type="toggle",
            img=f"images/er_legend/er_{entrance.code}_ent.png",
            disabled_img_mods="none",
            codes=f"__er_{entrance.code}_ent",
        )
        for entrance in entrances
    ],
    *[
        ItemDefinition(
            name=f"{entrance.name} - Destination Node",
            type="progressive",
            loop=True,
            codes=f"__er_{entrance.code}_dst",
            initial_stage_idx=0,
            allow_disabled=False,
            stages=[
                StageDefinition(
                    name="Unknown Stage Destination",
                    inherit_codes=False,
                    img="images/er_legend/er_unknown_dst.png",
                ),
                *[
                    StageDefinition(
                        name=f"{inner_entrance.name} - Destination",
                        inherit_codes=False,
                        img=f"images/er_legend/er_{inner_entrance.code}_dst.png",
                    )
                    for inner_entrance in entrances
                ],
            ],
        )
        for entrance in entrances
    ],
]


def compile_all():
    with open("items/er_items.json", "w") as file:
        file.write("// This file is auto-generated. Do not make modifications to this file directly.\n")
        file.write(dumps(er_items, cls=DataClassJSONEncoder))

    with open("items/location_items.json", "w") as file:
        file.write("// This file is auto-generated. Do not make modifications to this file directly.\n")
        file.write(dumps(items))

    with open("scripts/autotracking/location_mapping.lua", "w") as file:
        file.write("-- This file is auto-generated. Do not make modifications to this file directly.\n")
        file.write("LOCATION_MAPPING = {\n")
        for location in locations:
            if location.code == 0:
                continue

            file.write(f'    [{location.code}] = {{"{location.get_code_name()}"}},\n')
        file.write("}")

    with open(f"locations/entrances.json", "w") as file:
        file.write("// This file is auto-generated. Do not make modifications to this file directly.\n")
        region_entrances = [
            {
                "name": f"{entrance.name} Entrance",
                "access_rules": entrance.access_rules,
                "children": [
                    {
                        "name": "Unknown Destination",
                        "visibility_rules": f"$CanNotSee|{entrance.code}",
                        "access_rules": [rule for rule in entrance.access_rules],
                        "map_locations": [
                            {
                                "map": "map_castle",
                                "x": entrance.coords[0],
                                "y": entrance.coords[1],
                            }
                        ],
                        "sections": [
                            {
                                "name": "Enter Stage and Set Entrance",
                                "hosted_item": "__unknown_er",
                            }
                        ],
                    },
                    {
                        "name": "Bowser in the Sky",
                        "access_rules": ["$CanAccessUpstairs,$HasStars|F2Door,$HasStars|F3Door"],
                        "map_locations": [{"map": "map_castle", "x": 1366, "y": 520}],
                        "sections": [
                            {
                                "name": location.name,
                                "hosted_item": location.get_code_name(),
                                "access_rules": location.access_rules,
                                "visibility_rules": location.visibility_rules(),
                            }
                            for location in locations
                            if location.region == "Bowser in the Sky"
                        ],
                    },
                    *[
                        {
                            "name": region.stageify(),
                            "map_locations": [
                                {
                                    "map": "map_castle",
                                    "x": entrance.coords[0],
                                    "y": entrance.coords[1],
                                }
                            ],
                            "visibility_rules": f"$CanSee|{region.code}|{entrance.code}",
                            "sections": [
                                {
                                    "name": location.name,
                                    "hosted_item": location.get_code_name(),
                                    "access_rules": location.access_rules,
                                    "visibility_rules": location.visibility_rules(),
                                }
                                for location in locations
                                if location.in_region(region.name)
                            ],
                        }
                        for region in entrances
                    ],
                ],
            }
            for entrance in entrances
        ]

        file.write(dumps(region_entrances))
