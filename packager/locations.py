from enum import IntEnum, auto
from typing import NamedTuple

from packager.types import AreaName


class LocationType(IntEnum):
    Star = auto()
    Coin = auto()
    RedCoin = auto()
    Buddy = auto()
    Key = auto()
    WingCap = auto()
    MetalCap = auto()
    VanishCap = auto()
    Block = auto()


class Location(NamedTuple):
    name: str
    area: AreaName
    code: int
    type: LocationType
    access_rules: list[str] = []
    # coords: tuple[int, int] = (0, 0)

    class Icon(NamedTuple):
        checked: str
        missing: str

    @property
    def item_codes(self) -> str:
        return f"__location_item_{self.code}"

    @property
    def visibility_rules(self) -> list[str]:
        match self.type:
            case LocationType.Coin:
                return ["$ShowCoinStars"]
            case LocationType.Buddy:
                return ["$ShowBuddies"]
            case LocationType.Block:
                return ["$ShowBlocks"]

        return []

    @property
    def image(self) -> Icon:
        match self.type:
            case LocationType.Star:
                return self.Icon("images/star.png", "images/star_collected.png")
            case LocationType.Coin:
                return self.Icon("images/star_coin.png", "images/star_collected.png")
            case LocationType.RedCoin:
                return self.Icon("images/star_red.png", "images/star_collected.png")
            case LocationType.Buddy:
                return self.Icon("images/buddy.png", "images/buddy_checked.png")
            case LocationType.Key:
                return self.Icon("images/keys/key.png", "images/keys/key_checked.png")
            case LocationType.WingCap:
                return self.Icon("images/blocks/block_red.png", "images/blocks/block_checked.png")
            case LocationType.MetalCap:
                return self.Icon("images/blocks/block_green.png", "images/blocks/block_checked.png")
            case LocationType.VanishCap:
                return self.Icon("images/blocks/block_blue.png", "images/blocks/block_checked.png")
            case LocationType.Block:
                return self.Icon("images/blocks/block_1up.png", "images/blocks/block_checked.png")

        raise TypeError(f"Unknown location type: {self.type.name}")


# fmt: off
locations: list[Location] = [
    # 1. Bob-omb Battlefield
    Location("Big Bob-omb on the Summit",              "Bob-omb Battlefield",         3626000, LocationType.Star),
    Location("Footrace with Koopa the Quick",          "Bob-omb Battlefield",         3626001, LocationType.Star),
    Location("Shoot to the Island in the Sky",         "Bob-omb Battlefield",         3626002, LocationType.Star,      ["^$CanAccessBOBIsland"]),
    Location("Find the 8 Red Coins",                   "Bob-omb Battlefield",         3626003, LocationType.RedCoin,   ["^$CanAccessBOBIsland"]),
    Location("Mario Wings to the Sky",                 "Bob-omb Battlefield",         3626004, LocationType.Star,      ["^$CanAccessBOBWings"]),
    Location("Behind Chain Chomp's Gate",              "Bob-omb Battlefield",         3626005, LocationType.Star,      ["^$CanAccessBOBChainChomp"]),
    Location("100 Coins Star",                         "Bob-omb Battlefield",         3626006, LocationType.Coin,      ["^$CanAccessBOBCoins"]),
    Location("Bob-omb Buddy",                          "Bob-omb Battlefield",         3626200, LocationType.Buddy),

    # 2. Whomp's Fortress
    Location("Chip off Whomp's Block",                 "Whomp's Fortress",            3626007, LocationType.Star,      ["^$CanAccessWFTower"]),
    Location("To the Top of the Fortress",             "Whomp's Fortress",            3626008, LocationType.Star,      ["^$CanAccessWFTower"]),
    Location("Shoot into the Wild Blue",               "Whomp's Fortress",            3626009, LocationType.Star,      ["^$CanAccessWFWildBlue"]),
    Location("Red Coins on the Floating Isle",         "Whomp's Fortress",            3626010, LocationType.RedCoin),
    Location("Fall onto the Caged Island",             "Whomp's Fortress",            3626011, LocationType.Star,      ["^$CanAccessWFCagedIsland"]),
    Location("Blast Away the Wall",                    "Whomp's Fortress",            3626012, LocationType.Star,      ["^$CanAccessWFWall"]),
    Location("100 Coins Star",                         "Whomp's Fortress",            3626013, LocationType.Coin,      ["^$CanAccessWFCoins"]),
    Location("Bob-omb Buddy",                          "Whomp's Fortress",            3626201, LocationType.Buddy,     ["^$CanAccessWFTower"]),


    Location("Plunder in the Sunken Ship",             "Jolly Roger Bay",             3626014, LocationType.Star,      []),
    Location("Can the Eel Come out to Play?",          "Jolly Roger Bay",             3626015, LocationType.Star,      []),
    Location("Treasure of the Ocean Cave",             "Jolly Roger Bay",             3626016, LocationType.Star,      []),
    Location("Red Coins on the Ship Afloat",           "Jolly Roger Bay",             3626017, LocationType.RedCoin,   []),
    Location("Blast to the Stone Pillar",              "Jolly Roger Bay",             3626018, LocationType.Star,      []),
    Location("Through the Jet Stream",                 "Jolly Roger Bay",             3626019, LocationType.Star,      []),
    Location("100 Coins Star",                         "Jolly Roger Bay",             3626020, LocationType.Coin,      []),
    Location("Bob-omb Buddy",                          "Jolly Roger Bay",             3626202, LocationType.Buddy,     []),
    Location("Slip Slidin' Away",                      "Cool, Cool Mountain",         3626021, LocationType.Star,      []),
    Location("Li'l Penguin Lost",                      "Cool, Cool Mountain",         3626022, LocationType.Star,      []),
    Location("Big Penguin Race",                       "Cool, Cool Mountain",         3626023, LocationType.Star,      []),
    Location("Frosty Slide for 8 Red Coins",           "Cool, Cool Mountain",         3626024, LocationType.RedCoin,   []),
    Location("Snowman's Lost his Head",                "Cool, Cool Mountain",         3626025, LocationType.Star,      []),
    Location("Wall Kicks will Work",                   "Cool, Cool Mountain",         3626026, LocationType.Star,      []),
    Location("100 Coins Star",                         "Cool, Cool Mountain",         3626027, LocationType.Coin,      []),
    Location("Bob-omb Buddy",                          "Cool, Cool Mountain",         3626203, LocationType.Buddy,     []),
    Location("1-Up Block Near Snowman",                "Cool, Cool Mountain",         3626215, LocationType.Block,     []),
    Location("1-Up Block Near Ice Pillar",             "Cool, Cool Mountain",         3626216, LocationType.Block,     []),
    Location("1-Up Block in Secret Slide",             "Cool, Cool Mountain",         3626217, LocationType.Block,     []),
    Location("Go on a Ghost Hunt",                     "Big Boo's Haunt",             3626028, LocationType.Star,      []),
    Location("Ride Big Boo's Merry-Go-Round",          "Big Boo's Haunt",             3626029, LocationType.Star,      []),
    Location("Secret of the Haunted Books",            "Big Boo's Haunt",             3626030, LocationType.Star,      []),
    Location("Seek the 8 Red Coins",                   "Big Boo's Haunt",             3626031, LocationType.RedCoin,   []),
    Location("Big Boo's Balcony",                      "Big Boo's Haunt",             3626032, LocationType.Star,      []),
    Location("Eye to Eye in the Secret Room",          "Big Boo's Haunt",             3626033, LocationType.Star,      []),
    Location("100 Coins Star",                         "Big Boo's Haunt",             3626034, LocationType.Coin,      []),
    Location("1-Up Block on Top of the Mansion",       "Big Boo's Haunt",             3626218, LocationType.Block,     []),
    Location("Swimming Beast in the Cavern",           "Hazy Maze Cave",              3626035, LocationType.Star,      []),
    Location("Elevate for 8 Red Coins",                "Hazy Maze Cave",              3626036, LocationType.RedCoin,   []),
    Location("Metal-Head Mario Can Move!",             "Hazy Maze Cave",              3626037, LocationType.Star,      []),
    Location("Navigating the Toxic Maze",              "Hazy Maze Cave",              3626038, LocationType.Star,      []),
    Location("A-Maze-Ing Emergency Exit",              "Hazy Maze Cave",              3626039, LocationType.Star,      []),
    Location("Watch for Rolling Rocks",                "Hazy Maze Cave",              3626040, LocationType.Star,      []),
    Location("100 Coins Star",                         "Hazy Maze Cave",              3626041, LocationType.Coin,      []),
    Location("1-Up Block Above the Pit",               "Hazy Maze Cave",              3626219, LocationType.Block,     []),
    Location("1-Up Block Past Rolling Rocks",          "Hazy Maze Cave",              3626220, LocationType.Block,     []),
    Location("Boil the Big Bully",                     "Lethal Lava Land",            3626042, LocationType.Star,      []),
    Location("Bully the Bullies",                      "Lethal Lava Land",            3626043, LocationType.Star,      []),
    Location("8-Coin Puzzle with 15 Pieces",           "Lethal Lava Land",            3626044, LocationType.RedCoin,   []),
    Location("Red-Hot Log Rolling",                    "Lethal Lava Land",            3626045, LocationType.Star,      []),
    Location("Hot-Foot-It into the Volcano",           "Lethal Lava Land",            3626046, LocationType.Star,      []),
    Location("Elevator Tour in the Volcano",           "Lethal Lava Land",            3626047, LocationType.Star,      []),
    Location("100 Coins Star",                         "Lethal Lava Land",            3626048, LocationType.Coin,      []),
    Location("In the Talons of the Big Bird",          "Shifting Sand Land",          3626049, LocationType.Star,      []),
    Location("Shining Atop the Pyramid",               "Shifting Sand Land",          3626050, LocationType.Star,      []),
    Location("Inside the Ancient Pyramid",             "Shifting Sand Land",          3626051, LocationType.Star,      []),
    Location("Stand Tall on the Four Pillars",         "Shifting Sand Land",          3626052, LocationType.Star,      []),
    Location("Free Flying for 8 Red Coins",            "Shifting Sand Land",          3626053, LocationType.RedCoin,   []),
    Location("Pyramid Puzzle",                         "Shifting Sand Land",          3626054, LocationType.Star,      []),
    Location("100 Coins Star",                         "Shifting Sand Land",          3626055, LocationType.Coin,      []),
    Location("Bob-omb Buddy",                          "Shifting Sand Land",          3626207, LocationType.Buddy,     []),
    Location("1-Up Block Outside Pyramid",             "Shifting Sand Land",          3626221, LocationType.Block,     []),
    Location("1-Up Block in the Pyramid's Left Path",  "Shifting Sand Land",          3626222, LocationType.Block,     []),
    Location("1-Up Block in the Pyramid's Back",       "Shifting Sand Land",          3626223, LocationType.Block,     []),
    Location("Board Bowser's Sub",                     "Dire, Dire Docks",            3626056, LocationType.Star,      []),
    Location("Chests in the Current",                  "Dire, Dire Docks",            3626057, LocationType.Star,      []),
    Location("Pole-Jumping for Red Coins",             "Dire, Dire Docks",            3626058, LocationType.RedCoin,   []),
    Location("Through the Jet Stream",                 "Dire, Dire Docks",            3626059, LocationType.Star,      []),
    Location("The Manta Ray's Reward",                 "Dire, Dire Docks",            3626060, LocationType.Star,      []),
    Location("Collect the Caps...",                    "Dire, Dire Docks",            3626061, LocationType.Star,      []),
    Location("100 Coins Star",                         "Dire, Dire Docks",            3626062, LocationType.Coin,      []),
    Location("Snowman's Big Head",                     "Snowman's Land",              3626063, LocationType.Star,      []),
    Location("Chill with the Bully",                   "Snowman's Land",              3626064, LocationType.Star,      []),
    Location("In the Deep Freeze",                     "Snowman's Land",              3626065, LocationType.Star,      []),
    Location("Whirl from the Freezing Pond",           "Snowman's Land",              3626066, LocationType.Star,      []),
    Location("Shell Shreddin' for Red Coins",          "Snowman's Land",              3626067, LocationType.RedCoin,   []),
    Location("Into the Igloo",                         "Snowman's Land",              3626068, LocationType.Star,      []),
    Location("100 Coins Star",                         "Snowman's Land",              3626069, LocationType.Coin,      []),
    Location("Bob-omb Buddy",                          "Snowman's Land",              3626209, LocationType.Buddy,     []),
    Location("1-Up Block Near Moneybags",              "Snowman's Land",              3626224, LocationType.Block,     []),
    Location("1-Up Block Inside the Igloo",            "Snowman's Land",              3626225, LocationType.Block,     []),
    Location("Shocking Arrow Lifts!",                  "Wet-Dry World",               3626070, LocationType.Star,      []),
    Location("Top o' the Town",                        "Wet-Dry World",               3626071, LocationType.Star,      []),
    Location("Secrets in the Shallows & Sky",          "Wet-Dry World",               3626072, LocationType.Star,      []),
    Location("Express Elevator--Hurry Up!",            "Wet-Dry World",               3626073, LocationType.Star,      []),
    Location("Go to Town for Red Coins",               "Wet-Dry World",               3626074, LocationType.RedCoin,   []),
    Location("Quick Race Through Downtown!",           "Wet-Dry World",               3626075, LocationType.Star,      []),
    Location("100 Coins Star",                         "Wet-Dry World",               3626076, LocationType.Coin,      []),
    Location("Bob-omb Buddy",                          "Wet-Dry World",               3626210, LocationType.Buddy,     []),
    Location("1-Up Block in the Downtown",             "Wet-Dry World",               3626226, LocationType.Block,     []),
    Location("Scale the Mountain",                     "Tall, Tall Mountain",         3626077, LocationType.Star,      []),
    Location("Mystery of the Monkey Cage",             "Tall, Tall Mountain",         3626078, LocationType.Star,      []),
    Location("Scary 'Shrooms, Red Coins",              "Tall, Tall Mountain",         3626079, LocationType.RedCoin,   []),
    Location("Mysterious Mountainside",                "Tall, Tall Mountain",         3626080, LocationType.Star,      []),
    Location("Breathtaking View from Bridge",          "Tall, Tall Mountain",         3626081, LocationType.Star,      []),
    Location("Blast to the Lonely Mushroom",           "Tall, Tall Mountain",         3626082, LocationType.Star,      []),
    Location("100 Coins Star",                         "Tall, Tall Mountain",         3626083, LocationType.Coin,      []),
    Location("Bob-omb Buddy",                          "Tall, Tall Mountain",         3626211, LocationType.Buddy,     []),
    Location("1-Up Block on the Red Mushroom",         "Tall, Tall Mountain",         3626227, LocationType.Block,     []),
    Location("Pluck the Piranha Flower",               "Tiny-Huge Island",            3626084, LocationType.Star,      []),
    Location("The Tip Top of the Huge Island",         "Tiny-Huge Island",            3626085, LocationType.Star,      []),
    Location("Rematch with Koopa the Quick",           "Tiny-Huge Island",            3626086, LocationType.Star,      []),
    Location("Five Itty Bitty Secrets",                "Tiny-Huge Island",            3626087, LocationType.Star,      []),
    Location("Wiggler's Red Coins",                    "Tiny-Huge Island",            3626088, LocationType.RedCoin,   []),
    Location("Make Wiggler Squirm",                    "Tiny-Huge Island",            3626089, LocationType.Star,      []),
    Location("100 Coins Star",                         "Tiny-Huge Island",            3626090, LocationType.Coin,      []),
    Location("Bob-omb Buddy",                          "Tiny-Huge Island",            3626212, LocationType.Buddy,     []),
    Location("1-Up Block Near Tiny Start",             "Tiny-Huge Island",            3626228, LocationType.Block,     []),
    Location("1-Up Block Near Huge Start",             "Tiny-Huge Island",            3626229, LocationType.Block,     []),
    Location("1-Up Block in the Windy Area",           "Tiny-Huge Island",            3626230, LocationType.Block,     []),
    Location("Roll into the Cage",                     "Tick Tock Clock",             3626091, LocationType.Star,      []),
    Location("The Pit and the Pendulums",              "Tick Tock Clock",             3626092, LocationType.Star,      []),
    Location("Get a Hand",                             "Tick Tock Clock",             3626093, LocationType.Star,      []),
    Location("Stomp on the Thwomp",                    "Tick Tock Clock",             3626094, LocationType.Star,      []),
    Location("Timed Jumps on Moving Bars",             "Tick Tock Clock",             3626095, LocationType.Star,      []),
    Location("Stop Time for Red Coins",                "Tick Tock Clock",             3626096, LocationType.RedCoin,   []),
    Location("100 Coins Star",                         "Tick Tock Clock",             3626097, LocationType.Coin,      []),
    Location("1-Up Block Midway Up",                   "Tick Tock Clock",             3626231, LocationType.Block,     []),
    Location("1-Up Block at the Top",                  "Tick Tock Clock",             3626232, LocationType.Block,     []),
    Location("Cruiser Crossing the Rainbow",           "Rainbow Ride",                3626098, LocationType.Star,      []),
    Location("The Big House in the Sky",               "Rainbow Ride",                3626099, LocationType.Star,      []),
    Location("Coins Amassed in a Maze",                "Rainbow Ride",                3626100, LocationType.RedCoin,   []),
    Location("Swingin' in the Breeze",                 "Rainbow Ride",                3626101, LocationType.Star,      []),
    Location("Tricky Triangles!",                      "Rainbow Ride",                3626102, LocationType.Star,      []),
    Location("Somewhere over the Rainbow",             "Rainbow Ride",                3626103, LocationType.Star,      []),
    Location("100 Coins Star",                         "Rainbow Ride",                3626104, LocationType.Coin,      []),
    Location("Bob-omb Buddy",                          "Rainbow Ride",                3626214, LocationType.Buddy,     []),
    Location("1-Up Block Above the Red Coin Maze",     "Rainbow Ride",                3626233, LocationType.Block,     []),
    Location("1-Up Block Under Fly Guy",               "Rainbow Ride",                3626234, LocationType.Block,     []),
    Location("1-Up Block on the House in the Sky",     "Rainbow Ride",                3626235, LocationType.Block,     []),
    Location("End of the Slide Block",                 "Princess's Secret Slide",     3626126, LocationType.Star,      []),
    Location("Finish under 21 Seconds",                "Princess's Secret Slide",     3626127, LocationType.Star,      []),
    Location("The Aquarium Red Coins",                 "Secret Aquarium",             3626161, LocationType.RedCoin,   []),
    Location("First Bowser's Key",                     "Bowser in the Dark World",    3626178, LocationType.Key,       []),
    Location("Dark World Red Coins",                   "Bowser in the Dark World",    3626105, LocationType.RedCoin,   []),
    Location("1-Up Block on the Tower",                "Bowser in the Dark World",    3626236, LocationType.Block,     []),
    Location("1-Up Block Near the Goombas",            "Bowser in the Dark World",    3626237, LocationType.Block,     []),
    Location("Second Bowser's Key",                    "Bowser in the Fire Sea",      3626179, LocationType.Key,       []),
    Location("Fire Sea Red Coins",                     "Bowser in the Fire Sea",      3626112, LocationType.RedCoin,   []),
    Location("1-Up Block on the Swaying Stairs",       "Bowser in the Fire Sea",      3626238, LocationType.Block,     []),
    Location("1-Up Block Near the Poles",              "Bowser in the Fire Sea",      3626239, LocationType.Block,     []),
    Location("Sky Red Coins",                          "Bowser in the Sky",           3626119, LocationType.RedCoin,   []),
    Location("1-Up Block on the Rotating Platform",    "Bowser in the Sky",           3626240, LocationType.Block,     []),
    Location("Wing Cap Switch",                        "Tower of the Wing Cap",       3626181, LocationType.WingCap,   []),
    Location("Tower Red Coins",                        "Tower of the Wing Cap",       3626140, LocationType.RedCoin,   []),
    Location("Metal Cap Switch",                       "Cavern of the Metal Cap",     3626182, LocationType.MetalCap,  []),
    Location("Cavern Red Coins",                       "Cavern of the Metal Cap",     3626133, LocationType.RedCoin,   []),
    Location("1-Up Block Above the Rushing River",     "Cavern of the Metal Cap",     3626241, LocationType.Block,     []),
    Location("Vanish Cap Switch",                      "Vanish Cap under the Moat",   3626183, LocationType.VanishCap, []),
    Location("Moat Red Coins",                         "Vanish Cap under the Moat",   3626147, LocationType.RedCoin,   []),
    Location("1-Up Block on the Slope Platform",       "Vanish Cap under the Moat",   3626242, LocationType.Block,     []),
    Location("Rainbow Red Coins",                      "Wing Mario over the Rainbow", 3626154, LocationType.RedCoin,   []),
    Location("Rainbow 1-Up Block",                     "Wing Mario over the Rainbow", 3626243, LocationType.Block,     []),
    Location("Basement Toad's Gift",                   "Princess Peach's Castle",     3626168, LocationType.Star,      []),
    Location("Second Floor Toad's Gift",               "Princess Peach's Castle",     3626169, LocationType.Star,      []),
    Location("Third Floor Toad's Gift",                "Princess Peach's Castle",     3626170, LocationType.Star,      []),
    Location("MIPS the Rabbit",                        "Princess Peach's Castle",     3626171, LocationType.Star,      []),
    Location("MIPS the Rabbit II",                     "Princess Peach's Castle",     3626172, LocationType.Star,      []),
]
