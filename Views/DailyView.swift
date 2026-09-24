import SwiftUI

public struct DailyView: View {
    @ObservedObject var viewModel: GameViewModel
    var onStartDailyGame: () -> Void
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header card
                VStack(spacing: 8) {
                    Text("☀️")
                        .font(.system(size: 40))
                    Text("DAILY VOCABULARY QUEST")
                        .font(.system(size: 16, weight: .black, design: .rounded))
                        .foregroundColor(Color(red: 0.7, green: 0.35, blue: 0.05))
                    Text("Day #\(viewModel.dailyPuzzle.dayNumber) • \(viewModel.dailyPuzzle.theme)")
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                    Text("\"\(viewModel.dailyPuzzle.quoteOfTheDay)\"")
                        .font(.system(size: 13, weight: .medium, design: .serif))
                        .italic()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                .cornerRadius(20)
                .padding(.horizontal)
                
                // Play Daily Challenge Button
                Button(action: {
                    viewModel.setGameMode(.daily)
                    onStartDailyGame()
                }) {
                    HStack {
                        Image(systemName: "play.circle.fill")
                        Text("PLAY TODAY'S PUZZLE")
                            .font(.system(size: 14, weight: .heavy, design: .rounded))
                    }
                    .foregroundColor(Color(red: 0.23, green: 0.12, blue: 0.02))
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.yellow)
                    .cornerRadius(18)
                    .shadow(color: Color.yellow.opacity(0.4), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal)
                
                // Streak & Stats Card
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Current Streak")
                            .font(.caption)
                            .foregroundColor(.gray)
                        HStack {
                            Text("🔥")
                            Text("\(viewModel.profile.currentStreak) Days")
                                .font(.system(size: 16, weight: .black, design: .rounded))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Best Streak")
                            .font(.caption)
                            .foregroundColor(.gray)
                        HStack {
                            Text("🏆")
                            Text("\(viewModel.profile.bestStreak) Days")
                                .font(.system(size: 16, weight: .black, design: .rounded))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}
