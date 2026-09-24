import SwiftUI

public struct VocabularyView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var searchText: String = ""
    @State private var filterOnlyMastered: Bool = false
    
    private var filteredList: [WordDefinition] {
        viewModel.vocabulary.filter { item in
            let matchText = searchText.isEmpty || item.word.localizedCaseInsensitiveContains(searchText) || item.definition.localizedCaseInsensitiveContains(searchText)
            let matchFilter = !filterOnlyMastered || item.isMastered
            return matchText && matchFilter
        }
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            // Search & Filter Bar
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search words or meanings...", text: $searchText)
                        .font(.system(size: 14))
                }
                .padding(10)
                .background(Color(white: 0.95))
                .cornerRadius(12)
                
                Button(action: { filterOnlyMastered.toggle() }) {
                    Text(filterOnlyMastered ? "✅ Mastered" : "All Words")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(filterOnlyMastered ? .white : .gray)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .background(filterOnlyMastered ? Color.green : Color(white: 0.92))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            
            // List of Cards
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(filteredList) { word in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(word.word)
                                    .font(.system(size: 20, weight: .black, design: .rounded))
                                    .foregroundColor(Color(red: 0.85, green: 0.11, blue: 0.38))
                                Text(word.phonetic)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.gray)
                                Spacer()
                                
                                // Pronounce audio button
                                Button(action: { viewModel.speak(word.word) }) {
                                    Image(systemName: "speaker.wave.2.fill")
                                        .foregroundColor(Color.cyan)
                                        .padding(8)
                                        .background(Color.cyan.opacity(0.12))
                                        .clipShape(Circle())
                                }
                            }
                            
                            Text(word.definition)
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(Color(white: 0.2))
                            
                            if !word.example.isEmpty {
                                Text("\"\(word.example)\"")
                                    .font(.system(size: 12, weight: .medium, design: .serif))
                                    .italic()
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                if word.isMastered {
                                    Text("⭐ Mastered")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.green)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 3)
                                        .background(Color.green.opacity(0.1))
                                        .cornerRadius(6)
                                }
                                Text(word.partOfSpeech.capitalized)
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 3)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(6)
                            }
                        }
                        .padding(14)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 1)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top, 8)
    }
}
