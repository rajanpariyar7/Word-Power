import SwiftUI

public struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    var onOpenVocab: () -> Void
    var onOpenSettings: () -> Void
    
    public var body: some View {
        ZStack {
            VStack(spacing: 8) {
                // Top Game Bar
                HStack {
                    HStack(spacing: 4) {
                        Text("🪙")
                        Text("\(viewModel.profile.coins)")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color(red: 0.7, green: 0.35, blue: 0.05))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                    .cornerRadius(12)
                    
                    HStack(spacing: 4) {
                        Text("🦋")
                        Text("\(viewModel.profile.butterflies)")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color(red: 0.01, green: 0.52, blue: 0.78))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(red: 0.88, green: 0.97, blue: 1.0))
                    .cornerRadius(12)
                    
                    Spacer()
                    
                    // Level / Mode indicator
                    Text(viewModel.currentMode == .daily ? "☀️ Daily" : "Lvl \(viewModel.currentLevelIndex)")
                        .font(.system(size: 13, weight: .black, design: .rounded))
                        .foregroundColor(Color(white: 0.2))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color(white: 0.95))
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // Mode Toggle Bar (Daily vs Levels)
                HStack(spacing: 10) {
                    Button(action: { viewModel.setGameMode(.daily) }) {
                        HStack(spacing: 4) {
                            Text("☀️")
                            Text("Daily Quest")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(viewModel.currentMode == .daily ? Color(red: 0.6, green: 0.2, blue: 0.0) : Color.gray)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(viewModel.currentMode == .daily ? Color(red: 1.0, green: 0.98, blue: 0.86) : Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(viewModel.currentMode == .daily ? Color.yellow : Color(white: 0.85), lineWidth: 1))
                    }
                    
                    Button(action: { viewModel.setGameMode(.levels) }) {
                        HStack(spacing: 4) {
                            Text("📚")
                            Text("Levels")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(viewModel.currentMode == .levels ? Color(red: 0.01, green: 0.41, blue: 0.63) : Color.gray)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(viewModel.currentMode == .levels ? Color(red: 0.88, green: 0.97, blue: 1.0) : Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(viewModel.currentMode == .levels ? Color.cyan : Color(white: 0.85), lineWidth: 1))
                    }
                    
                    Spacer()
                    
                    // Toggle Input Style: Wheel vs Letter Bank
                    Button(action: { viewModel.inputModeIsFields.toggle() }) {
                        HStack(spacing: 4) {
                            Image(systemName: viewModel.inputModeIsFields ? "hand.point.up.left.fill" : "keyboard")
                                .font(.system(size: 11))
                            Text(viewModel.inputModeIsFields ? "Wheel Mode" : "Tile Bank")
                                .font(.system(size: 11, weight: .bold))
                        }
                        .foregroundColor(Color.blue)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                // Puzzle Target Words Crossword / Box Grid
                ScrollView(.vertical, showsIndicators: false) {
                    let targets = viewModel.currentMode == .daily ? viewModel.dailyPuzzle.targetWords : viewModel.currentLevelData.targetWords
                    VStack(spacing: 8) {
                        ForEach(targets) { item in
                            let isSolved = viewModel.solvedWords.contains(item.word)
                            let revealedSet = viewModel.revealedLetters[item.id] ?? Set<Int>()
                            
                            HStack(spacing: 6) {
                                ForEach(0..<item.word.count, id: \.self) { idx in
                                    let charIndex = item.word.index(item.word.startIndex, offsetBy: idx)
                                    let char = String(item.word[charIndex])
                                    let isRevealed = isSolved || revealedSet.contains(idx)
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(isSolved ? Color(red: 0.0, green: 0.9, blue: 0.46) : (isRevealed ? Color(red: 1.0, green: 0.98, blue: 0.86) : Color(white: 0.96)))
                                            .frame(width: 38, height: 38)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(isSolved ? Color.green : (isRevealed ? Color.yellow : Color(white: 0.85)), lineWidth: 1.5)
                                            )
                                        
                                        if isRevealed {
                                            Text(char)
                                                .font(.system(size: 18, weight: .black, design: .rounded))
                                                .foregroundColor(isSolved ? .white : Color(red: 0.47, green: 0.21, blue: 0.06))
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxHeight: 180)
                
                // Bottom Input: Letter Wheel or Letter Bank
                if viewModel.inputModeIsFields {
                    // Letter Bank Input
                    VStack(spacing: 12) {
                        // Draft word
                        HStack {
                            Text(viewModel.currentWordInput.isEmpty ? "Tap letters below to form words" : viewModel.currentWordInput)
                                .font(.system(size: viewModel.currentWordInput.isEmpty ? 12 : 20, weight: .heavy, design: .rounded))
                                .foregroundColor(viewModel.currentWordInput.isEmpty ? .gray : Color(red: 0.47, green: 0.21, blue: 0.06))
                            Spacer()
                            if !viewModel.currentWordInput.isEmpty {
                                Button(action: { viewModel.onClear() }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        .frame(height: 38)
                        .padding(.horizontal, 14)
                        .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                        .cornerRadius(14)
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.yellow, lineWidth: 1))
                        
                        // Letter tiles
                        HStack(spacing: 8) {
                            ForEach(Array(viewModel.shuffledLetters.enumerated()), id: \.offset) { _, char in
                                Button(action: { viewModel.onLetterTyped(char) }) {
                                    Text(String(char))
                                        .font(.system(size: 20, weight: .black, design: .rounded))
                                        .foregroundColor(Color(red: 0.47, green: 0.21, blue: 0.06))
                                        .frame(width: 48, height: 48)
                                        .background(Color.yellow)
                                        .cornerRadius(12)
                                        .shadow(color: Color.orange.opacity(0.3), radius: 2, x: 0, y: 2)
                                }
                            }
                        }
                        
                        // Action row
                        HStack(spacing: 12) {
                            Button(action: { viewModel.shuffleLetters() }) {
                                Image(systemName: "shuffle")
                                    .font(.system(size: 16, weight: .bold))
                                    .padding(10)
                                    .background(Color(white: 0.95))
                                    .clipShape(Circle())
                            }
                            
                            Button(action: { viewModel.onBackspace() }) {
                                Image(systemName: "delete.left.fill")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.red)
                                    .padding(10)
                                    .background(Color(red: 1.0, green: 0.93, blue: 0.94))
                                    .clipShape(Circle())
                            }
                            
                            Button(action: { viewModel.useHint() }) {
                                Text("💡 25🪙")
                                    .font(.system(size: 12, weight: .bold))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                                    .cornerRadius(12)
                            }
                            
                            Button(action: { viewModel.submitWord(viewModel.currentWordInput) }) {
                                Text("SUBMIT GUESS")
                                    .font(.system(size: 13, weight: .black, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(viewModel.currentWordInput.count >= 2 ? Color.green : Color.gray.opacity(0.4))
                                    .cornerRadius(12)
                            }
                            .disabled(viewModel.currentWordInput.count < 2)
                        }
                    }
                    .padding()
                } else {
                    // Letter Wheel Mode
                    LetterWheelView(
                        letters: viewModel.shuffledLetters,
                        coins: viewModel.profile.coins,
                        onWordSelected: { word in viewModel.submitWord(word) },
                        onShuffle: { viewModel.shuffleLetters() },
                        onHint: { viewModel.useHint() }
                    )
                }
                
                Spacer()
            }
            .padding(.top, 4)
            
            // Toast Notification
            if let toast = viewModel.toastMessage {
                VStack {
                    Text(toast)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(Color.black.opacity(0.85))
                        .cornerRadius(20)
                        .shadow(radius: 6)
                        .padding(.top, 60)
                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                .animation(.easeInOut, value: viewModel.toastMessage)
            }
        }
        .sheet(isPresented: $viewModel.isCelebrationShowing) {
            VStack(spacing: 20) {
                Text("🎉")
                    .font(.system(size: 60))
                Text("PUZZLE SOLVED!")
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20))
                
                HStack(spacing: 20) {
                    VStack {
                        Text("⭐ +\(viewModel.celebrationRewards.stars)")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.orange)
                        Text("Stars").font(.caption)
                    }
                    VStack {
                        Text("🪙 +\(viewModel.celebrationRewards.coins)")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(Color(red: 0.7, green: 0.35, blue: 0.05))
                        Text("Coins").font(.caption)
                    }
                }
                .padding()
                .background(Color(white: 0.96))
                .cornerRadius(16)
                
                Button(action: { viewModel.nextLevel() }) {
                    Text("CONTINUE ADVENTURE →")
                        .font(.system(size: 15, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color(red: 0.0, green: 0.9, blue: 0.46))
                        .cornerRadius(18)
                }
            }
            .padding(28)
        }
    }
}
