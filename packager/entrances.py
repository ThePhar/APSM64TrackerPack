from typing import NamedTuple, Optional

from packager.types import EntranceName, AreaName


areas: dict[AreaName, str] = {
    "Bob-omb Battlefield": "bob",
    "Whomp's Fortress": "wf",
    "Jolly Roger Bay": "jrb",
    "Cool, Cool Mountain": "ccm",
    "Big Boo's Haunt": "bbh",
    "Hazy Maze Cave": "hmc",
    "Lethal Lava Land": "lll",
    "Shifting Sand Land": "ssl",
    "Dire, Dire Docks": "ddd",
    "Snowman's Land": "sl",
    "Wet-Dry World": "wdw",
    "Tall, Tall Mountain": "ttm",
    "Tiny-Huge Island": "thi",
    "Tick Tock Clock": "ttc",
    "Rainbow Ride": "rr",
    "Bowser in the Dark World": "bitdw",
    "Bowser in the Fire Sea": "bitfs",
    "Bowser in the Sky": "bits",
    "Tower of the Wing Cap": "totwc",
    "Cavern of the Metal Cap": "cotmc",
    "Vanish Cap under the Moat": "vcutm",
    "Princess's Secret Slide": "pss",
    "Secret Aquarium": "sa",
    "Wing Mario over the Rainbow": "wmotr",
}


class Entrance(NamedTuple):
    acronym: str
    er_code: Optional[int]
    coords: tuple[int, int]
    access_rules: list[str] = []

    def __str__(self) -> str:
        return self.acronym


# fmt: off
entrances: dict[EntranceName, Entrance] = {
    # Main Courses
    "Bob-omb Battlefield":         Entrance("bob",     91, (102,  529)),
    "Whomp's Fortress":            Entrance("wf",     241, (690,  631), ["$HasStars|1"]),
    "Jolly Roger Bay":             Entrance("jrb",    121, (671,  957), ["$HasStars|3"]),
    "Cool, Cool Mountain":         Entrance("ccm",     51, (525,  528), ["$HasStars|3"]),
    "Big Boo's Haunt":             Entrance("bbh",     41, (689,  370), ["$HasStars|12"]),
    "Hazy Maze Cave":              Entrance("hmc",     71, (1448, 778), ["$CanAccessBasement"]),
    "Lethal Lava Land":            Entrance("lll",    221, (1169, 686), ["$CanAccessBasement"]),
    "Shifting Sand Land":          Entrance("ssl",     81, (1060, 822), ["$CanAccessBasement"]),
    "Dire, Dire Docks":            Entrance("ddd",    231, (1519, 994), ["$CanAccessDDD"]),
    "Snowman's Land":              Entrance("sl",     101, (1104, 524), ["$CanAccessSecondFloor"]),
    "Wet-Dry World":               Entrance("wdw",    111, (1420, 520), ["$CanAccessSecondFloor"]),
    "Tall, Tall Mountain":         Entrance("ttm",    361, (1398, 336), ["$CanAccessSecondFloor"]),
    "Tiny-Huge Island (Huge)":     Entrance("thih",   131, (1682, 648), ["$CanAccessSecondFloor"]),
    "Tiny-Huge Island (Tiny)":     Entrance("thit",   132, (1682, 376), ["$CanAccessSecondFloor"]),
    "Tick Tock Clock":             Entrance("ttc",    141, (1364, 104), ["$CanAccessThirdFloor,$HasMoves|LG/TJ/SF/BF/WK"]),
    "Rainbow Ride":                Entrance("rr",     151, (1587, 168), ["$CanAccessThirdFloor,$HasMoves|TJ/SF/BF"]),

    # Bowser Levels
    "Bowser in the Dark World":    Entrance("bitdw",  171, (322,  308), ["$HasStars|F1Door"]),
    "Bowser in the Fire Sea":      Entrance("bitfs",  191, (1565, 994), ["$CanAccessDDD,$HasCompleted|3626056"]),
    "Bowser in the Sky":           Entrance("bits",  None, (1366, 520), ["$CanAccessThirdFloor,$HasStars|F3Door"]),

    # Secret Stages
    "Tower of the Wing Cap":       Entrance("totwc",  291, (286,  814), ["$HasStars|10"]),
    "Cavern of the Metal Cap":     Entrance("cotmc",  281, (910,  143), ["^$CanAccessHMC"]),
    "Vanish Cap under the Moat":   Entrance("vcutm",  181, (1828, 885), ["$CanAccessBasement,$HasAnyMoves|GP"]),
    "Princess's Secret Slide":     Entrance("pss",    271, (648,  762), ["$HasStars|1"]),
    "Secret Aquarium":             Entrance("sa",     201, (456,  874), ["$HasStars|3,^$CanAccessSA"]),
    "Wing Mario over the Rainbow": Entrance("wmotr",  311, (1142, 168), ["$CanAccessThirdFloor,$HasMoves|TJ/SF/BF"]),
}
