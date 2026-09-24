import SwiftUI

public struct ProfileSyncView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var backupText: String = ""
    @State private var selectedTab: Int = 0 // 0 = Settings, 1 = Leaderboard
    
    public var body: some View {
        VStack(spacing: 12) {
            Picker("Section", selection: $selectedTab) {
                Text("Settings & Sync").tag(0)
                Text("Leaderboard").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            if selectedTab == 0 {
                ScrollView {
                    VStack(spacing: 16) {
                        // Profile Info
                        HStack(spacing: 14) {
                            Text(viewModel.profile.avatarEmoji)
                                .font(.system(size: 40))
                                .frame(width: 60, height: 60)
                                .background(Color.yellow.opacity(0.2))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(viewModel.profile.username)
                                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                                Text("Level \(viewModel.profile.currentLevel) Explorer • \(viewModel.profile.countryFlag)")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(18)
                        
                        // Cloud Sync / Backup Payload Box
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .foregroundColor(.blue)
                                Text("Cross-Device Sync Payload")
                                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                            }
                            
                            Button(action: {
                                if let encoded = try? JSONEncoder().encode(viewModel.profile),
                                   let str = String(data: encoded, encoding: .utf8) {
                                    backupText = str
                                    UIPasteboard.general.string = str
                                }
                            }) {
                                Text("Export Backup JSON & Copy")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color.blue)
                                    .cornerRadius(12)
                            }
                            
                            if !backupText.isEmpty {
                                Text(backupText)
                                    .font(.system(size: 10, design: .monospaced))
                                    .padding(8)
                                    .background(Color(white: 0.95))
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(18)
                    }
                    .padding(.horizontal)
                }
            } else {
                // Leaderboard List
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.leaderboard) { user in
                            HStack {
                                Text("#\(user.rank)")
                                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                                    .foregroundColor(user.rank == 1 ? .yellow : (user.rank == 2 ? .gray : (user.rank == 3 ? .orange : .black)))
                                    .frame(width: 32)
                                
                                Text(user.avatarEmoji)
                                    .font(.system(size: 24))
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    HStack {
                                        Text(user.username)
                                            .font(.system(size: 13, weight: .bold))
                                        if user.isCurrentUser {
                                            Text("(You)")
                                                .font(.caption2)
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    Text("\(user.wordsFound) words found • \(user.league) League")
                                        .font(.system(size: 11))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text("\(user.score) pts")
                                    .font(.system(size: 13, weight: .black, design: .rounded))
                                    .foregroundColor(Color(red: 0.01, green: 0.41, blue: 0.63))
                            }
                            .padding(12)
                            .background(user.isCurrentUser ? Color(red: 0.88, green: 0.97, blue: 1.0) : Color.white)
                            .cornerRadius(14)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.top, 8)
    }
}
