import Foundation
import SwiftUI

// MARK: - Game Mode
public enum GameMode: String, Codable, CaseIterable {
    case levels = "LEVELS"
    case daily = "DAILY"
    case speedBlitz = "SPEED_BLITZ"
    case quotePuzzle = "QUOTE_PUZZLE"
    
    public var title: String {
        switch self {
        case .levels: return "Levels"
        case .daily: return "Daily Quest"
        case .speedBlitz: return "Speed Blitz"
        case .quotePuzzle: return "Quote Puzzle"
        }
    }
}

// MARK: - Word Definition
public struct WordDefinition: Identifiable, Codable, Hashable {
    public var id: String { word }
    public let word: String
    public let phonetic: String
    public let partOfSpeech: String
    public let definition: String
    public let example: String
    public var isBookmarked: Bool
    public var isMastered: Bool
    
    public init(
        word: String,
        phonetic: String = "",
        partOfSpeech: String = "noun",
        definition: String,
        example: String = "",
        isBookmarked: Bool = false,
        isMastered: Bool = false
    ) {
        self.word = word
        self.phonetic = phonetic
        self.partOfSpeech = partOfSpeech
        self.definition = definition
        self.example = example
        self.isBookmarked = isBookmarked
        self.isMastered = isMastered
    }
}

// MARK: - Crossword Word Placement
public struct CrosswordWord: Identifiable, Codable, Hashable {
    public let id: String
    public let word: String
    public let row: Int
    public let col: Int
    public let isHorizontal: Bool
    public let hint: String
    
    public init(id: String, word: String, row: Int, col: Int, isHorizontal: Bool, hint: String) {
        self.id = id
        self.word = word
        self.row = row
        self.col = col
        self.isHorizontal = isHorizontal
        self.hint = hint
    }
}

// MARK: - Level Data
public struct LevelData: Identifiable, Codable, Hashable {
    public let id: Int
    public let levelNumber: Int
    public let title: String
    public let category: String
    public let letters: String
    public let targetWords: [CrosswordWord]
    public let bonusWords: [String]
    public let quoteHint: String?
    
    public init(
        id: Int,
        levelNumber: Int,
        title: String,
        category: String,
        letters: String,
        targetWords: [CrosswordWord],
        bonusWords: [String] = [],
        quoteHint: String? = nil
    ) {
        self.id = id
        self.levelNumber = levelNumber
        self.title = title
        self.category = category
        self.letters = letters
        self.targetWords = targetWords
        self.bonusWords = bonusWords
        self.quoteHint = quoteHint
    }
}

// MARK: - Daily Puzzle
public struct DailyPuzzle: Identifiable, Codable, Hashable {
    public var id: String { dateString }
    public let dateString: String
    public let dayNumber: Int
    public let theme: String
    public let quoteOfTheDay: String
    public let letters: String
    public let targetWords: [CrosswordWord]
    public let bonusWords: [String]
    
    public init(
        dateString: String,
        dayNumber: Int,
        theme: String,
        quoteOfTheDay: String,
        letters: String,
        targetWords: [CrosswordWord],
        bonusWords: [String]
    ) {
        self.dateString = dateString
        self.dayNumber = dayNumber
        self.theme = theme
        self.quoteOfTheDay = quoteOfTheDay
        self.letters = letters
        self.targetWords = targetWords
        self.bonusWords = bonusWords
    }
}

// MARK: - User Profile
public struct UserProfile: Codable {
    public var id: Int
    public var username: String
    public var avatarEmoji: String
    public var countryFlag: String
    public var currentLevel: Int
    public var coins: Int
    public var butterflies: Int
    public var stars: Int
    public var currentStreak: Int
    public var bestStreak: Int
    public var lastPlayedDate: String
    public var notificationsEnabled: Bool
    public var notificationHour: Int
    
    public init(
        id: Int = 1,
        username: String = "Word Explorer",
        avatarEmoji: String = "🦉",
        countryFlag: String = "🇺🇸",
        currentLevel: Int = 1,
        coins: Int = 350,
        butterflies: Int = 12,
        stars: Int = 6,
        currentStreak: Int = 3,
        bestStreak: Int = 7,
        lastPlayedDate: String = "",
        notificationsEnabled: Bool = true,
        notificationHour: Int = 9
    ) {
        self.id = id
        self.username = username
        self.avatarEmoji = avatarEmoji
        self.countryFlag = countryFlag
        self.currentLevel = currentLevel
        self.coins = coins
        self.butterflies = butterflies
        self.stars = stars
        self.currentStreak = currentStreak
        self.bestStreak = bestStreak
        self.lastPlayedDate = lastPlayedDate
        self.notificationsEnabled = notificationsEnabled
        self.notificationHour = notificationHour
    }
}

// MARK: - Leaderboard User
public struct LeaderboardUser: Identifiable, Codable {
    public let id: String
    public let rank: Int
    public let username: String
    public let avatarEmoji: String
    public let countryFlag: String
    public let score: Int
    public let wordsFound: Int
    public let league: String
    public let isCurrentUser: Bool
}

// MARK: - Word Song Item
public struct WordSongItem: Identifiable, Hashable {
    public var id: String { title }
    public let title: String
    public let category: String
    public let iconEmoji: String
    public let color: Color
    public let durationText: String
    public let lyrics: [String]
    public let featuredWords: [String]
}
