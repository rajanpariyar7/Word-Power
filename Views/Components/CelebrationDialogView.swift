import SwiftUI

public struct CelebrationDialogView: View {
    public let celebration: CelebrationState
    public let onNextLevel: () -> Void
    public let onReplay: () -> Void
    public let onInspectWord: (String) -> Void

    public var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                // Header Trophy Icon & Title
                VStack(spacing: 6) {
                    Text("🏆")
                        .font(.system(size: 48))
                    Text("LEVEL \(celebration.levelNumber) COMPLETE!")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(AppTheme.goldAccent)
                }

                // Stars Rating Row
                HStack(spacing: 8) {
                    ForEach(0..<3) { idx in
                        Image(systemName: idx < celebration.starsEarned ? "star.fill" : "star")
                            .font(.system(size: 28))
                            .foregroundColor(idx < celebration.starsEarned ? AppTheme.starGold : Color.white.opacity(0.3))
                    }
                }

                // Rewards Banner
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Text("🪙")
                        Text("+\(celebration.coinsEarned)")
                            .font(.system(size: 15, weight: .black))
                            .foregroundColor(AppTheme.coinBronze)
                    }
                    HStack(spacing: 4) {
                        Text("🦋")
                        Text("+\(celebration.butterfliesEarned)")
                            .font(.system(size: 15, weight: .black))
                            .foregroundColor(AppTheme.butterflyBlue)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.1))
                .clipShape(Capsule())

                // Words Discovered (Interactive)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Words Discovered (Tap to learn):")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white.opacity(0.7))

                    FlowLayout(spacing: 6) {
                        ForEach(celebration.solvedWords, id: \.self) { word in
                            Button(action: { onInspectWord(word) }) {
                                HStack(spacing: 3) {
                                    Text(word)
                                        .font(.system(size: 12, weight: .black))
                                    Image(systemName: "book.fill")
                                        .font(.system(size: 9))
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color(0xFFFFF8E7))
                                .foregroundColor(Color(0xFF4A2810))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }

                    if !celebration.bonusWords.isEmpty {
                        Text("Bonus Words Found:")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(AppTheme.butterflyBlue)
                            .padding(.top, 4)

                        FlowLayout(spacing: 6) {
                            ForEach(celebration.bonusWords, id: \.self) { word in
                                Text("🦋 \(word)")
                                    .font(.system(size: 11, weight: .bold))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(AppTheme.butterflyBlue.opacity(0.2))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)

                // Action Buttons: Next Level & Replay
                HStack(spacing: 12) {
                    Button(action: onReplay) {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Replay")
                        }
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white.opacity(0.8))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    Button(action: onNextLevel) {
                        HStack(spacing: 6) {
                            Text("Next Level")
                            Image(systemName: "arrow.right.circle.fill")
                        }
                        .font(.system(size: 15, weight: .black))
                        .foregroundColor(Color(0xFF331A00))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(AppTheme.goldAccent)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.top, 8)
            }
            .padding(20)
            .background(
                LinearGradient(
                    colors: [Color(0xFF2C2630), Color(0xFF1E1A22)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(AppTheme.goldAccent, lineWidth: 2)
            )
            .padding(24)
        }
    }
}

// Simple FlowLayout helper for badges in SwiftUI
public struct FlowLayout: Layout {
    public var spacing: CGFloat = 6

    public init(spacing: CGFloat = 6) {
        self.spacing = spacing
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 300
        var height: CGFloat = 0
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var maxHeightInRow: CGFloat = 0

        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if currentX + size.width > width && currentX > 0 {
                currentX = 0
                currentY += maxHeightInRow + spacing
                maxHeightInRow = 0
            }
            currentX += size.width + spacing
            maxHeightInRow = max(maxHeightInRow, size.height)
            height = max(height, currentY + maxHeightInRow)
        }
        return CGSize(width: width, height: height)
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var currentX: CGFloat = bounds.minX
        var currentY: CGFloat = bounds.minY
        var maxHeightInRow: CGFloat = 0

        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if currentX + size.width > bounds.maxX && currentX > bounds.minX {
                currentX = bounds.minX
                currentY += maxHeightInRow + spacing
                maxHeightInRow = 0
            }
            view.place(at: CGPoint(x: currentX, y: currentY), proposal: ProposedViewSize(size))
            currentX += size.width + spacing
            maxHeightInRow = max(maxHeightInRow, size.height)
        }
    }
}
