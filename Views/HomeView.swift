import SwiftUI
import AVFoundation

public struct HomeView: View {
    @ObservedObject var viewModel: GameViewModel
    var onPlayLevel: (Int) -> Void
    var onPlayDaily: () -> Void
    var onOpenVocab: () -> Void
    var onOpenSettings: () -> Void
    
    @State private var activeSong: WordSongItem? = nil
    @State private var spotlightIndex: Int = 0
    
    private let sampleSpotlights = ["CAT", "SUN", "PEAR", "FLAME", "BRAVE"]
    
    private let wordSongs: [WordSongItem] = [
        WordSongItem(
            title: "The Alphabet Animal Song",
            category: "Nature & Friends",
            iconEmoji: "🦁",
            color: Color(red: 1.0, green: 0.16, blue: 0.48),
            durationText: "1:20",
            lyrics: [
                "C is for CAT, purring so sweet!",
                "B is for BEAR, with fuzzy big feet!",
                "F is for FROG, hopping in the lake!",
                "L is for LION, brave and awake!"
            ],
            featuredWords: ["CAT", "BEAR", "FROG", "LION"]
        ),
        WordSongItem(
            title: "Colors & Shapes Dance",
            category: "Fun Learning",
            iconEmoji: "🎨",
            color: Color(red: 0.55, green: 0.14, blue: 0.67),
            durationText: "1:15",
            lyrics: [
                "Red is the apple, sweet and so round!",
                "Blue is the ocean, waves make a sound!",
                "Yellow is the sun, shining up high!",
                "Green is the leaf dancing in the sky!"
            ],
            featuredWords: ["RED", "BLUE", "SUN", "LEAF"]
        ),
        WordSongItem(
            title: "Family Love & Happy Body",
            category: "Me & My Family",
            iconEmoji: "👨‍👩‍👧",
            color: Color(red: 1.0, green: 0.48, blue: 0.0),
            durationText: "1:10",
            lyrics: [
                "Here is my smiling face, look at my eyes!",
                "Clap with two little hands, reach for the skies!",
                "Mom gives a warm hug, Dad holds my hand!",
                "We are the happiest crew in the land!"
            ],
            featuredWords: ["FACE", "HAND", "SMILE", "HUG"]
        ),
        WordSongItem(
            title: "Yummy Fruit Picnic Party",
            category: "Nature & Fruits",
            iconEmoji: "🍎",
            color: Color(red: 0.0, green: 0.9, blue: 0.46),
            durationText: "1:05",
            lyrics: [
                "Pick a fresh PEAR from the sunny green tree!",
                "Sweet juicy MELON for you and for me!",
                "Crunchy red APPLE, so healthy and bright!",
                "Word Power friends have a wonderful bite!"
            ],
            featuredWords: ["PEAR", "APPLE", "TREE", "SWEET"]
        )
    ]
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Top Status Bar (Coins, Butterflies, Streak)
                HStack {
                    HStack(spacing: 4) {
                        Text("🪙")
                        Text("\(viewModel.profile.coins)")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.7, green: 0.35, blue: 0.05))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.yellow, lineWidth: 1))
                    
                    HStack(spacing: 4) {
                        Text("🦋")
                        Text("\(viewModel.profile.butterflies)")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.01, green: 0.52, blue: 0.78))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(red: 0.88, green: 0.97, blue: 1.0))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.cyan, lineWidth: 1))
                    
                    HStack(spacing: 4) {
                        Text("🔥")
                        Text("\(viewModel.profile.currentStreak)")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundColor(Color.red)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(red: 1.0, green: 0.93, blue: 0.94))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.pink.opacity(0.5), lineWidth: 1))
                    
                    Spacer()
                    
                    // Dictionary quick lookup button
                    Button(action: onOpenVocab) {
                        HStack(spacing: 4) {
                            Text("Aa")
                                .font(.system(size: 13, weight: .black))
                            Image(systemName: "book.fill")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color(red: 1.0, green: 0.16, blue: 0.48))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                // Mascot Header Greeting Card
                HStack {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color(red: 1.0, green: 0.16, blue: 0.48))
                            .frame(width: 48, height: 48)
                            .overlay(Text("🦉").font(.system(size: 26)))
                        
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text("Word Power")
                                    .font(.system(size: 17, weight: .heavy, design: .rounded))
                                    .foregroundColor(Color(red: 0.85, green: 0.11, blue: 0.38))
                                Text("👑")
                            }
                            Text("Level \(viewModel.profile.currentLevel) Explorer • 125+ Fun Words")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    Button(action: {
                        viewModel.speak("Welcome to Word Power! Let's explore, play, and learn words!")
                    }) {
                        Circle()
                            .fill(Color(red: 1.0, green: 0.82, blue: 0.0))
                            .frame(width: 42, height: 42)
                            .overlay(
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color(red: 0.23, green: 0.12, blue: 0.02))
                            )
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.04), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                
                // Hero Card Banner
                ZStack(alignment: .bottomLeading) {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            LinearGradient(
                                colors: [Color(red: 0.2, green: 0.5, blue: 0.95), Color(red: 1.0, green: 0.16, blue: 0.48)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 180)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("✨ WORD ADVENTURE")
                            .font(.system(size: 11, weight: .black, design: .rounded))
                            .foregroundColor(Color(red: 0.23, green: 0.12, blue: 0.02))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.yellow)
                            .cornerRadius(10)
                        
                        Text("Play, Sing & Master Words!")
                            .font(.system(size: 22, weight: .heavy, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Explore 3 magical worlds with songs & games")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(20)
                }
                .padding(.horizontal)
                
                // Main CTAs: Play Level + Daily Quest
                HStack(spacing: 12) {
                    Button(action: { onPlayLevel(viewModel.profile.currentLevel) }) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("PLAY LEVEL \(viewModel.profile.currentLevel)")
                                .font(.system(size: 14, weight: .black, design: .rounded))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color(red: 1.0, green: 0.16, blue: 0.48))
                        .cornerRadius(18)
                        .shadow(color: Color.red.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                    
                    Button(action: onPlayDaily) {
                        HStack {
                            Image(systemName: "calendar")
                            Text("DAILY QUEST")
                                .font(.system(size: 13, weight: .heavy, design: .rounded))
                        }
                        .foregroundColor(Color(red: 0.23, green: 0.12, blue: 0.02))
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color(red: 1.0, green: 0.82, blue: 0.0))
                        .cornerRadius(18)
                        .shadow(color: Color.yellow.opacity(0.4), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                
                // Daily Surprise Chest Card
                HStack {
                    Circle()
                        .fill(viewModel.isMysteryGiftClaimed ? Color.green : Color.yellow)
                        .frame(width: 46, height: 46)
                        .overlay(Text(viewModel.isMysteryGiftClaimed ? "🎉" : "🎁").font(.system(size: 22)))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(viewModel.isMysteryGiftClaimed ? "Daily Gift Claimed!" : "Daily Word Power Gift Ready!")
                            .font(.system(size: 14, weight: .heavy, design: .rounded))
                            .foregroundColor(viewModel.isMysteryGiftClaimed ? Color(red: 0.18, green: 0.49, blue: 0.20) : Color(red: 0.42, green: 0.27, blue: 0.0))
                        Text(viewModel.isMysteryGiftClaimed ? "Great job! Keep up your streak tomorrow!" : "Tap to open surprise coins, stars & butterflies!")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: { viewModel.claimDailyMysteryGift() }) {
                        Text(viewModel.isMysteryGiftClaimed ? "OPENED" : "TAP OPEN")
                            .font(.system(size: 10, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(viewModel.isMysteryGiftClaimed ? Color.green : Color.orange)
                            .cornerRadius(10)
                    }
                }
                .padding(14)
                .background(viewModel.isMysteryGiftClaimed ? Color(red: 0.95, green: 0.98, blue: 0.92) : Color(red: 1.0, green: 0.98, blue: 0.86))
                .cornerRadius(20)
                .padding(.horizontal)
                
                // 3 Word Worlds
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("🌍 THE 3 WORD WORLDS")
                            .font(.system(size: 15, weight: .black, design: .rounded))
                        Spacer()
                        Text("125+ WORDS")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(Color(red: 0.85, green: 0.11, blue: 0.38))
                    }
                    
                    WorldCardView(title: "Me and My Family", badge: "42 Words • 9 Songs", desc: "Body parts, family members, feelings & clothes", color: Color(red: 1.0, green: 0.16, blue: 0.48), emoji: "👨‍👩‍👧") {
                        onPlayLevel(1)
                    }
                    WorldCardView(title: "Nature All Around Me", badge: "45 Words • 9 Songs", desc: "Animals, fruits, sunny weather, seasons & plants", color: Color(red: 0.0, green: 0.9, blue: 0.46), emoji: "🌳") {
                        onPlayLevel(2)
                    }
                    WorldCardView(title: "Fun Learning Time", badge: "38 Words • 9 Songs", desc: "Colors, numbers, vehicles & opposites", color: Color(red: 0.55, green: 0.14, blue: 0.67), emoji: "🎨") {
                        onPlayLevel(3)
                    }
                }
                .padding(.horizontal)
                
                // Sing-Along Songs Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("🎵 SING-ALONG WORD SONGS")
                            .font(.system(size: 15, weight: .black, design: .rounded))
                        Spacer()
                        Text("27 Songs")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(Color(red: 1.0, green: 0.16, blue: 0.48))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(red: 1.0, green: 0.93, blue: 0.96))
                            .cornerRadius(8)
                    }
                    
                    ForEach(wordSongs) { song in
                        HStack {
                            Circle()
                                .fill(song.color.opacity(0.15))
                                .frame(width: 40, height: 40)
                                .overlay(Text(song.iconEmoji).font(.system(size: 20)))
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(song.title)
                                    .font(.system(size: 13, weight: .bold, design: .rounded))
                                Text("\(song.category) • \(song.durationText)")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: {
                                activeSong = song
                                viewModel.speak("Let's sing \(song.title)!")
                            }) {
                                Image(systemName: "play.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .frame(width: 32, height: 32)
                                    .background(song.color)
                                    .clipShape(Circle())
                            }
                        }
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 1)
                    }
                }
                .padding(.horizontal)
                
                Spacer(minLength: 24)
            }
            .padding(.vertical)
        }
        .sheet(item: $activeSong) { song in
            VStack(spacing: 20) {
                Text(song.iconEmoji)
                    .font(.system(size: 50))
                Text(song.title)
                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                Text(song.category)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(song.color)
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(song.lyrics, id: \.self) { line in
                        Text(line)
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                    }
                }
                .padding()
                .background(Color(white: 0.97))
                .cornerRadius(16)
                
                Button(action: {
                    let fullText = song.lyrics.joined(separator: ". ")
                    viewModel.speak(fullText)
                }) {
                    HStack {
                        Image(systemName: "music.note")
                        Text("SING SONG ALOUD")
                            .font(.system(size: 14, weight: .black, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(song.color)
                    .cornerRadius(16)
                }
            }
            .padding(24)
        }
    }
}

struct WorldCardView: View {
    let title: String
    let badge: String
    let desc: String
    let color: Color
    let emoji: String
    let onPlay: () -> Void
    
    var body: some View {
        Button(action: onPlay) {
            HStack(spacing: 14) {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 50, height: 50)
                    .overlay(Text(emoji).font(.system(size: 26)))
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text(title)
                            .font(.system(size: 14, weight: .heavy, design: .rounded))
                            .foregroundColor(Color(white: 0.15))
                        Spacer()
                        Text(badge)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(color)
                    }
                    Text(desc)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
            }
            .padding(14)
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}
