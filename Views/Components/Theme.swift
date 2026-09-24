import SwiftUI

public struct AppTheme {
    // Vibrant Palette (Default Theme)
    public static let vibrantPrimary = Color(0xFFD0BCFF)
    public static let vibrantOnPrimary = Color(0xFF381E72)
    public static let vibrantPrimaryContainer = Color(0xFF4F378B)
    public static let vibrantOnPrimaryContainer = Color(0xFFEADDFF)
    public static let vibrantBackground = Color(0xFF1C1B1F)
    public static let vibrantSurface = Color(0xFF2B2930)
    public static let vibrantSurfaceVariant = Color(0xFF3B383E)
    public static let vibrantOutline = Color(0xFF938F99)

    // Woodcraft Classic Palette
    public static let woodPrimary = Color(0xFFD4A373)
    public static let woodBackground = Color(0xFF2C1D11)
    public static let woodSurface = Color(0xFF3D2817)
    public static let woodSurfaceVariant = Color(0xFF533822)

    // Midnight Obsidian Palette
    public static let midnightPrimary = Color(0xFF82B1FF)
    public static let midnightBackground = Color(0xFF0D1117)
    public static let midnightSurface = Color(0xFF161B22)
    public static let midnightSurfaceVariant = Color(0xFF21262D)

    // Emerald Velvet Palette
    public static let emeraldPrimary = Color(0xFF69F0AE)
    public static let emeraldBackground = Color(0xFF0A1F14)
    public static let emeraldSurface = Color(0xFF133624)
    public static let emeraldSurfaceVariant = Color(0xFF1B4D33)

    // Shared Accent Colors
    public static let goldAccent = Color(0xFFFFD54F)
    public static let goldDark = Color(0xFFFFB300)
    public static let amberGlow = Color(0xFFFFC107)
    public static let streakFire = Color(0xFFFF6D00)
    public static let butterflyBlue = Color(0xFF40C4FF)
    public static let starGold = Color(0xFFFFD700)
    public static let coinBronze = Color(0xFFFFA000)

    public static func backgroundColor(for theme: AppThemeSetting) -> Color {
        switch theme {
        case .vibrantPalette: return vibrantBackground
        case .woodClassic: return woodBackground
        case .midnightDark: return midnightBackground
        case .emeraldVelvet: return emeraldBackground
        }
    }

    public static func surfaceColor(for theme: AppThemeSetting) -> Color {
        switch theme {
        case .vibrantPalette: return vibrantSurface
        case .woodClassic: return woodSurface
        case .midnightDark: return midnightSurface
        case .emeraldVelvet: return emeraldSurface
        }
    }

    public static func surfaceVariantColor(for theme: AppThemeSetting) -> Color {
        switch theme {
        case .vibrantPalette: return vibrantSurfaceVariant
        case .woodClassic: return woodSurfaceVariant
        case .midnightDark: return midnightSurfaceVariant
        case .emeraldVelvet: return emeraldSurfaceVariant
        }
    }

    public static func primaryColor(for theme: AppThemeSetting) -> Color {
        switch theme {
        case .vibrantPalette: return vibrantPrimary
        case .woodClassic: return woodPrimary
        case .midnightDark: return midnightPrimary
        case .emeraldVelvet: return emeraldPrimary
        }
    }
}
