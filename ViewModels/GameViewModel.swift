import Foundation
import SwiftUI
import AVFoundation

@MainActor
public class GameViewModel: ObservableObject {
    @Published public var profile: UserProfile
    @Published public var currentMode: GameMode = .levels
    @Published public var currentLevelIndex: Int = 1
    @Published public var currentLevelData: LevelData
    @Published public var dailyPuzzle: DailyPuzzle
    @Published public var solvedWords: Set<String> = []
    @Published public var solvedBonusWords: Set<String> = []
    @Published public var shuffledLetters: String = ""
    @Published public var currentWordInput: String = ""
    @Published public var revealedLetters: [String: Set<Int>] = [:] // wordId -> revealed letter indices
    
    @Published public var activeDefinition: WordDefinition? = nil
    @Published public var isCelebrationShowing: Bool = false
    @Published public var celebrationRewards: (stars: Int, coins: Int, butterflies: Int) = (3, 50, 2)
    @Published public var toastMessage: String? = nil
    @Published public var isMysteryGiftClaimed: Bool = false
    @Published public var vocabulary: [WordDefinition] = []
    @Published public var leaderboard: [LeaderboardUser] = []
    @Published public var inputModeIsFields: Bool = false // false = Wheel, true = Letter bank
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    private let levels: [LevelData]
    
    public init() {
        // Load initial profile from UserDefaults or defaults
        if let data = UserDefaults.standard.data(forKey: "wp_user_profile"),
           let savedProfile = try? JSONDecoder().decode(UserProfile.self, from: data) {
            self.profile = savedProfile
        } else {
            self.profile = UserProfile()
        }
        
        // Initialize Seed Levels
        let initialLevels: [LevelData] = [
            LevelData(
                id: 1,
                levelNumber: 1,
                title: "Joyful Beginnings",
                category: "Me and My Family",
                letters: "ACT",
                targetWords: [
                    CrosswordWord(id: "CAT", word: "CAT", row: 0, col: 0, isHorizontal: true, hint: "A friendly purring pet"),
                    CrosswordWord(id: "ACT", word: "ACT", row: 0, col: 0, isHorizontal: false, hint: "To take action or perform")
                ],
                bonusWords: ["AT"]
            ),
            LevelData(
                id: 2,
                levelNumber: 2,
                title: "Warm Sunny Days",
                category: "Nature All Around Me",
                letters: "SUN",
                targetWords: [
                    CrosswordWord(id: "SUN", word: "SUN", row: 0, col: 0, isHorizontal: true, hint: "The bright star in our daytime sky"),
                    CrosswordWord(id: "US", word: "US", row: 0, col: 1, isHorizontal: false, hint: "You and me together")
                ],
                bonusWords: ["NUN"]
            ),
            LevelData(
                id: 3,
                levelNumber: 3,
                title: "Sweet Orchard",
                category: "Nature All Around Me",
                letters: "PEAR",
                targetWords: [
                    CrosswordWord(id: "PEAR", word: "PEAR", row: 0, col: 0, isHorizontal: true, hint: "A sweet, juicy bell-shaped fruit"),
                    CrosswordWord(id: "EAR", word: "EAR", row: 0, col: 1, isHorizontal: false, hint: "Organ used for hearing sounds"),
                    CrosswordWord(id: "RAP", word: "RAP", row: 2, col: 0, isHorizontal: true, hint: "Quick rhythmic beat or tap")
                ],
                bonusWords: ["APE", "ARE", "ERA", "PAR", "REP"]
            ),
            LevelData(
                id: 4,
                levelNumber: 4,
                title: "Campfire Nights",
                category: "Fun Learning Time",
                letters: "FLAME",
                targetWords: [
                    CrosswordWord(id: "FLAME", word: "FLAME", row: 0, col: 0, isHorizontal: true, hint: "The visible glowing gas of a fire"),
                    CrosswordWord(id: "LEAF", word: "LEAF", row: 0, col: 1, isHorizontal: false, hint: "A flat green part of a plant"),
                    CrosswordWord(id: "MALE", word: "MALE", row: 3, col: 0, isHorizontal: true, hint: "Relating to boys or men")
                ],
                bonusWords: ["ALE", "ELF", "FAME", "MEAL"]
            ),
            LevelData(
                id: 5,
                levelNumber: 5,
                title: "Courageous Hearts",
                category: "Me and My Family",
                letters: "BRAVE",
                targetWords: [
                    CrosswordWord(id: "BRAVE", word: "BRAVE", row: 0, col: 0, isHorizontal: true, hint: "Showing courage when facing challenges"),
                    CrosswordWord(id: "BEAR", word: "BEAR", row: 0, col: 0, isHorizontal: false, hint: "A large furry woodland animal"),
                    CrosswordWord(id: "VERB", word: "VERB", row: 2, col: 0, isHorizontal: true, hint: "An action word in grammar")
                ],
                bonusWords: ["BARE", "RAVE", "BAR", "EAR"]
            )
        ]
        self.levels = initialLevels
        
        let initialLevel = initialLevels.first { $0.id == profile.currentLevel } ?? initialLevels[0]
        self.currentLevelData = initialLevel
        self.shuffledLetters = String(initialLevel.letters.shuffled())
        
        // Seed Daily Puzzle
        self.dailyPuzzle = DailyPuzzle(
            dateString: "2026-09-24",
            dayNumber: 268,
            theme: "Autumn Wonder",
            quoteOfTheDay: "Every leaf is a flower in autumn.",
            letters: "LEAF",
            targetWords: [
                CrosswordWord(id: "LEAF", word: "LEAF", row: 0, col: 0, isHorizontal: true, hint: "A flat green plant part"),
                CrosswordWord(id: "ALE", word: "ALE", row: 0, col: 2, isHorizontal: false, hint: "A brewed beverage"),
                CrosswordWord(id: "ELF", word: "ELF", row: 2, col: 0, isHorizontal: true, hint: "A playful magical creature")
            ],
            bonusWords: ["FEE", "FLEA"]
        )
        
        // Initialize Vocabulary dictionary
        self.vocabulary = [
            WordDefinition(word: "CAT", phonetic: "/kæt/", partOfSpeech: "noun", definition: "A small domesticated carnivorous mammal with soft fur.", example: "The cat sat gracefully by the window.", isMastered: true),
            WordDefinition(word: "SUN", phonetic: "/sʌn/", partOfSpeech: "noun", definition: "The luminous celestial body around which Earth revolves.", example: "The sun rose above the horizon.", isMastered: true),
            WordDefinition(word: "PEAR", phonetic: "/pɛər/", partOfSpeech: "noun", definition: "A sweet, juicy yellow-green fruit that is narrow at the stalk.", example: "She picked a ripe pear from the orchard.", isBookmarked: true),
            WordDefinition(word: "FLAME", phonetic: "/fleɪm/", partOfSpeech: "noun", definition: "A hot glowing body of ignited gas generated by a fire.", example: "The candle flame flickered softly."),
            WordDefinition(word: "BRAVE", phonetic: "/breɪv/", partOfSpeech: "adjective", definition: "Ready to face and endure danger or pain; showing courage.", example: "The brave explorer climbed the summit.")
        ]
        
        // Leaderboard seed
        self.leaderboard = [
            LeaderboardUser(id: "1", rank: 1, username: "Elena Star", avatarEmoji: "🦊", countryFlag: "🇬🇧", score: 1420, wordsFound: 118, league: "Diamond", isCurrentUser: false),
            LeaderboardUser(id: "2", rank: 2, username: "Leo Champion", avatarEmoji: "🦁", countryFlag: "🇨🇦", score: 1380, wordsFound: 112, league: "Diamond", isCurrentUser: false),
            LeaderboardUser(id: "3", rank: 3, username: profile.username, avatarEmoji: profile.avatarEmoji, countryFlag: profile.countryFlag, score: 980, wordsFound: 76, league: "Gold", isCurrentUser: true),
            LeaderboardUser(id: "4", rank: 4, username: "Maya Bloom", avatarEmoji: "🪷", countryFlag: "🇯🇵", score: 920, wordsFound: 71, league: "Gold", isCurrentUser: false)
        ]
    }
    
    // MARK: - Game Mode & Level Loading
    public func setGameMode(_ mode: GameMode) {
        currentMode = mode
        solvedWords.removeAll()
        solvedBonusWords.removeAll()
        currentWordInput = ""
        revealedLetters.removeAll()
        if mode == .daily {
            shuffledLetters = String(dailyPuzzle.letters.shuffled())
        } else {
            shuffledLetters = String(currentLevelData.letters.shuffled())
        }
    }
    
    public func loadLevel(_ id: Int) {
        if let level = levels.first(where: { $0.id == id }) {
            currentLevelData = level
            currentLevelIndex = level.levelNumber
            solvedWords.removeAll()
            solvedBonusWords.removeAll()
            currentWordInput = ""
            revealedLetters.removeAll()
            shuffledLetters = String(level.letters.shuffled())
        }
    }
    
    // MARK: - Input Actions
    public func onLetterTyped(_ char: Character) {
        currentWordInput.append(char.uppercased())
    }
    
    public func onBackspace() {
        if !currentWordInput.isEmpty {
            currentWordInput.removeLast()
        }
    }
    
    public func onClear() {
        currentWordInput = ""
    }
    
    public func shuffleLetters() {
        let source = currentMode == .daily ? dailyPuzzle.letters : currentLevelData.letters
        var shuffled = String(source.shuffled())
        while shuffled == source && source.count > 2 {
            shuffled = String(source.shuffled())
        }
        shuffledLetters = shuffled
    }
    
    public func submitWord(_ word: String) {
        let upper = word.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        guard !upper.isEmpty else { return }
        
        let targets = currentMode == .daily ? dailyPuzzle.targetWords.map { $0.word } : currentLevelData.targetWords.map { $0.word }
        let bonuses = currentMode == .daily ? dailyPuzzle.bonusWords : currentLevelData.bonusWords
        
        if targets.contains(upper) {
            if solvedWords.contains(upper) {
                showToast("Already found '\(upper)'!")
            } else {
                solvedWords.insert(upper)
                profile.coins += 10
                showToast("Great! Found '\(upper)' (+10🪙)")
                speak(upper)
                checkCompletion()
            }
        } else if bonuses.contains(upper) {
            if solvedBonusWords.contains(upper) {
                showToast("Bonus word already found!")
            } else {
                solvedBonusWords.insert(upper)
                profile.butterflies += 1
                showToast("🦋 Bonus word found! (+1 Butterfly)")
                speak(upper)
            }
        } else {
            showToast("Not in this puzzle!")
        }
        currentWordInput = ""
        saveProfile()
    }
    
    public func useHint() {
        guard profile.coins >= 25 else {
            showToast("Need 25🪙 for a hint!")
            return
        }
        
        let targets = currentMode == .daily ? dailyPuzzle.targetWords : currentLevelData.targetWords
        let unsolved = targets.filter { !solvedWords.contains($0.word) }
        guard let targetToHint = unsolved.randomElement() else { return }
        
        var revealed = revealedLetters[targetToHint.id] ?? Set<Int>()
        let unrevealedIndices = (0..<targetToHint.word.count).filter { !revealed.contains($0) }
        if let idx = unrevealedIndices.randomElement() {
            revealed.insert(idx)
            revealedLetters[targetToHint.id] = revealed
            profile.coins -= 25
            showToast("💡 Hint revealed a letter!")
            saveProfile()
        }
    }
    
    private func checkCompletion() {
        let targets = currentMode == .daily ? dailyPuzzle.targetWords.map { $0.word } : currentLevelData.targetWords.map { $0.word }
        if Set(targets).isSubset(of: solvedWords) {
            // Level / Daily complete!
            profile.stars += 3
            profile.coins += 50
            profile.currentStreak += 1
            if currentMode == .levels {
                profile.currentLevel = min(levels.count, profile.currentLevel + 1)
            }
            celebrationRewards = (3, 50, solvedBonusWords.count)
            isCelebrationShowing = true
            speak("Level Completed! Outstanding job!")
            saveProfile()
        }
    }
    
    public func nextLevel() {
        isCelebrationShowing = false
        if currentMode == .levels {
            let nextId = min(levels.count, currentLevelIndex + 1)
            loadLevel(nextId)
        }
    }
    
    public func claimDailyMysteryGift() {
        guard !isMysteryGiftClaimed else { return }
        isMysteryGiftClaimed = true
        profile.coins += 100
        profile.butterflies += 5
        profile.stars += 1
        showToast("🎁 Tada! +100🪙 +5🦋 +1⭐ Claimed!")
        saveProfile()
    }
    
    // MARK: - Speech
    public func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.45
        speechSynthesizer.speak(utterance)
    }
    
    // MARK: - Toast
    private func showToast(_ msg: String) {
        toastMessage = msg
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            if self.toastMessage == msg {
                self.toastMessage = nil
            }
        }
    }
    
    // MARK: - Persistence
    private func saveProfile() {
        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: "wp_user_profile")
        }
    }
}
