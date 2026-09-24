import SwiftUI

public struct WordGridView: View {
    public let targetWords: [CrosswordWord]
    public let solvedWords: Set<String>
    public let hintRevealedLetters: [String: Set<Int>]
    public let onWordClick: (String) -> Void
    public let quoteHint: String?

    public init(
        targetWords: [CrosswordWord],
        solvedWords: Set<String>,
        hintRevealedLetters: [String: Set<Int>],
        onWordClick: @escaping (String) -> Void,
        quoteHint: String? = nil
    ) {
        self.targetWords = targetWords
        self.solvedWords = solvedWords
        self.hintRevealedLetters = hintRevealedLetters
        self.onWordClick = onWordClick
        self.quoteHint = quoteHint
    }

    public var body: some View {
        VStack(spacing: 10) {
            // Optional quote hint banner
            if let quote = quoteHint, !quote.isEmpty {
                HStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .foregroundColor(AppTheme.goldDark)
                        .font(.system(size: 13, weight: .bold))
                    Text("\"\(quote)\"")
                        .font(.system(size: 12, weight: .medium))
                        .italic()
                        .foregroundColor(AppTheme.vibrantOnPrimaryContainer)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(AppTheme.vibrantPrimaryContainer.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            // Word Slot Cards (2 columns or flexible wrapping)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                ForEach(targetWords) { item in
                    let isSolved = solvedWords.contains(item.word.uppercased())
                    let revealed = hintRevealedLetters[item.word.uppercased()] ?? []

                    WordSlotCard(
                        crosswordWord: item,
                        isSolved: isSolved,
                        revealedIndices: revealed,
                        onClick: {
                            if isSolved {
                                onWordClick(item.word)
                            }
                        }
                    )
                }
            }
        }
        .padding(12)
        .background(Color.white.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
        .padding(.horizontal, 12)
    }
}

public struct WordSlotCard: View {
    public let crosswordWord: CrosswordWord
    public let isSolved: Bool
    public let revealedIndices: Set<Int>
    public let onClick: () -> Void

    public var body: some View {
        Button(action: onClick) {
            HStack(spacing: 3) {
                ForEach(Array(crosswordWord.word.enumerated()), id: \.offset) { index, char in
                    let isRevealed = isSolved || revealedIndices.contains(index)
                    WoodenLetterTile(
                        char: isRevealed ? char : nil,
                        isSolved: isSolved,
                        isHinted: !isSolved && revealedIndices.contains(index)
                    )
                }

                if isSolved {
                    Image(systemName: "book.fill")
                        .font(.system(size: 11))
                        .foregroundColor(AppTheme.goldDark)
                        .padding(.leading, 2)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(isSolved ? Color.white.opacity(0.12) : Color.black.opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSolved ? AppTheme.goldAccent.opacity(0.6) : Color.white.opacity(0.1), lineWidth: 1)
            )
            .scaleEffect(isSolved ? 1.02 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSolved)
        }
        .buttonStyle(.plain)
        .disabled(!isSolved)
    }
}

public struct WoodenLetterTile: View {
    public let char: Character?
    public let isSolved: Bool
    public let isHinted: Bool

    public var body: some View {
        ZStack {
            if isSolved {
                LinearGradient(
                    colors: [Color(0xFFFFF8E7), Color(0xFFF3D9A8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            } else if isHinted {
                LinearGradient(
                    colors: [Color(0xFFFFF9C4), Color(0xFFFFE082)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            } else {
                LinearGradient(
                    colors: [Color.white.opacity(0.15), Color.white.opacity(0.08)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }

            if let c = char {
                Text(String(c))
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(isSolved ? Color(0xFF3B1E08) : Color(0xFF8D5325))
            } else {
                Circle()
                    .fill(Color.white.opacity(0.35))
                    .frame(width: 5, height: 5)
            }
        }
        .frame(width: 32, height: 32)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(
                    isSolved ? Color(0xFFB08958) : (isHinted ? AppTheme.goldAccent : Color.white.opacity(0.2)),
                    lineWidth: 1
                )
        )
    }
}
