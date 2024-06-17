from typing import NamedTuple


class Entrance(NamedTuple):
    name: str
    code: str
    coords: tuple[int, int]
    access_rules: list[str] = []

    def stageify(self):
        translation = {
            "Bob-omb Battlefield": "1. Bob-omb Battlefield",
            "Whomp's Fortress":    "2. Whomp's Fortress",
            "Jolly Roger Bay":     "3. Jolly Roger Bay",
            "Cool, Cool Mountain": "4. Cool, Cool Mountain",
            "Big Boo's Haunt":     "5. Big Boo's Haunt",
            "Hazy Maze Cave":      "6. Hazy Maze Cave",
            "Lethal Lava Land":    "7. Lethal Lava Land",
            "Shifting Sand Land":  "8. Shifting Sand Land",
            "Dire, Dire Docks":    "9. Dire, Dire Docks",
            "Snowman's Land":      "10. Snowman's Land",
            "Wet-Dry World":       "11. Wet-Dry World",
            "Tall, Tall Mountain": "12. Tall, Tall Mountain",
            "Tiny-Huge Island":    "13. Tiny-Huge Island",
            "Tick Tock Clock":     "14. Tick Tock Clock",
            "Rainbow Ride":        "15. Rainbow Ride",
        }
        if self.name.startswith("Tiny-Huge Island"):
            name = translation["Tiny-Huge Island"]
            return f"{name} (Tiny)" if self.name.endswith("(Tiny)") else f"{name} (Huge)"
        if self.name in translation:
            return translation[self.name]
        return self.name


# Main Stages
entrances: list[Entrance] = [
    Entrance("Bob-omb Battlefield",         "bob",   (102,  529), ["$HasStars|0"]),
    Entrance("Whomp's Fortress",            "wf",    (690,  631), ["$HasStars|1"]),
    Entrance("Jolly Roger Bay",             "jrb",   (671,  957), ["$HasStars|3"]),
    Entrance("Cool, Cool Mountain",         "ccm",   (525,  528), ["$HasStars|3"]),
    Entrance("Big Boo's Haunt",             "bbh",   (689,  370), ["$HasStars|12"]),
    Entrance("Hazy Maze Cave",              "hmc",   (1448, 778), ["$CanAccessBasement"]),
    Entrance("Lethal Lava Land",            "lll",   (1169, 686), ["$CanAccessBasement"]),
    Entrance("Shifting Sand Land",          "ssl",   (1060, 822), ["$CanAccessBasement"]),
    Entrance("Dire, Dire Docks",            "ddd",   (1519, 994), ["$CanAccessBasement,$HasStars|B1Door"]),
    Entrance("Snowman's Land",              "sl",    (1104, 524), ["$CanAccessUpstairs"]),
    Entrance("Wet-Dry World",               "wdw",   (1420, 520), ["$CanAccessUpstairs"]),
    Entrance("Tall, Tall Mountain",         "ttm",   (1398, 336), ["$CanAccessUpstairs"]),
    Entrance("Tiny-Huge Island (Huge)",     "thih",  (1682, 648), ["$CanAccessUpstairs"]),
    Entrance("Tiny-Huge Island (Tiny)",     "thit",  (1682, 376), ["$CanAccessUpstairs"]),
    Entrance("Tick Tock Clock",             "ttc",   (1364, 104), [
        "$CanAccessUpstairs,$HasStars|F2Door,$HasMove|ledge_grab",
        "$CanAccessUpstairs,$HasStars|F2Door,$HasMove|triple_jump",
        "$CanAccessUpstairs,$HasStars|F2Door,$HasMove|side_flip",
        "$CanAccessUpstairs,$HasStars|F2Door,$HasMove|backflip",
        "$CanAccessUpstairs,$HasStars|F2Door,$HasMove|wall_jump",
    ]),
    Entrance("Rainbow Ride",                "rr",    (1587, 168), [
        "$CanAccessUpstairs,$HasStars|F2Door,$HasMove|triple_jump",
        "$CanAccessUpstairs,$HasStars|F2Door,$HasMove|side_flip",
        "$CanAccessUpstairs,$HasStars|F2Door,$HasMove|backflip",
    ]),
    Entrance("Bowser in the Dark World",    "bitdw", (322,  308), ["$HasStars|F1Door"]),
    Entrance("Bowser in the Fire Sea",      "bitfs", (1565, 994), [
        "$CanAccessBasement,$HasStars|B1Door,$HasCompleted|DIRE_DIRE_DOCKS>BOARD_BOWSER'S_SUB"
    ]),
#   Entrance("Bowser in the Sky",           "bits",  (1366, 520)),  # Not randomized
    Entrance("Tower of the Wing Cap",       "totwc", (286,  814), ["$HasStars|10"]),
    Entrance("Cavern of the Metal Cap",     "cotmc", (910,  143), ["^$CanAccessHMC"]),
    Entrance("Vanish Cap under the Moat",   "vcutm", (1828, 885), ["$CanAccessBasement,$HasMove|ground_pound"]),
    Entrance("Peach's Secret Slide",        "pss",   (648,  762), ["$HasStars|1"]),
    Entrance("Secret Aquarium",             "sa",    (456,  874), [
        "$HasStars|3,^$HasLooseMove|triple_jump",
        "$HasStars|3,$HasMove|triple_jump,$HasMove|ledge_grab",
        "$HasStars|3,$HasMove|side_flip",
        "$HasStars|3,$HasMove|backflip",
    ]),
    Entrance("Wing Mario over the Rainbow", "wmotr", (1142, 168), [
        "$CanAccessUpstairs,$HasStars|F2Door,$HasMove|triple_jump",
        "$CanAccessUpstairs,$HasStars|F2Door,$HasMove|side_flip",
        "$CanAccessUpstairs,$HasStars|F2Door,$HasMove|backflip",
    ]),
]
