import Foundation

public struct PuzzleSeedData {
    public static let levels: [LevelData] = [
        LevelData(
            id: 1,
            levelNumber: 1,
            title: "First Flight",
            category: "Apprentice",
            letters: "ACT",
            targetWords: [
                CrosswordWord(id: "1_1", word: "CAT", row: 0, col: 0, isHorizontal: true, hint: "A beloved feline pet"),
                CrosswordWord(id: "1_2", word: "ACT", row: 0, col: 1, isHorizontal: false, hint: "To take action or perform")
            ],
            bonusWords: ["AT", "TA"],
            quoteHint: "Curiosity killed the CAT!"
        ),
        LevelData(
            id: 2,
            levelNumber: 2,
            title: "Sunlit Meadow",
            category: "Apprentice",
            letters: "SUNO",
            targetWords: [
                CrosswordWord(id: "2_1", word: "SUN", row: 0, col: 0, isHorizontal: true, hint: "Our radiant solar star"),
                CrosswordWord(id: "2_2", word: "SON", row: 0, col: 0, isHorizontal: false, hint: "A male child"),
                CrosswordWord(id: "2_3", word: "ON", row: 1, col: 0, isHorizontal: true, hint: "Opposite of off")
            ],
            bonusWords: ["NO", "SO", "US", "NU"],
            quoteHint: "Here comes the SUN!"
        ),
        LevelData(
            id: 3,
            levelNumber: 3,
            title: "Forest Path",
            category: "Apprentice",
            letters: "TAPER",
            targetWords: [
                CrosswordWord(id: "3_1", word: "TAPE", row: 0, col: 0, isHorizontal: true, hint: "Adhesive strip"),
                CrosswordWord(id: "3_2", word: "PART", row: 0, col: 2, isHorizontal: false, hint: "A piece or portion of a whole"),
                CrosswordWord(id: "3_3", word: "PEAR", row: 2, col: 0, isHorizontal: true, hint: "Sweet bell-shaped fruit"),
                CrosswordWord(id: "3_4", word: "RATE", row: 0, col: 4, isHorizontal: false, hint: "A measure or speed")
            ],
            bonusWords: ["PET", "RAT", "TEA", "ART", "ERA", "APE", "EAT", "PAT", "TAR", "REAP", "TRAP", "PEAT"],
            quoteHint: "A PEAR of wise words."
        ),
        LevelData(
            id: 4,
            levelNumber: 4,
            title: "Whispering Stream",
            category: "Wordsmith",
            letters: "FLAME",
            targetWords: [
                CrosswordWord(id: "4_1", word: "FLAME", row: 0, col: 0, isHorizontal: true, hint: "A luminous burning gas"),
                CrosswordWord(id: "4_2", word: "LEAF", row: 0, col: 1, isHorizontal: false, hint: "Green foliage of a tree"),
                CrosswordWord(id: "4_3", word: "FAME", row: 0, col: 0, isHorizontal: false, hint: "Widespread renown"),
                CrosswordWord(id: "4_4", word: "MALE", row: 3, col: 0, isHorizontal: true, hint: "Masculine gender")
            ],
            bonusWords: ["ALE", "ELF", "ELM", "LAME", "MEAL", "FLEA"],
            quoteHint: "Feed the FLAME of knowledge."
        ),
        LevelData(
            id: 5,
            levelNumber: 5,
            title: "Ancient Library",
            category: "Wordsmith",
            letters: "BRAVE",
            targetWords: [
                CrosswordWord(id: "5_1", word: "BRAVE", row: 0, col: 0, isHorizontal: true, hint: "Showing courage"),
                CrosswordWord(id: "5_2", word: "BEAR", row: 0, col: 0, isHorizontal: false, hint: "Large forest mammal or to carry"),
                CrosswordWord(id: "5_3", word: "RAVE", row: 0, col: 1, isHorizontal: false, hint: "Speak with wild enthusiasm"),
                CrosswordWord(id: "5_4", word: "VERB", row: 2, col: 3, isHorizontal: false, hint: "Action word in grammar")
            ],
            bonusWords: ["BAR", "EAR", "ERA", "BARE", "RARE"],
            quoteHint: "Fortune favors the BRAVE."
        ),
        LevelData(
            id: 6,
            levelNumber: 6,
            title: "Starry Observatory",
            category: "Lexicographer",
            letters: "PLANET",
            targetWords: [
                CrosswordWord(id: "6_1", word: "PLANET", row: 0, col: 0, isHorizontal: true, hint: "Celestial body orbiting a star"),
                CrosswordWord(id: "6_2", word: "PLANT", row: 0, col: 0, isHorizontal: false, hint: "Living organism like a flower"),
                CrosswordWord(id: "6_3", word: "PLANE", row: 0, col: 0, isHorizontal: true, hint: "Flat surface or aircraft"),
                CrosswordWord(id: "6_4", word: "LANE", row: 0, col: 1, isHorizontal: false, hint: "Narrow road or passage"),
                CrosswordWord(id: "6_5", word: "NEAT", row: 3, col: 2, isHorizontal: true, hint: "Tidy and orderly")
            ],
            bonusWords: ["ALE", "APE", "APT", "EAT", "LAP", "LET", "NET", "PAN", "PAT", "PEN", "PET", "PIN", "TAN", "TAP", "TEA", "LEAP", "PALE", "PLEA", "TALE", "TAPE"],
            quoteHint: "Third PLANET from the Sun."
        ),
        LevelData(
            id: 7,
            levelNumber: 7,
            title: "Philosopher's Garden",
            category: "Polymath",
            letters: "WISDOM",
            targetWords: [
                CrosswordWord(id: "7_1", word: "WISDOM", row: 0, col: 0, isHorizontal: true, hint: "Deep knowledge and good judgment"),
                CrosswordWord(id: "7_2", word: "WIND", row: 0, col: 0, isHorizontal: false, hint: "Current of air"),
                CrosswordWord(id: "7_3", word: "SWIM", row: 2, col: 2, isHorizontal: true, hint: "Propel oneself through water"),
                CrosswordWord(id: "7_4", word: "MOD", row: 0, col: 4, isHorizontal: false, hint: "Modification or modern style")
            ],
            bonusWords: ["DIM", "MID", "SOW", "MOW", "SIM"],
            quoteHint: "Silence is the sanctuary of WISDOM."
        ),
        LevelData(
            id: 8,
            levelNumber: 8,
            title: "Titan's Citadel",
            category: "Word Titan",
            letters: "MASTER",
            targetWords: [
                CrosswordWord(id: "8_1", word: "MASTER", row: 0, col: 0, isHorizontal: true, hint: "A consummate expert"),
                CrosswordWord(id: "8_2", word: "STREAM", row: 0, col: 2, isHorizontal: false, hint: "A flow of water or data"),
                CrosswordWord(id: "8_3", word: "SMART", row: 2, col: 0, isHorizontal: true, hint: "Quick-witted and intelligent"),
                CrosswordWord(id: "8_4", word: "TEAM", row: 4, col: 0, isHorizontal: true, hint: "Group of players collaborating")
            ],
            bonusWords: ["ARM", "ART", "EAR", "EAT", "MAT", "RAM", "RAT", "SEA", "SET", "TAR", "TEA", "ARMS", "EAST", "MEAT", "REST", "SEAM", "SEAT", "STAR", "STEM", "TERM"],
            quoteHint: "You are the MASTER of your fate."
        )
    ]

    public static func getDailyPuzzle(dayOffset: Int = 0) -> DailyPuzzle {
        let puzzles = [
            DailyPuzzle(
                dateString: "2026-08-29",
                dayNumber: 241,
                theme: "Illumination & Insight",
                letters: "LUMEN",
                targetWords: [
                    CrosswordWord(id: "d1", word: "LUMEN", row: 0, col: 0, isHorizontal: true, hint: "Unit of luminous flux"),
                    CrosswordWord(id: "d2", word: "MENU", row: 0, col: 2, isHorizontal: false, hint: "List of dishes or options"),
                    CrosswordWord(id: "d3", word: "MULE", row: 2, col: 0, isHorizontal: true, hint: "Sturdy hybrid equine"),
                    CrosswordWord(id: "d4", word: "ELM", row: 0, col: 3, isHorizontal: false, hint: "Majestic deciduous tree")
                ],
                bonusWords: ["EMU", "MEN", "NIL", "LUN"],
                quoteOfTheDay: "Education is the kindling of a flame, not the filling of a vessel.",
                wordOfTheDay: "LUMINOUS"
            ),
            DailyPuzzle(
                dateString: "2026-08-30",
                dayNumber: 242,
                theme: "Verdant Canopy",
                letters: "GROVE",
                targetWords: [
                    CrosswordWord(id: "d5", word: "GROVE", row: 0, col: 0, isHorizontal: true, hint: "A small wood or orchard"),
                    CrosswordWord(id: "d6", word: "ROVE", row: 0, col: 1, isHorizontal: false, hint: "Travel constantly without destination"),
                    CrosswordWord(id: "d7", word: "OVER", row: 2, col: 0, isHorizontal: true, hint: "Above in position"),
                    CrosswordWord(id: "d8", word: "OGRE", row: 0, col: 2, isHorizontal: false, hint: "Giant in folklore")
                ],
                bonusWords: ["EGO", "ORE", "ROE"],
                quoteOfTheDay: "Look deep into nature, and then you will understand everything better.",
                wordOfTheDay: "VERDANT"
            )
        ]
        return puzzles[abs(dayOffset) % puzzles.count]
    }
}
