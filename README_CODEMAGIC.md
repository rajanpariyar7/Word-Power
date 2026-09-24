# Word Power — iOS Build & Codemagic Guide

This directory contains the complete, native iOS source code for **Word Power** built with **SwiftUI** (iOS 16+) and configured for automated cloud builds using **Codemagic CI/CD**.

---

## 📁 Architecture Overview

```
ios/
├── WordPowerApp.swift             # App @main entry point
├── Models/
│   └── Models.swift               # LevelData, WordDefinition, DailyPuzzle, UserProfile, LeaderboardUser
├── ViewModels/
│   └── GameViewModel.swift        # State engine, speech synthesis, word verification, hint logic
├── Views/
│   ├── ContentView.swift          # Main 5-tab navigation bar
│   ├── HomeView.swift             # Word Power Hero banner, Mascot greeting, 3 Worlds, 27 songs player
│   ├── GameView.swift             # Crossword grid, Letter Wheel & Letter Bank dual input
│   ├── DailyView.swift            # Daily quest, quote of the day, calendar streak
│   ├── VocabularyView.swift       # 125+ Lexicon cards with pronunciation
│   ├── ProfileSyncView.swift      # Cloud JSON backup export/restore, global leaderboard
│   └── Components/
│       └── LetterWheelView.swift  # SwiftUI Canvas circular wheel with swipe & tap gestures
├── Resources/
│   └── Info.plist                 # Bundle metadata (com.aistudio.wordpower, v4.0.0)
└── WordPower.xcodeproj/           # Xcode project configured for xcodebuild
```

---

## 🚀 Building on Codemagic

The root `codemagic.yaml` is pre-configured with two workflows:
1. `ios-wordpower-release`: Archives the iOS application, packages `.xcarchive`, and generates download links.
2. `ios-simulator-build`: Compiles an x86_64 / arm64 Simulator `.app.zip` for testing without Apple Developer certificates.

### Step-by-Step Instructions

1. **Connect Repository to Codemagic:**
   - Log in to [Codemagic](https://codemagic.io/).
   - Click **Add application** and select your Git repository.
   - Choose **iOS App** as the project type.

2. **Codemagic Configuration:**
   - Codemagic will automatically detect `codemagic.yaml` in the root of the repository.
   - Under **Workflow**, select either:
     - `ios-wordpower-release` for distribution / TestFlight.
     - `ios-simulator-build` for immediate simulator preview.

3. **(Optional) Apple Code Signing:**
   - For TestFlight or App Store distribution:
     - Go to **Codemagic > Teams > Apple Developer Portal**.
     - Add your App Store Connect API Key.
     - In the workflow settings, enable automatic code signing for `com.aistudio.wordpower`.

4. **Start the Build:**
   - Click **Start new build**.
   - Codemagic will spin up a macOS M2 runner, build the SwiftUI application, and email you when finished.
   - Download the generated `.zip` / `.ipa` directly from the **Artifacts** tab!

---

## 💻 Local macOS Development

To run or edit in Xcode on a Mac:
```bash
cd ios
open WordPower.xcodeproj
```
Select any iPhone simulator (e.g. iPhone 15 Pro) and press **Cmd + R** to run.
