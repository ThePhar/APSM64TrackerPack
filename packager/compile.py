import json
import os

from Phakager import PACK_ROOT_PATH
from packager.entrances import areas, entrances
from packager.locations import locations


def output_jsonc(file_path: str, data: any) -> None:
    print(f"[Phakager] Generating file: {file_path}")
    with open(os.path.join(PACK_ROOT_PATH, file_path), "w") as file:
        file.write("// This file was auto-generated by Phakager. Do not make direct modifications.\n")
        file.write(json.dumps(data, indent=4))


def compile_area_items() -> None:
    entrance_items: list[dict[str, any]] = [
        {
            "name": f"{entrance_name} - Entrance",
            "type": "toggle",
            "img": f"images/er_legend/er_{entrance}_ent.png",
            "disabled_img_mods": "none",
            "codes": f"__er_{entrance}_ent",
        }
        for entrance_name, entrance in entrances.items()
    ]

    destination_items: list[dict[str, any]] = [
        {
            "name": f"{entrance_name} - Destination Icon",
            "type": "progressive",
            "loop": True,
            "initial_stage_idx": 0 if entrance_name != "Bowser in the Sky" else 19,  # 19 == BitS
            "allow_disabled": False,
            "codes": f"__er_{entrance}_dst",
            "stages": [
                {
                    "name": "Unknown Destination",
                    "img": "images/er_legend/er_unknown_dst.png",
                    "inherit_codes": False,
                },
                *[
                    {
                        "name": f"{entrance_name} - Destination",
                        "img": f"images/er_legend/er_{entrance}_dst.png",
                        "inherit_codes": False,
                    }
                    for entrance_name, entrance in entrances.items()
                ],
            ],
        }
        for entrance_name, entrance in entrances.items()
    ]

    output_data = entrance_items + destination_items
    output_jsonc("items/area_rando.json", output_data)


def compile_location_items() -> None:
    location_items: list[dict[str, any]] = [
        {
            "name": "Enter Stage and Set Entrance",
            "type": "toggle",
            "codes": "__location_item_null",
        },
        *[
            {
                "name": location.name,
                "type": "toggle",
                "codes": location.item_codes,
                "img": location.image.missing,
                "disabled_img": location.image.checked,
                "disabled_img_mods": "none",
            }
            for location in locations
        ],
    ]

    output_jsonc("items/locations.json", location_items)


def compile_entrances() -> None:
    overworld_entrances = [
        {
            "name": f"{entrance_name} Entrance",
            "access_rules": entrance.access_rules,
            "children": [
                {
                    "name": "? ? ? Destination",
                    "visibility_rules": f"$IsUnknownDestination|{entrance}",
                    "access_rules": entrance.access_rules,
                    "map_locations": [
                        {
                            "map": "map_castle",
                            "x": entrance.coords[0],
                            "y": entrance.coords[1],
                        }
                    ],
                    "sections": [{"name": "Enter Stage and Set Entrance", "hosted_item": "__location_item_null"}],
                },
                *[
                    {
                        "name": area,
                        "visibility_rules": f"$IsSelectedDestination|{area_acronym}|{entrance}",
                        "map_locations": [
                            {
                                "map": "map_castle",
                                "x": entrance.coords[0],
                                "y": entrance.coords[1],
                            }
                        ],
                        "sections": [
                            {
                                "name": location.name,
                                "hosted_item": location.item_codes,
                                "access_rules": location.access_rules,
                                "visibility_rules": location.visibility_rules,
                            }
                            for location in locations
                            if location.area == area
                        ],
                    }
                    for area, area_acronym in areas.items()
                ],
            ],
        }
        for entrance_name, entrance in entrances.items()
    ]

    output_jsonc("locations/castle_entrances.json", overworld_entrances)


def compile_all():
    compile_area_items()
    compile_location_items()
    compile_entrances()

    # with open("../scripts/autotracking/location_mapping.lua", "w") as file:
    #     file.write("-- This file is auto-generated. Do not make modifications to this file directly.\n")
    #     file.write("LOCATION_MAPPING = {\n")
    #     for location in locations:
    #         if location.code == 0:
    #             continue
    #
    #         file.write(f'    [{location.code}] = {{"{location.get_code_name()}"}},\n')
    #     file.write("}")
