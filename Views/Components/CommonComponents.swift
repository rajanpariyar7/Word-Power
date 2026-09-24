import SwiftUI

// MARK: - Top Game Status Bar

public struct TopGameBar: View {
    public let coins: Int
    public let butterflies: Int
    public let stars: Int
    public let streak: Int
    public let onDictionaryClick: () -> Void
    public let onSettingsClick: () -> Void

    public init(
        coins: Int,
        butterflies: Int,
        stars: Int,
        streak: Int,
        onDictionaryClick: @escaping () -> Void,
        onSettingsClick: @escaping () -> Void
    ) {
        self.coins = coins
        self.butterflies = butterflies
        self.stars = stars
        self.streak = streak
        self.onDictionaryClick = onDictionaryClick
        self.onSettingsClick = onSettingsClick
    }

    public var body: some View {
        HStack(spacing: 8) {
            // Coins Badge
            ResourceBadge(
                emoji: "🪙",
                text: "\(coins)",
                bgColor: Color(0xFFFFF8E1),
                textColor: Color(0xFFE65100),
                borderColor: AppTheme.coinBronze
            )

            // Butterflies Badge
            ResourceBadge(
                emoji: "🦋",
                text: "\(butterflies)",
                bgColor: Color(0xFFE1F5FE),
                textColor: Color(0xFF0277BD),
                borderColor: AppTheme.butterflyBlue
            )

            // Stars Badge
            ResourceBadge(
                emoji: "⭐",
                text: "\(stars)",
                bgColor: Color(0xFFFFFDE7),
                textColor: Color(0xFFF57F17),
                borderColor: AppTheme.starGold
            )

            // Streak Badge
            ResourceBadge(
                emoji: "🔥",
                text: "\(streak)d",
                bgColor: Color(0xFFFBE9E7),
                textColor: Color(0xFFD84315),
                borderColor: AppTheme.streakFire
            )

            Spacer()

            // Quick Lexicon Button
            Button(action: onDictionaryClick) {
                Image(systemName: "book.closed.fill")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(AppTheme.goldAccent)
                    .frame(width: 36, height: 36)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Circle())
            }

            // Settings / Profile Button
            Button(action: onSettingsClick) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(AppTheme.vibrantPrimary)
                    .frame(width: 36, height: 36)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(Color.black.opacity(0.2))
    }
}

// MARK: - Resource Badge

public struct ResourceBadge: View {
    public let emoji: String
    public let text: String
    public let bgColor: Color
    public let textColor: Color
    public let borderColor: Color

    public init(
        emoji: String,
        text: String,
        bgColor: Color = Color.white.opacity(0.15),
        textColor: Color = .white,
        borderColor: Color = .clear
    ) {
        self.emoji = emoji
        self.text = text
        self.bgColor = bgColor
        self.textColor = textColor
        self.borderColor = borderColor
    }

    public var body: some View {
        HStack(spacing: 3) {
            Text(emoji)
                .font(.system(size: 12))
            Text(text)
                .font(.system(size: 12, weight: .black))
                .foregroundColor(textColor)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(bgColor)
        .overlay(
            Capsule()
                .stroke(borderColor.opacity(0.5), lineWidth: 1)
        )
        .clipShape(Capsule())
    }
}

// MARK: - Floating Toast

public struct FloatingToastView: View {
    public let toast: ToastMessage

    public var body: some View {
        HStack(spacing: 8) {
            Text(toast.message)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(
            toast.isBonus
                ? LinearGradient(colors: [Color(0xFF0288D1), Color(0xFF01579B)], startPoint: .leading, endPoint: .trailing)
                : LinearGradient(colors: [Color(0xFF3E2723), Color(0xFF261815)], startPoint: .leading, endPoint: .trailing)
        )
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.35), radius: 10, x: 0, y: 5)
    }
}
