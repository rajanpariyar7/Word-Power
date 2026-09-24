import SwiftUI

public struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var selectedTab: Int = 0
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(
                viewModel: viewModel,
                onPlayLevel: { levelId in
                    viewModel.setGameMode(.levels)
                    viewModel.loadLevel(levelId)
                    selectedTab = 1
                },
                onPlayDaily: {
                    viewModel.setGameMode(.daily)
                    selectedTab = 1
                },
                onOpenVocab: { selectedTab = 3 },
                onOpenSettings: { selectedTab = 4 }
            )
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            GameView(
                viewModel: viewModel,
                onOpenVocab: { selectedTab = 3 },
                onOpenSettings: { selectedTab = 4 }
            )
            .tabItem {
                Label("Puzzles", systemImage: "play.circle.fill")
            }
            .tag(1)
            
            DailyView(
                viewModel: viewModel,
                onStartDailyGame: {
                    selectedTab = 1
                }
            )
            .tabItem {
                Label("Daily", systemImage: "calendar")
            }
            .tag(2)
            
            VocabularyView(viewModel: viewModel)
                .tabItem {
                    Label("Cards", systemImage: "book.fill")
                }
                .tag(3)
            
            ProfileSyncView(viewModel: viewModel)
                .tabItem {
                    Label("Sync", systemImage: "gearshape.fill")
                }
                .tag(4)
        }
        .accentColor(Color(red: 1.0, green: 0.16, blue: 0.48))
    }
}
