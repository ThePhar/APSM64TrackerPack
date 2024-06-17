from enum import Enum
from typing import Literal, NamedTuple, Optional

type Region = Literal[
    "Bob-omb Battlefield",
    "Whomp's Fortress",
    "Jolly Roger Bay",
    "Cool, Cool Mountain",
    "Big Boo's Haunt",
    "Hazy Maze Cave",
    "Lethal Lava Land",
    "Shifting Sand Land",
    "Dire, Dire Docks",
    "Snowman's Land",
    "Wet-Dry World",
    "Tall, Tall Mountain",
    "Tiny-Huge Island",
    "Tick Tock Clock",
    "Rainbow Ride",
    "Bowser in the Dark World",
    "Bowser in the Fire Sea",
    "Bowser in the Sky",
    "Tower of the Wing Cap",
    "Cavern of the Metal Cap",
    "Vanish Cap under the Moat",
    "Peach's Secret Slide",
    "Secret Aquarium",
    "Wing Mario over the Rainbow",
    "Peach's Castle"
]

class LocationType(Enum):
    Star = 0
    Coin = 1
    Buddy = 2
    Key = 3
    WingCap = 4
    MetalCap = 5
    VanishCap = 6
    Block = 7


class Location(NamedTuple):
    region: Region
    name: str
    code: int
    type: LocationType = LocationType.Star
    coords: tuple[int, int] = (0, 0)
    access_rules: list[str] = []

    def get_code_name(self):
        region = self.region.upper().replace(" ", "_").replace(",", "")
        name = self.name.upper().replace(" ", "_").replace(",", "")
        return f"{region}>{name}"

    def checked_img(self):
        match self.type:
            case LocationType.Star:
                return "images/star_collected.png"
            case LocationType.Coin:
                return "images/star_collected.png"
            case LocationType.Buddy:
                return "images/buddy_checked.png"
            case LocationType.Key:
                return "images/keys/key_checked.png"
            case LocationType.WingCap:
                return "images/blocks/block_checked.png"
            case LocationType.MetalCap:
                return "images/blocks/block_checked.png"
            case LocationType.VanishCap:
                return "images/blocks/block_checked.png"
            case LocationType.Block:
                return "images/blocks/block_checked.png"

    def missing_img(self):
        match self.type:
            case LocationType.Star:
                return "images/star.png"
            case LocationType.Coin:
                return "images/coin.png"
            case LocationType.Buddy:
                return "images/buddy.png"
            case LocationType.Key:
                return "images/keys/key.png"
            case LocationType.WingCap:
                return "images/blocks/block_red.png"
            case LocationType.MetalCap:
                return "images/blocks/block_green.png"
            case LocationType.VanishCap:
                return "images/blocks/block_blue.png"
            case LocationType.Block:
                return "images/blocks/block.png"

    def visibility_rules(self):
        match self.type:
            case LocationType.Coin:
                return ["$IncludeHundredCoins"]
            case LocationType.Block:
                return ["$IncludeOneUpBlocks"]
            case LocationType.Buddy:
                return ["$IncludeBuddies"]

        return []

    def in_region(self, region: str):
        if region.startswith("Tiny-Huge Island"):
            region = "Tiny-Huge Island"

        return self.region == region



locations: list[Location] = [
    # BOB
    Location("Bob-omb Battlefield",         "Big Bob-omb on the Summit",                  3626000),
    Location("Bob-omb Battlefield",         "Footrace with Koopa the Quick",              3626001),
    Location("Bob-omb Battlefield",         "Shoot to the Island in the Sky",             3626002,
             access_rules=[
                 "$HasCannon|bob",
                 "^$IsCannonless,$HasCap|wing,$HasMove|triple_jump",
                 "^$IsCannonless,^$IsCapless,$HasMove|long_jump"
             ]),
    Location("Bob-omb Battlefield",         "Find the 8 Red Coins",                       3626003,
             access_rules=[
                 "$HasCannon|bob",
                 "^$IsCannonless,$HasCap|wing,$HasMove|triple_jump",
                 "^$IsCannonless,^$IsCapless,$HasMove|long_jump"
             ]),
    Location("Bob-omb Battlefield",         "Mario Wings to the Sky",                     3626004,
             access_rules=[
                 "$HasCannon|bob,$HasCap|wing",
                 "$HasCannon|bob,^$IsCapless",
             ]),
    Location("Bob-omb Battlefield",         "Behind Chain Chomp's Gate",                  3626005,
             access_rules=[
                 "$HasMove|ground_pound",
                 "^$IsMoveless"
             ]),
    Location("Bob-omb Battlefield",         "100 Coins Star",                             3626006, LocationType.Coin,
             access_rules=[
                 "$HasCannon|bob,$HasCap|wing",
                 "^$IsCannonless,$HasCap|wing,$HasMove|triple_jump"
             ]),
    Location("Bob-omb Battlefield",         "Bob-omb Buddy",                              3626200, LocationType.Buddy),

    # WF
    Location("Whomp's Fortress",            "Chip off Whomp's Block",                     3626007,
             access_rules=[
                 "$HasMove|ground_pound"
             ]),
    Location("Whomp's Fortress",            "To the Top of the Fortress",                 3626008,
             access_rules=[
                 "$HasMove|ground_pound"
             ]),
    Location("Whomp's Fortress",            "Shoot into the Wild Blue",                   3626009,
             access_rules=[
                 "$HasMove|wall_jump,$HasMove|triple_jump",
                 "$HasMove|wall_jump,$HasMove|side_flip",
                 "$HasCannon|wf"
             ]),
    Location("Whomp's Fortress",            "Red Coins on the Floating Isle",             3626010),
    Location("Whomp's Fortress",            "Fall onto the Caged Island",                 3626011,
             access_rules=[
                 "$HasMove|ground_pound,$HasMove|climb",
                 "^$IsMoveless,$HasMove|triple_jump",
                 "^$IsMoveless,$HasMove|long_jump",
                 "^$IsMoveless,$HasCannon|wf",
             ]),
    Location("Whomp's Fortress",            "Blast Away the Wall",                        3626012,
             access_rules=[
                 "$HasCannon|wf",
                 "^$IsCannonless,$HasMove|ledge_grab"
             ]),
    Location("Whomp's Fortress",            "100 Coins Star",                             3626013, LocationType.Coin,
             access_rules=[
                 "$HasMove|ground_pound",
                 "^$IsMoveless",
             ]),
    Location("Whomp's Fortress",            "Bob-omb Buddy",                              3626201, LocationType.Buddy,
             access_rules=[
                 "$HasMove|ground_pound"
             ]),

    # JRB
    Location("Jolly Roger Bay",             "Plunder in the Sunken Ship",                 3626014),
    Location("Jolly Roger Bay",             "Can the Eel Come out to Play?",              3626015),
    Location("Jolly Roger Bay",             "Treasure of the Ocean Cave",                 3626016),
    Location("Jolly Roger Bay",             "Red Coins on the Ship Afloat",               3626017,
             access_rules=[
                 "^$CanAccessJRBShip,$HasMove|climb",
                 "^$CanAccessJRBShip,$HasMove|triple_jump",
                 "^$CanAccessJRBShip,$HasCannon|jrb",
                 "^$CanAccessJRBShip,^$IsMoveless,$HasMove|backflip",
                 "^$CanAccessJRBShip,^$IsMoveless,$HasMove|wall_jump",
             ]),
    Location("Jolly Roger Bay",             "Blast to the Stone Pillar",                  3626018,
             access_rules=[
                 "$HasCannon|jrb,$HasMove|climb",
                 "$HasCannon|jrb,^$IsMoveless",
                 "^$IsCannonless,^$IsMoveless",
             ]),
    Location("Jolly Roger Bay",             "Through the Jet Stream",                     3626019,
             access_rules=[
                 "$HasCap|metal",
                 "^$IsCapless"
             ]),
    Location("Jolly Roger Bay",             "100 Coins Star",                             3626020, LocationType.Coin,
             access_rules=[
                 "^$CanAccessJRBShip,$HasMove|ground_pound"
             ]),
    Location("Jolly Roger Bay",             "Bob-omb Buddy",                              3626202, LocationType.Buddy),

    # CCM
    Location("Cool, Cool Mountain",         "Slip Slidin' Away",                          3626021),
    Location("Cool, Cool Mountain",         "Li'l Penguin Lost",                          3626022),
    Location("Cool, Cool Mountain",         "Big Penguin Race",                           3626023),
    Location("Cool, Cool Mountain",         "Frosty Slide for 8 Red Coins",               3626024),
    Location("Cool, Cool Mountain",         "Snowman's Lost his Head",                    3626025),
    Location("Cool, Cool Mountain",         "Wall Kicks will Work",                       3626026,
             access_rules=[
                 "$HasCannon|ccm,$HasMove|triple_jump",
                 "$HasCannon|ccm,$HasMove|wall_jump",
                 "^$IsCannonless,$HasMove|triple_jump",
                 "^$IsCannonless,$HasMove|wall_jump",
                 "^$IsMoveless"
             ]),
    Location("Cool, Cool Mountain",         "100 Coins Star",                             3626027, LocationType.Coin),
    Location("Cool, Cool Mountain",         "Bob-omb Buddy",                              3626203, LocationType.Buddy),
    Location("Cool, Cool Mountain",         "1-Up Block Near Snowman",                    3626215, LocationType.Block),
    Location("Cool, Cool Mountain",         "1-Up Block Near Ice Pillar",                 3626216, LocationType.Block),
    Location("Cool, Cool Mountain",         "1-Up Block in Secret Slide",                 3626217, LocationType.Block),

    # BBH
    Location("Big Boo's Haunt",             "Go on a Ghost Hunt",                         3626028),
    Location("Big Boo's Haunt",             "Ride Big Boo's Merry-Go-Round",              3626029),
    Location("Big Boo's Haunt",             "Secret of the Haunted Books",                3626030,
             access_rules=[
                 "$HasMove|kick",
                 "^$IsMoveless"
             ]),
    Location("Big Boo's Haunt",             "Seek the 8 Red Coins",                       3626031,
             access_rules=[
                 "$HasMove|backflip",
                 "$HasMove|wall_jump",
                 "$HasMove|triple_jump",
                 "$HasMove|side_flip",
             ]),
    Location("Big Boo's Haunt",             "Big Boo's Balcony",                          3626032,
             access_rules=[
                 "^$CanAccessBBHRoof"
             ]),
    Location("Big Boo's Haunt",             "Eye to Eye in the Secret Room",              3626033,
             access_rules=[
                 "^$CanAccessBBHThirdFloor,$HasCap|vanish"
             ]),
    Location("Big Boo's Haunt",             "100 Coins Star",                             3626034, LocationType.Coin),
    Location("Big Boo's Haunt",             "1-Up Block on Top of the Mansion",           3626218, LocationType.Block,
             access_rules=[
                 "^$CanAccessBBHRoof"
             ]),

    # HMC
    Location("Hazy Maze Cave",              "Swimming Beast in the Cavern",               3626035),
    Location("Hazy Maze Cave",              "Elevate for 8 Red Coins",                    3626036,
             access_rules=[
                 "^$CanAccessHMCRedCoinsArea"
             ]),
    Location("Hazy Maze Cave",              "Metal-Head Mario Can Move!",                 3626037,
             access_rules=[
                 "$HasMove|long_jump,$HasCap|metal",
                 "^$IsCapless,$HasMove|long_jump,$HasMove|triple_jump",
                 "^$IsCapless,^$IsMoveless,$HasMove|triple_jump",
                 "^$IsCapless,^$IsMoveless,$HasMove|long_jump",
                 "^$IsCapless,^$IsMoveless,$HasMove|wall_jump",
             ]),
    Location("Hazy Maze Cave",              "Navigating the Toxic Maze",                  3626038,
             access_rules=[
                 "$HasMove|wall_jump",
                 "$HasMove|side_flip",
                 "$HasMove|backflip",
                 "$HasMove|triple_jump",
             ]),
    Location("Hazy Maze Cave",              "A-Maze-Ing Emergency Exit",                  3626039,
             access_rules=[
                 "^$CanAccessHMCPitIslands"
             ]),
    Location("Hazy Maze Cave",              "Watch for Rolling Rocks",                    3626040,
             access_rules=[
                 "$HasMove|wall_jump",
             ]),
    Location("Hazy Maze Cave",              "100 Coins Star",                             3626041, LocationType.Coin,
             access_rules=[
                 "^$CanAccessHMCRedCoinsArea"
             ]),
    Location("Hazy Maze Cave",              "1-Up Block Above the Pit",                   3626219, LocationType.Block, LocationType.Block,
             access_rules=[
                 "^$CanAccessHMCPitIslands,$HasMove|ground_pound"
             ]),
    Location("Hazy Maze Cave",              "1-Up Block Past Rolling Rocks",              3626220, LocationType.Block, LocationType.Block),

    # LLL
    Location("Lethal Lava Land",            "Boil the Big Bully",                         3626042),
    Location("Lethal Lava Land",            "Bully the Bullies",                          3626043),
    Location("Lethal Lava Land",            "8-Coin Puzzle with 15 Pieces",               3626044),
    Location("Lethal Lava Land",            "Red-Hot Log Rolling",                        3626045),
    Location("Lethal Lava Land",            "Hot-Foot-It into the Volcano",               3626046,
             access_rules=[
                 "$HasMove|climb",
             ]),
    Location("Lethal Lava Land",            "Elevator Tour in the Volcano",               3626047,
             access_rules=[
                 "$HasMove|climb",
             ]),
    Location("Lethal Lava Land",            "100 Coins Star",                             3626048, LocationType.Coin),

    # SSL
    Location("Shifting Sand Land",          "In the Talons of the Big Bird",              3626049),
    Location("Shifting Sand Land",          "Shining Atop the Pyramid",                   3626050),
    Location("Shifting Sand Land",          "Inside the Ancient Pyramid",                 3626051,
             access_rules=[
                 "^$CanAccessSSLUpperPyramid"
             ]),
    Location("Shifting Sand Land",          "Stand Tall on the Four Pillars",             3626052,
             access_rules=[
                 "^$CanAccessSSLUpperPyramid,$HasMove|triple_jump,$HasCap|wing,$HasMove|ground_pound",
                 "^$CanAccessSSLUpperPyramid,$HasCannon|ssl,$HasCap|wing,$HasMove|ground_pound",
                 "^$CanAccessSSLUpperPyramid,^$IsCapless,$HasMove|triple_jump",
                 "^$CanAccessSSLUpperPyramid,^$IsCapless,$HasMove|side_flip",
                 "^$CanAccessSSLUpperPyramid,^$IsCapless,$HasMove|backflip",
                 "^$CanAccessSSLUpperPyramid,^$IsMoveless",
             ]),
    Location("Shifting Sand Land",          "Free Flying for 8 Red Coins",                3626053,
             access_rules=[
                 "$HasMove|triple_jump,$HasCap|wing",
                 "$HasCannon|ssl,$HasCap|wing",
                 "^$IsCapless,$HasMove|triple_jump",
                 "^$IsCapless,$HasMove|side_flip",
                 "^$IsCapless,$HasMove|backflip",
                 "^$IsCapless,^$IsMoveless"
             ]),
    Location("Shifting Sand Land",          "Pyramid Puzzle",                             3626054,
             access_rules=[
                 "^$CanAccessSSLUpperPyramid"
             ]),
    Location("Shifting Sand Land",          "100 Coins Star",                             3626055, LocationType.Coin,
             access_rules=[
                 "^$CanAccessSSLUpperPyramid,$HasMove|ground_pound"
             ]),
    Location("Shifting Sand Land",          "Bob-omb Buddy",                              3626207, LocationType.Buddy),
    Location("Shifting Sand Land",          "1-Up Block Outside Pyramid",                 3626221, LocationType.Block),
    Location("Shifting Sand Land",          "1-Up Block in the Pyramid's Left Path",      3626222, LocationType.Block),
    Location("Shifting Sand Land",          "1-Up Block in the Pyramid's Back",           3626223, LocationType.Block),

    # DDD
    Location("Dire, Dire Docks",            "Board Bowser's Sub",                         3626056),
    Location("Dire, Dire Docks",            "Chests in the Current",                      3626057),
    Location("Dire, Dire Docks",            "Pole-Jumping for Red Coins",                 3626058,
             access_rules=[
                 "$HasMove|climb,$HasCompleted|BOWSER_IN_THE_FIRE_SEA>SECOND_BOWSER'S_KEY",
                 "^$IsMoveless,$HasMove|triple_jump,$HasMove|dive,$HasMove|ledge_grab,$HasMove|wall_jump",
             ]),
    Location("Dire, Dire Docks",            "Through the Jet Stream",                     3626059,
             access_rules=[
                 "$HasCap|metal",
                 "^$IsCapless"
             ]),
    Location("Dire, Dire Docks",            "The Manta Ray's Reward",                     3626060),
    Location("Dire, Dire Docks",            "Collect the Caps...",                        3626061,
             access_rules=[
                 "$HasCap|metal,$HasCap|vanish",
                 "^$IsCapless,$HasCap|vanish"
             ]),
    Location("Dire, Dire Docks",            "100 Coins Star",                             3626062, LocationType.Coin,
             access_rules=[
                 "$HasMove|climb,$HasCompleted|BOWSER_IN_THE_FIRE_SEA>SECOND_BOWSER'S_KEY,$HasMove|ground_pound",
                 "^$IsMoveless,$HasMove|triple_jump,$HasMove|dive,$HasMove|ledge_grab,$HasMove|wall_jump,$HasMove|ground_pound",
             ]),

    # SL
    Location("Snowman's Land",              "Snowman's Big Head",                         3626063,
             access_rules=[
                 "$HasMove|backflip",
                 "$HasMove|side_flip",
                 "$HasMove|triple_jump",
                 "$HasCannon|sl",
             ]),
    Location("Snowman's Land",              "Chill with the Bully",                       3626064),
    Location("Snowman's Land",              "In the Deep Freeze",                         3626065,
             access_rules=[
                 "$HasMove|backflip",
                 "$HasMove|side_flip",
                 "$HasMove|triple_jump",
                 "$HasMove|wall_jump",
                 "$HasMove|ledge_grab",
                 "$HasCannon|sl",
             ]),
    Location("Snowman's Land",              "Whirl from the Freezing Pond",               3626066),
    Location("Snowman's Land",              "Shell Shreddin' for Red Coins",              3626067),
    Location("Snowman's Land",              "Into the Igloo",                             3626068,
             access_rules=[
                 "$HasCap|vanish,$HasMove|triple_jump",
                 "$HasCap|vanish,$HasMove|side_flip",
                 "$HasCap|vanish,$HasMove|backflip",
                 "$HasCap|vanish,$HasMove|wall_jump",
                 "$HasCap|vanish,$HasMove|ledge_grab",
                 "$HasCap|vanish,^$IsMoveless"
             ]),
    Location("Snowman's Land",              "100 Coins Star",                             3626069, LocationType.Coin,
             access_rules=[
                 "$HasCap|vanish",
                 "^$IsCapless"
             ]),
    Location("Snowman's Land",              "Bob-omb Buddy",                              3626209, LocationType.Buddy),
    Location("Snowman's Land",              "1-Up Block Near Moneybags",                  3626224, LocationType.Block),
    Location("Snowman's Land",              "1-Up Block Inside the Igloo",                3626225, LocationType.Block),

    # WDW
    Location("Wet-Dry World",               "Shocking Arrow Lifts!",                      3626070,
             access_rules=[
                 "^$CanAccessWDWTop"
             ]),
    Location("Wet-Dry World",               "Top o' the Town",                            3626071,
             access_rules=[
                 "^$CanAccessWDWTop"
             ]),
    Location("Wet-Dry World",               "Secrets in the Shallows & Sky",              3626072,
             access_rules=[
                 "^$CanAccessWDWTop"
             ]),
    Location("Wet-Dry World",               "Express Elevator--Hurry Up!",                3626073),
    Location("Wet-Dry World",               "Go to Town for Red Coins",                   3626074,
             access_rules=[
                 "^$CanAccessWDWDowntown,$HasMove|wall_jump",
                 "^$CanAccessWDWDowntown,$HasMove|triple_jump,^$IsMoveless",
             ]),
    Location("Wet-Dry World",               "Quick Race Through Downtown!",               3626075,
             access_rules=[
                 "^$CanAccessWDWDowntown,$HasCap|vanish,$HasMove|wall_jump",
                 "^$CanAccessWDWDowntown,$HasCap|vanish,$HasMove|backflip",
                 "^$CanAccessWDWDowntown,$HasCap|vanish,$HasMove|triple_jump,$HasMove|ledge_grab",
                 "^$CanAccessWDWDowntown,$HasCap|vanish,$HasMove|triple_jump,^$IsMoveless",
             ]),
    Location("Wet-Dry World",               "100 Coins Star",                             3626076, LocationType.Coin,
             access_rules=[
                 "^$CanAccessWDWDowntown,$HasMove|ground_pound"
             ]),
    Location("Wet-Dry World",               "Bob-omb Buddy",                              3626210, LocationType.Buddy,
             access_rules=[
                 "^$CanAccessWDWTop,$HasMove|triple_jump",
                 "^$CanAccessWDWTop,$HasMove|side_flip,$HasMove|ledge_Grab",
                 "^$CanAccessWDWTop,$IsERDisabled,$HasMove|backflip",
                 "^$CanAccessWDWTop,$IsERDisabled,$HasMove|side_flip",
             ]),
    Location("Wet-Dry World",               "1-Up Block in the Downtown",                 3626226, LocationType.Block,
             access_rules=[
                 "^$CanAccessWDWDowntown"
             ]),

    # TTM
    Location("Tall, Tall Mountain",         "Scale the Mountain",                         3626077,
             access_rules=[
                 "^$CanAccessTTMTop",
             ]),
    Location("Tall, Tall Mountain",         "Mystery of the Monkey Cage",                 3626078,
             access_rules=[
                 "^$CanAccessTTMTop",
             ]),
    Location("Tall, Tall Mountain",         "Scary 'Shrooms, Red Coins",                  3626079),
    Location("Tall, Tall Mountain",         "Mysterious Mountainside",                    3626080,
             access_rules=[
                 "^$CanAccessTTMTop",
             ]),
    Location("Tall, Tall Mountain",         "Breathtaking View from Bridge",              3626081,
             access_rules=[
                 "^$CanAccessTTMTop",
             ]),
    Location("Tall, Tall Mountain",         "Blast to the Lonely Mushroom",               3626082,
             access_rules=[
                 "$HasCannon|ttm",
                 "^$IsCannonless,$HasMove|long_jump",
                 "^$IsCannonless,^$IsMoveless"
             ]),
    Location("Tall, Tall Mountain",         "100 Coins Star",                             3626083, LocationType.Coin),
    Location("Tall, Tall Mountain",         "Bob-omb Buddy",                              3626211, LocationType.Buddy),
    Location("Tall, Tall Mountain",         "1-Up Block on the Red Mushroom",             3626227, LocationType.Block),

    # THI
    Location("Tiny-Huge Island",            "Pluck the Piranha Flower",                   3626084,
             access_rules=[
                 "^$CanAccessTHIPipes",
             ]),
    Location("Tiny-Huge Island",            "The Tip Top of the Huge Island",             3626085,
             access_rules=[
                 "^$CanAccessTHIPipes",
             ]),
    Location("Tiny-Huge Island",            "Rematch with Koopa the Quick",               3626086,
             access_rules=[
                 "^$CanAccessTHIPipes",
             ]),
    Location("Tiny-Huge Island",            "Five Itty Bitty Secrets",                    3626087,
             access_rules=[
                 "^$CanAccessTHIPipes",
             ]),
    Location("Tiny-Huge Island",            "Wiggler's Red Coins",                        3626088,
             access_rules=[
                 "^$CanAccessTHIPipes,$HasMove|wall_jump",
             ]),
    Location("Tiny-Huge Island",            "Make Wiggler Squirm",                        3626089,
             access_rules=[
                 "^$CanAccessTHIHugeTop,$HasMove|ground_pound",
                 "^$CanAccessTHIHugeTop,^$IsMoveless,$HasMove|dive",
             ]),
    Location("Tiny-Huge Island",            "100 Coins Star",                             3626090, LocationType.Coin,
             access_rules=[
                 "^$CanAccessTHIHugeTop,$HasMove|ground_pound"
             ]),
    Location("Tiny-Huge Island",            "Bob-omb Buddy",                              3626212, LocationType.Buddy,
             access_rules=[
                 "^$CanAccessTHIPipes",
             ]),
    Location("Tiny-Huge Island",            "1-Up Block Near Tiny Start",                 3626228, LocationType.Block,
             access_rules=[
                 "^$CanAccessTHIPipes",
             ]),
    Location("Tiny-Huge Island",            "1-Up Block Near Huge Start",                 3626229, LocationType.Block,
             access_rules=[
                 "^$CanAccessTHIPipes",
             ]),
    Location("Tiny-Huge Island",            "1-Up Block in the Windy Area",               3626230, LocationType.Block,
             access_rules=[
                 "^$CanAccessTHIPipes",
             ]),

    # TTC
    Location("Tick Tock Clock",             "Roll into the Cage",                         3626091,
             access_rules=[
                 "^$CanAccessTTCLower",
             ]),
    Location("Tick Tock Clock",             "The Pit and the Pendulums",                  3626092,
             access_rules=[
                 "^$CanAccessTTCUpper",
             ]),
    Location("Tick Tock Clock",             "Get a Hand",                                 3626093,
             access_rules=[
                 "^$CanAccessTTCLower",
             ]),
    Location("Tick Tock Clock",             "Stomp on the Thwomp",                        3626094,
             access_rules=[
                 "^$CanAccessTTCTop",
             ]),
    Location("Tick Tock Clock",             "Timed Jumps on Moving Bars",                 3626095,
             access_rules=[
                 "^$CanAccessTTCUpper",
             ]),
    Location("Tick Tock Clock",             "Stop Time for Red Coins",                    3626096,
             access_rules=[
                 "^$CanAccessTTCLower",
                 "$IsERDisabled",
             ]),
    Location("Tick Tock Clock",             "100 Coins Star",                             3626097, LocationType.Coin,
             access_rules=[
                 "^$CanAccessTTCTop,$HasMove|ground_pound",
             ]),
    Location("Tick Tock Clock",             "1-Up Block Midway Up",                       3626231, LocationType.Block,
             access_rules=[
                 "^$CanAccessTTCTop",
             ]),
    Location("Tick Tock Clock",             "1-Up Block at the Top",                      3626232, LocationType.Block,
             access_rules=[
                 "^$CanAccessTTCTop",
             ]),

    # RR
    Location("Rainbow Ride",                "Cruiser Crossing the Rainbow",               3626098,
             access_rules=[
                 "$HasMove|wall_jump",
                 "$HasMove|side_flip",
                 "$HasMove|backflip",
                 "$HasMove|ledge_grab",
                 "$HasMove|triple_jump",
             ]),
    Location("Rainbow Ride",                "The Big House in the Sky",                   3626099,
             access_rules=[
                 "$HasMove|triple_jump",
                 "$HasMove|side_flip",
                 "$HasMove|backflip",
                 "$HasMove|ledge_grab",
             ]),
    Location("Rainbow Ride",                "Coins Amassed in a Maze",                    3626100,
             access_rules=[
                 "$HasMove|wall_jump",
                 "$HasMove|long_jump,$HasMove|side_flip",
                 "$HasMove|long_jump,$HasMove|backflip",
                 "$HasMove|long_jump,$HasMove|triple_jump",
                 "^$IsMoveless,$HasMove|ledge_grab",
                 "^$IsMoveless,$HasMove|triple_jump",
             ]),
    Location("Rainbow Ride",                "Swingin' in the Breeze",                     3626101,
             access_rules=[
                 "$HasMove|ledge_grab",
                 "$HasMove|triple_jump",
                 "$HasMove|backflip",
                 "$HasMove|side_flip",
                 "^$IsMoveless",
             ]),
    Location("Rainbow Ride",                "Tricky Triangles!",                          3626102,
             access_rules=[
                 "$HasMove|ledge_grab",
                 "$HasMove|triple_jump",
                 "$HasMove|backflip",
                 "$HasMove|side_flip",
                 "^$IsMoveless",
             ]),
    Location("Rainbow Ride",                "Somewhere over the Rainbow",                 3626103,
             access_rules=[
                 "$HasCannon|rr,$HasMove|wall_jump",
                 "$HasCannon|rr,$HasMove|side_flip",
                 "$HasCannon|rr,$HasMove|backflip",
                 "$HasCannon|rr,$HasMove|ledge_grab",
                 "$HasCannon|rr,$HasMove|triple_jump",
             ]),
    Location("Rainbow Ride",                "100 Coins Star",                             3626104, LocationType.Coin,
             access_rules=[
                 "$HasMove|wall_jump,$HasMove|ground_pound",
             ]),
    Location("Rainbow Ride",                "Bob-omb Buddy",                              3626214, LocationType.Buddy,
             access_rules=[
                 "$HasMove|wall_jump",
                 "^$IsMoveless,$HasMove|ledge_grab",
             ]),
    Location("Rainbow Ride",                "1-Up Block Above the Red Coin Maze",         3626233, LocationType.Block),
    Location("Rainbow Ride",                "1-Up Block Under Fly Guy",                   3626234, LocationType.Block),
    Location("Rainbow Ride",                "1-Up Block on the House in the Sky",         3626235, LocationType.Block,
             access_rules=[
                 "$HasMove|triple_jump",
                 "$HasMove|side_flip",
                 "$HasMove|backflip",
                 "$HasMove|ledge_grab",
             ]),

    # PSS
    Location("Peach's Secret Slide",        "End of the Slide Block",                     3626126),
    Location("Peach's Secret Slide",        "Finish under 21 Seconds",                    3626127),

    # SA
    Location("Secret Aquarium",             "The Aquarium Red Coins",                     3626161),

    # BitDW
    Location("Bowser in the Dark World",    "First Bowser's Key",                         3626178, LocationType.Key),
    Location("Bowser in the Dark World",    "Dark World Red Coins",                       3626105),
    Location("Bowser in the Dark World",    "1-Up Block on the Tower",                    3626236, LocationType.Block),
    Location("Bowser in the Dark World",    "1-Up Block Near the Goombas",                3626237, LocationType.Block),

    # BitFS
    Location("Bowser in the Fire Sea",      "Second Bowser's Key",                        3626179, LocationType.Key,
             access_rules=[
                 "$HasMove|climb",
             ]),
    Location("Bowser in the Fire Sea",      "Fire Sea Red Coins",                         3626112,
             access_rules=[
                 "$HasMove|climb,$HasMove|ledge_grab",
                 "$HasMove|climb,$HasMove|wall_jump",
             ]),
    Location("Bowser in the Fire Sea",      "1-Up Block on the Swaying Stairs",           3626238, LocationType.Block,
             access_rules=[
                 "$HasMove|climb",
             ]),
    Location("Bowser in the Fire Sea",      "1-Up Block Near the Poles",                  3626239, LocationType.Block,
             access_rules=[
                 "$HasMove|climb,$HasMove|ledge_grab",
                 "$HasMove|climb,$HasMove|wall_jump",
             ]),

    # BitS
    # Location("Bowser in the Sky",           "The Final Power Star",                             0,  # Event Only
    #          access_rules=[
    #              "$HasMove|climb,$HasMove|triple_jump",
    #              "$HasMove|climb,$HasMove|side_flip,$HasMove|ledge_grab",
    #              "^$IsMoveless,$HasMove|triple_jump,$HasMove|wall_jump,$HasMove|ledge_grab",
    #          ]),
    Location("Bowser in the Sky",           "Sky Red Coins",                              3626119,
             access_rules=[
                 "$HasMove|climb,$HasMove|triple_jump",
                 "$HasMove|climb,$HasMove|side_flip,$HasMove|ledge_grab",
                 "^$IsMoveless,$HasMove|triple_jump,$HasMove|wall_jump,$HasMove|ledge_grab",
             ]),
    Location("Bowser in the Sky",           "1-Up Block on the Rotating Platform",        3626240, LocationType.Block),

    # TotWC
    Location("Tower of the Wing Cap",       "Wing Cap Switch",                            3626181, LocationType.WingCap),
    Location("Tower of the Wing Cap",       "Tower Red Coins",                            3626140),

    # CotMC
    Location("Cavern of the Metal Cap",     "Metal Cap Switch",                           3626182, LocationType.MetalCap),
    Location("Cavern of the Metal Cap",     "Cavern Red Coins",                           3626133,
             access_rules=[
                 "$HasCap|metal",
                 "^$IsCapless",
             ]),
    Location("Cavern of the Metal Cap",     "1-Up Block Above the Rushing River",         3626241, LocationType.Block),

    # VCutM
    Location("Vanish Cap under the Moat",   "Vanish Cap Switch",                          3626183, LocationType.VanishCap,
             access_rules=[
                 "$HasMove|wall_jump",
                 "$HasMove|triple_jump",
                 "$HasMove|backflip",
                 "$HasMove|side_flip",
                 "$HasMove|ledge_grab",
                 "^$IsMoveless",
             ]),
    Location("Vanish Cap under the Moat",   "Moat Red Coins",                             3626147,
             access_rules=[
                 "$HasCap|vanish,$HasMove|wall_jump",
                 "$HasCap|vanish,$HasMove|triple_jump",
                 "$HasCap|vanish,$HasMove|backflip",
                 "$HasCap|vanish,$HasMove|side_flip",
                 "$HasCap|vanish,$HasMove|ledge_grab",
                 "^$IsCapless,$HasMove|wall_jump",
             ]),
    Location("Vanish Cap under the Moat",   "1-Up Block on the Slope Platform",           3626242, LocationType.Block),

    # WMotR
    Location("Wing Mario over the Rainbow", "Wing Mario Over the Rainbow Red Coins",      3626154,
             access_rules=[
                 "$HasMove|triple_jump,$HasCap|wing",
             ]),
    Location("Wing Mario over the Rainbow", "Wing Mario Over the Rainbow 1-Up Block",     3626243,
             access_rules=[
                 "$HasMove|triple_jump,$HasCap|wing",
             ]),

    # Castle
    Location("Peach's Castle",              "Basement Toad's Gift",                       3626168),
    Location("Peach's Castle",              "Second Floor Toad's Gift",                   3626169),
    Location("Peach's Castle",              "Third Floor Toad's Gift",                    3626170),
    Location("Peach's Castle",              "MIPS the Rabbit",                            3626171),
    Location("Peach's Castle",              "MIPS the Rabbit II",                         3626172),
]
items = [
    {
        "name": "Enter Stage and Set Entrance",
        "type": "toggle",
        "codes": "__unknown_er",
    },
    *[{
        "name": location.name,
        "type": "toggle",
        "codes": location.get_code_name(),
        "img": location.checked_img(),
        "disabled_img": location.missing_img(),
        "disabled_img_mods": "none"
    } for location in locations]
]
