/* eslint-disable @stylistic/no-multi-spaces,@stylistic/array-bracket-spacing */
import { Entrance } from "./entrance.ts";
import { Location, Region, regions } from "./location.ts";
import { rule } from "./rules.ts";

export const entrances: Entrance[] = [
    // Course Stages
    new Entrance("BoB",    1, [ 102, 529],   91),
    new Entrance("WF",     2, [ 690, 631],  241, rule("STARS:1")),
    new Entrance("JRB",    3, [ 671, 957],  121, rule("STARS:3")),
    new Entrance("CCM",    4, [ 525, 528],   51, rule("STARS:3")),
    new Entrance("BBH",    5, [ 689, 370],   41, rule("STARS:12")),
    new Entrance("HMC",    6, [1448, 778],   71, rule("BASEMENT")),
    new Entrance("LLL",    7, [1169, 686],  221, rule("BASEMENT")),
    new Entrance("SSL",    8, [1060, 822],   81, rule("BASEMENT")),
    new Entrance("DDD",    9, [1519, 994],  231, rule("BASEMENT & BOWSER2")),
    new Entrance("SL",    10, [1104, 524],  101, rule("SECONDFLOOR")),
    new Entrance("WDW",   11, [1420, 520],  111, rule("SECONDFLOOR")),
    new Entrance("TTM",   12, [1398, 336],  361, rule("SECONDFLOOR")),
    new Entrance("THIh",  13, [1682, 648],  131, rule("SECONDFLOOR")),
    new Entrance("THIt",  14, [1682, 376],  132, rule("SECONDFLOOR")),
    new Entrance("TTC",   15, [1364, 104],  141, rule("THIRDFLOOR & LG/TJ/SF/BF/WK")),
    new Entrance("RR",    16, [1587, 168],  151, rule("THIRDFLOOR & TJ/SF/BF")),

    // Bowser Stages
    new Entrance("BitDW", 17, [ 322, 308],  171, rule("BOWSER1")),
    new Entrance("BitFS", 18, [1565, 994],  191, rule("BASEMENT & BOWSER2 & SUB")),
    new Entrance("BitS",  19, [1366, 520], null, rule("THIRDFLOOR & BOWSER3")),

    // Secret Stages (excl. Bowser Stages)
    new Entrance("PSS",   20, [ 648, 762],  271, rule("STARS:1")),
    new Entrance("SA",    21, [ 456, 874],  201, rule("STARS:3 & SF/BF | STARS:3 & TJ & LG | STARS:3 & MOVELESS & TJ")),
    new Entrance("WMotR", 22, [1142, 168],  311, rule("THIRDFLOOR & TJ/SF/BF")),
    new Entrance("TotWC", 23, [ 286, 814],  291, rule("STARS:10")),
    new Entrance("CotMC", 24, [ 910, 143],  281, rule("HMC")),
    new Entrance("VCutM", 25, [1828, 885],  181, rule("BASEMENT & GP")),
];

// Logical Regions
new Region("BoB");
new Region("BoB:Island",       regions["BoB"],            rule("CANN:BoB | CANNLESS & WC & TJ | CAPLESS & CANNLESS & LJ"));
new Region("WF");
new Region("WF:Tower",         regions["WF"],             rule("GP"));
new Region("JRB");
new Region("JRB:Upper",        regions["JRB"],            rule("TJ/BF/SF/WK | MOVELESS & LG"));
new Region("CCM");
new Region("BBH");
new Region("BBH:ThirdFloor",   regions["BBH"],            rule("WK & LG | MOVELESS & WK"));
new Region("BBH:Roof",         regions["BBH:ThirdFloor"], rule("LJ | MOVELESS"));
new Region("HMC");
new Region("HMC:RedCoinArea",  regions["HMC"],            rule("CL & WK/LG/BF/SF/TJ | MOVELESS & WK"));
new Region("HMC:PitIslands",   regions["HMC"],            rule("TJ & CL | MOVELESS & WK & TJ/LJ | MOVELESS & WK & SF & LG"));
new Region("LLL");
new Region("LLL:UpperVolcano", regions["LLL"],            rule("CL"));
new Region("SSL");
new Region("SSL:UpperPyramid", regions["SSL"],            rule("CL & TJ/BF/SF/LG | MOVELESS"));
new Region("DDD");
new Region("SL");
new Region("WDW");
new Region("WDW:Top",          regions["WDW"],            rule("WK/TJ/SF/BF | MOVELESS"));
new Region("WDW:Downtown",     regions["WDW"],            rule("NAR & LG & TJ/SF/BF | CANN:WDW | MOVELESS & TJ & DV"));
new Region("TTM");
new Region("TTM:Top",          regions["TTM"],            rule("LJ/DV & LG/KI | MOVELESS & TJ | MOVELESS & WK & SF/LG | MOVELESS & KI/DV"));
new Region("THI");
new Region("THI:Pipes",        regions["THI"],            rule("NAR | LJ/TJ/DV/LG | MOVELESS & BF/SF/KI"));
new Region("THI:LargeTop",     regions["THI:Pipes"],      rule("NAR | LJ/TJ/DV | MOVELESS"));
new Region("TTC");
new Region("TTC:Lower",        regions["TTC"],            rule("LG/TJ/SF/BF/WK"));
new Region("TTC:Upper",        regions["TTC:Lower"],      rule("CL | MOVELESS & WK"));
new Region("TTC:Top",          regions["TTC:Upper"],      rule("TJ & LG | MOVELESS & WK/TJ"));
new Region("RR");
new Region("RR:Maze",          regions["RR"],             rule("WK | LJ & SF/BF/TJ | MOVELESS & LG/TJ"));
new Region("RR:Cruiser",       regions["RR"],             rule("WK/SF/BF/LG/TJ"));
new Region("RR:House",         regions["RR"],             rule("TJ/SF/BF/LG"));
new Region("BitDW");
new Region("BitFS");
new Region("BitFS:Upper",      regions["BitFS"],          rule("CL"));
new Region("BitS");
new Region("BitS:Top",         regions["BitS"],           rule("CL & TJ | CL & SF & LG | MOVELESS & TJ & WK & LG"));
new Region("TotWC");
new Region("CotMC");
new Region("VCutM");
new Region("PSS");
new Region("SA");
new Region("WMotR");
new Region("PPC");

// Individual Locations
export const locations: Location[] = [
    // 1. Bob-omb Battlefield
    new Location("Big Bob-omb on the Summit",             "BoB",              3626000, "Star"),
    new Location("Footrace with Koopa the Quick",         "BoB",              3626001, "Star"),
    new Location("Shoot to the Island in the Sky",        "BoB:Island",       3626002, "Star"),
    new Location("Find the 8 Red Coins",                  "BoB:Island",       3626003, "RedCoins"),
    new Location("Mario Wings to the Sky",                "BoB",              3626004, "Star",         rule("CANN:BoB & WC | CAPLESS & CANN:BoB")),
    new Location("Behind Chain Chomp's Gate",             "BoB",              3626005, "Star",         rule("GP | MOVELESS")),
    new Location("100 Coins Star",                        "BoB",              3626006, "100Coins",     rule("CANN:BoB & WC | CANNLESS & WC & TJ")),
    new Location("Bob-omb Buddy",                         "BoB",              3626200, "Buddy"),

    // 2. Whomp's Fortress
    new Location("Chip off Whomp's Block",                "WF",               3626007, "Star",         rule("GP")),
    new Location("To the Top of the Fortress",            "WF:Tower",         3626008, "Star"),
    new Location("Shoot into the Wild Blue",              "WF",               3626009, "Star",         rule("WK & TJ/SF | CANN:WF")),
    new Location("Red Coins on the Floating Isle",        "WF",               3626010, "RedCoins"),
    new Location("Fall onto the Caged Island",            "WF",               3626011, "Star",         rule("CL & GP | MOVELESS & TJ | MOVELESS & LJ | MOVELESS & CANN:WF")),
    new Location("Blast Away the Wall",                   "WF",               3626012, "Star",         rule("CANN:WF | CANNLESS & LG")),
    new Location("100 Coins Star",                        "WF",               3626013, "100Coins",     rule("GP | MOVELESS")),
    new Location("Bob-omb Buddy",                         "WF:Tower",         3626201, "Buddy"),

    // 3. Jolly Roger Bay
    new Location("Plunder in the Sunken Ship",            "JRB",              3626014, "Star"),
    new Location("Can the Eel Come out to Play?",         "JRB",              3626015, "Star"),
    new Location("Treasure of the Ocean Cave",            "JRB",              3626016, "Star"),
    new Location("Red Coins on the Ship Afloat",          "JRB:Upper",        3626017, "RedCoins",     rule("CANN:JRB | CL/TJ | MOVELESS & BF/WK")),
    new Location("Blast to the Stone Pillar",             "JRB",              3626018, "Star",         rule("CANN:JRB & CL | CANN:JRB & MOVELESS | CANNLESS & MOVELESS")),
    new Location("Through the Jet Stream",                "JRB",              3626019, "Star",         rule("MC | CAPLESS")),
    new Location("100 Coins Star",                        "JRB:Upper",        3626020, "100Coins",     rule("GP")),
    new Location("Bob-omb Buddy",                         "JRB",              3626202, "Buddy"),

    // 4. Cool, Cool Mountain
    new Location("Slip Slidin' Away",                     "CCM",              3626021, "Star"),
    new Location("Li'l Penguin Lost",                     "CCM",              3626022, "Star"),
    new Location("Big Penguin Race",                      "CCM",              3626023, "Star"),
    new Location("Frosty Slide for 8 Red Coins",          "CCM",              3626024, "RedCoins"),
    new Location("Snowman's Lost his Head",               "CCM",              3626025, "Star"),
    new Location("Wall Kicks will Work",                  "CCM",              3626026, "Star",         rule("CANN:CCM & TJ/WK | CANNLESS & TJ/WK | MOVELESS")),
    new Location("100 Coins Star",                        "CCM",              3626027, "100Coins"),
    new Location("Bob-omb Buddy",                         "CCM",              3626203, "Buddy"),
    new Location("1-Up Block Near Snowman",               "CCM",              3626215, "MushBlock"),
    new Location("1-Up Block Near Ice Pillar",            "CCM",              3626216, "MushBlock"),
    new Location("1-Up Block in Secret Slide",            "CCM",              3626217, "MushBlock"),

    // 5. Big Boo's Haunt
    new Location("Go on a Ghost Hunt",                    "BBH",              3626028, "Star"),
    new Location("Ride Big Boo's Merry-Go-Round",         "BBH",              3626029, "Star"),
    new Location("Secret of the Haunted Books",           "BBH",              3626030, "Star",         rule("KI | MOVELESS")),
    new Location("Seek the 8 Red Coins",                  "BBH",              3626031, "RedCoins",     rule("BF/WK/TJ/SF")),
    new Location("Big Boo's Balcony",                     "BBH:Roof",         3626032, "Star"),
    new Location("Eye to Eye in the Secret Room",         "BBH:ThirdFloor",   3626033, "Star",         rule("VC")),
    new Location("100 Coins Star",                        "BBH",              3626034, "100Coins"),
    new Location("1-Up Block on Top of the Mansion",      "BBH:Roof",         3626218, "MushBlock"),

    // 6. Hazy Maze Cave
    new Location("Swimming Beast in the Cavern",          "HMC",              3626035, "Star"),
    new Location("Elevate for 8 Red Coins",               "HMC:RedCoinArea",  3626036, "RedCoins"),
    new Location("Metal-Head Mario Can Move!",            "HMC",              3626037, "Star",         rule("LJ & MC | CAPLESS & LJ & TJ | CAPLESS & MOVELESS & LJ/TJ/WK")),
    new Location("Navigating the Toxic Maze",             "HMC",              3626038, "Star",         rule("WK/SF/BF/TJ")),
    new Location("A-Maze-Ing Emergency Exit",             "HMC:PitIslands",   3626039, "Star"),
    new Location("Watch for Rolling Rocks",               "HMC",              3626040, "Star",         rule("WK")),
    new Location("100 Coins Star",                        "HMC:RedCoinArea",  3626041, "100Coins",     rule("GP")),
    new Location("1-Up Block Above the Pit",              "HMC:PitIslands",   3626219, "MushBlock"),
    new Location("1-Up Block Past Rolling Rocks",         "HMC",              3626220, "MushBlock"),

    // 7. Lethal Lava Land
    new Location("Boil the Big Bully",                    "LLL",              3626042, "Star"),
    new Location("Bully the Bullies",                     "LLL",              3626043, "Star"),
    new Location("8-Coin Puzzle with 15 Pieces",          "LLL",              3626044, "RedCoins"),
    new Location("Red-Hot Log Rolling",                   "LLL",              3626045, "Star"),
    new Location("Hot-Foot-It into the Volcano",          "LLL:UpperVolcano", 3626046, "Star"),
    new Location("Elevator Tour in the Volcano",          "LLL:UpperVolcano", 3626047, "Star"),
    new Location("100 Coins Star",                        "LLL",              3626048, "100Coins"),

    // 8. Shifting Sand Land
    new Location("In the Talons of the Big Bird",         "SSL",              3626049, "Star"),
    new Location("Shining Atop the Pyramid",              "SSL",              3626050, "Star"),
    new Location("Inside the Ancient Pyramid",            "SSL:UpperPyramid", 3626051, "Star"),
    new Location("Stand Tall on the Four Pillars",        "SSL:UpperPyramid", 3626052, "Star",         rule("TJ & WC & GP | CANN:SSL & WC & GP | CAPLESS & TJ/SF/BF | MOVELESS")),
    new Location("Free Flying for 8 Red Coins",           "SSL",              3626053, "RedCoins",     rule("TJ & WC | CANN:SSL & WC | CAPLESS & TJ/SF/BF | CAPLESS & MOVELESS")),
    new Location("Pyramid Puzzle",                        "SSL:UpperPyramid", 3626054, "Star"),
    new Location("100 Coins Star",                        "SSL",              3626055, "100Coins",     rule("GP | CL & TJ/BF/SF/LG | MOVELESS")),
    new Location("Bob-omb Buddy",                         "SSL",              3626207, "Buddy"),
    new Location("1-Up Block Outside Pyramid",            "SSL",              3626221, "MushBlock"),
    new Location("1-Up Block in the Pyramid's Left Path", "SSL",              3626222, "MushBlock"),
    new Location("1-Up Block in the Pyramid's Back",      "SSL",              3626223, "MushBlock"),

    // 9. Dire, Dire Docks
    new Location("Board Bowser's Sub",                    "DDD",              3626056, "Star"),
    new Location("Chests in the Current",                 "DDD",              3626057, "Star"),
    new Location("Pole-Jumping for Red Coins",            "DDD",              3626058, "RedCoins",     rule("BEATBOWSER2 & CL | MOVELESS & TJ & DV & LG & WK")),
    new Location("Through the Jet Stream",                "DDD",              3626059, "Star",         rule("MC | CAPLESS")),
    new Location("The Manta Ray's Reward",                "DDD",              3626060, "Star"),
    new Location("Collect the Caps...",                   "DDD",              3626061, "Star",         rule("VC & MC | CAPLESS & VC")),
    new Location("100 Coins Star",                        "DDD",              3626062, "100Coins",     rule("BEATBOWSER2 & CL & GP | MOVELESS & TJ & DV & LG & WK & GP")),

    // 10. Snowman's Land
    new Location("Snowman's Big Head",                    "SL",               3626063, "Star",         rule("BF/SF/TJ | CANN:SL")),
    new Location("Chill with the Bully",                  "SL",               3626064, "Star"),
    new Location("In the Deep Freeze",                    "SL",               3626065, "Star",         rule("WK/SF/LG/BF/TJ | CANN:SL")),
    new Location("Whirl from the Freezing Pond",          "SL",               3626066, "Star"),
    new Location("Shell Shreddin' for Red Coins",         "SL",               3626067, "RedCoins"),
    new Location("Into the Igloo",                        "SL",               3626068, "Star",         rule("VC & TJ/SF/BF/WK/LG | MOVELESS & VC")),
    new Location("100 Coins Star",                        "SL",               3626069, "100Coins",     rule("VC | CAPLESS")),
    new Location("Bob-omb Buddy",                         "SL",               3626209, "Buddy"),
    new Location("1-Up Block Near Moneybags",             "SL",               3626224, "MushBlock"),
    new Location("1-Up Block Inside the Igloo",           "SL",               3626225, "MushBlock"),

    // 11. Wet-Dry World
    new Location("Shocking Arrow Lifts!",                 "WDW:Top",          3626070, "Star"),
    new Location("Top o' the Town",                       "WDW:Top",          3626071, "Star"),
    new Location("Secrets in the Shallows & Sky",         "WDW:Top",          3626072, "Star"),
    new Location("Express Elevator--Hurry Up!",           "WDW",              3626073, "Star"),
    new Location("Go to Town for Red Coins",              "WDW:Downtown",     3626074, "RedCoins",     rule("WK | MOVELESS & TJ")),
    new Location("Quick Race Through Downtown!",          "WDW:Downtown",     3626075, "Star",         rule("VC & WK/BF | VC & TJ & LG | MOVELESS & VC & TJ")),
    new Location("100 Coins Star",                        "WDW:Top",          3626076, "100Coins",     rule("GP | NAR & LG & TJ/SF/BF | CANN:WDW | MOVELESS & TJ & DV")),
    new Location("Bob-omb Buddy",                         "WDW:Top",          3626210, "Buddy",        rule("TJ | SF & LG | NAR & BF/SF")),
    new Location("1-Up Block in the Downtown",            "WDW:Downtown",     3626226, "MushBlock"),

    // 12. Tall, Tall Mountain
    new Location("Scale the Mountain",                    "TTM:Top",          3626077, "Star"),
    new Location("Mystery of the Monkey Cage",            "TTM:Top",          3626078, "Star"),
    new Location("Scary 'Shrooms, Red Coins",             "TTM",              3626079, "RedCoins"),
    new Location("Mysterious Mountainside",               "TTM:Top",          3626080, "Star"),
    new Location("Breathtaking View from Bridge",         "TTM:Top",          3626081, "Star"),
    new Location("Blast to the Lonely Mushroom",          "TTM",              3626082, "Star",         rule("CANN:TTM | CANNLESS & LJ | MOVELESS & CANNLESS")),
    new Location("100 Coins Star",                        "TTM:Top",          3626083, "100Coins"),
    new Location("Bob-omb Buddy",                         "TTM",              3626211, "Buddy"),
    new Location("1-Up Block on the Red Mushroom",        "TTM",              3626227, "MushBlock"),

    // 13. Tiny-Huge Island
    new Location("Pluck the Piranha Flower",              "THI:Pipes",        3626084, "Star"),
    new Location("The Tip Top of the Huge Island",        "THI:Pipes",        3626085, "Star"),
    new Location("Rematch with Koopa the Quick",          "THI:Pipes",        3626086, "Star"),
    new Location("Five Itty Bitty Secrets",               "THI:Pipes",        3626087, "Star"),
    new Location("Wiggler's Red Coins",                   "THI:Pipes",        3626088, "RedCoins",     rule("WK")),
    new Location("Make Wiggler Squirm",                   "THI:LargeTop",     3626089, "Star",         rule("GP | MOVELESS & DV")),
    new Location("100 Coins Star",                        "THI:LargeTop",     3626090, "100Coins",     rule("GP")),
    new Location("Bob-omb Buddy",                         "THI:Pipes",        3626212, "Buddy"),
    new Location("1-Up Block Near Tiny Start",            "THI:Pipes",        3626228, "MushBlock"),
    new Location("1-Up Block Near Huge Start",            "THI:Pipes",        3626229, "MushBlock"),
    new Location("1-Up Block in the Windy Area",          "THI:Pipes",        3626230, "MushBlock"),

    // 14. Tick Tock Clock
    new Location("Roll into the Cage",                    "TTC:Lower",        3626091, "Star"),
    new Location("The Pit and the Pendulums",             "TTC:Upper",        3626092, "Star"),
    new Location("Get a Hand",                            "TTC:Lower",        3626093, "Star"),
    new Location("Stomp on the Thwomp",                   "TTC:Top",          3626094, "Star"),
    new Location("Timed Jumps on Moving Bars",            "TTC:Upper",        3626095, "Star"),
    new Location("Stop Time for Red Coins",               "TTC",              3626096, "RedCoins",     rule("NAR | LG/TJ/SF/BF/WK")),
    new Location("100 Coins Star",                        "TTC",              3626097, "100Coins",     rule("GP")),
    new Location("1-Up Block Midway Up",                  "TTC:Top",          3626231, "MushBlock"),
    new Location("1-Up Block at the Top",                 "TTC:Top",          3626232, "MushBlock"),

    // 15. Rainbow Ride
    new Location("Cruiser Crossing the Rainbow",          "RR:Cruiser",       3626098, "Star"),
    new Location("The Big House in the Sky",              "RR:House",         3626099, "Star"),
    new Location("Coins Amassed in a Maze",               "RR:Maze",          3626100, "RedCoins"),
    new Location("Swingin' in the Breeze",                "RR",               3626101, "Star",         rule("LG/TJ/BF/SF | MOVELESS")),
    new Location("Tricky Triangles!",                     "RR",               3626102, "Star",         rule("LG/TJ/BF/SF | MOVELESS")),
    new Location("Somewhere over the Rainbow",            "RR:Cruiser",       3626103, "Star",         rule("CANN:RR")),
    new Location("100 Coins Star",                        "RR:Maze",          3626104, "100Coins",     rule("GP & WK")),
    new Location("Bob-omb Buddy",                         "RR",               3626214, "Buddy"),
    new Location("1-Up Block Above the Red Coin Maze",    "RR",               3626233, "MushBlock"),
    new Location("1-Up Block Under Fly Guy",              "RR",               3626234, "MushBlock"),
    new Location("1-Up Block on the House in the Sky",    "RR:House",         3626235, "MushBlock"),

    // Peach's Secret Slide
    new Location("End of the Slide Block",                "PSS",              3626126, "Star"),
    new Location("Finish under 21 Seconds",               "PSS",              3626127, "Star"),

    // Secret Aquarium
    new Location("The Aquarium Red Coins",                "SA",               3626161, "RedCoins"),

    // Bowser in the Dark World
    new Location("First Bowser's Key",                    "BitDW",            3626178, "BowserKey"),
    new Location("Dark World Red Coins",                  "BitDW",            3626105, "RedCoins"),
    new Location("1-Up Block on the Tower",               "BitDW",            3626236, "MushBlock"),
    new Location("1-Up Block Near the Goombas",           "BitDW",            3626237, "MushBlock"),

    // Bowser in the Fire Sea
    new Location("Second Bowser's Key",                   "BitFS:Upper",      3626179, "BowserKey"),
    new Location("Fire Sea Red Coins",                    "BitFS:Upper",      3626112, "RedCoins"),
    new Location("1-Up Block on the Swaying Stairs",      "BitFS:Upper",      3626238, "MushBlock"),
    new Location("1-Up Block Near the Poles",             "BitFS:Upper",      3626239, "MushBlock"),

    // Bowser in the Sky
    new Location("Sky Red Coins",                         "BitS:Top",         3626119, "RedCoins"),
    new Location("1-Up Block on the Rotating Platform",   "BitS",             3626240, "MushBlock"),

    // Tower of the Wing Cap
    new Location("Wing Cap Switch",                       "TotWC",            3626181, "RedSwitch"),
    new Location("Tower Red Coins",                       "TotWC",            3626140, "RedCoins"),

    // Cavern of the Metal Cap
    new Location("Metal Cap Switch",                      "CotMC",            3626182, "GreenSwitch"),
    new Location("Cavern Red Coins",                      "CotMC",            3626133, "RedCoins",     rule("MC | CAPLESS")),
    new Location("1-Up Block Above the Rushing River",    "CotMC",            3626241, "MushBlock"),

    // Vanish Cap under the Moat
    new Location("Vanish Cap Switch",                     "VCutM",            3626183, "BlueSwitch",   rule("WK/TJ/BF/SF/LG | MOVELESS")),
    new Location("Moat Red Coins",                        "VCutM",            3626147, "RedCoins",     rule("WK/TJ/BF/SF/LG & VC | CAPLESS & WK")),
    new Location("1-Up Block on the Slope Platform",      "VCutM",            3626242, "MushBlock"),

    // Wing Mario over the Rainbow
    new Location("Rainbow Red Coins",                     "WMotR",            3626154, "RedCoins",     rule("WC & TJ")),
    new Location("Rainbow 1-Up Block",                    "WMotR",            3626243, "MushBlock",    rule("WC & TJ")),

    // Peach's Castle Interior
    new Location("Basement Toad's Gift",                  "PPC",              3626168, "Star",         rule("BASEMENT & STARS:12")),
    new Location("Second Floor Toad's Gift",              "PPC",              3626169, "Star",         rule("SECONDFLOOR & STARS:25")),
    new Location("Third Floor Toad's Gift",               "PPC",              3626170, "Star",         rule("THIRDFLOOR & STARS:35")),
    new Location("MIPS the Rabbit",                       "PPC",              3626171, "Star",         rule("BASEMENT & MIPS1")),
    new Location("MIPS the Rabbit II",                    "PPC",              3626172, "Star",         rule("BASEMENT & MIPS2")),
];
