import SwiftUI

public struct LetterWheelView: View {
    let letters: String
    let onWordSelected: (String) -> Void
    let onShuffle: () -> Void
    let onHint: () -> Void
    let coins: Int
    
    @State private var selectedIndices: [Int] = []
    @State private var dragLocation: CGPoint? = nil
    @State private var rotationAngle: Double = 0
    
    private let wheelRadius: CGFloat = 130
    private let tileRadius: CGFloat = 26
    
    public init(
        letters: String,
        coins: Int,
        onWordSelected: @escaping (String) -> Void,
        onShuffle: @escaping () -> Void,
        onHint: @escaping () -> Void
    ) {
        self.letters = letters
        self.coins = coins
        self.onWordSelected = onWordSelected
        self.onShuffle = onShuffle
        self.onHint = onHint
    }
    
    private var tilePositions: [(index: Int, char: Character, center: CGPoint)] {
        let count = letters.count
        guard count > 0 else { return [] }
        let center = CGPoint(x: wheelRadius, y: wheelRadius)
        let placementRadius = wheelRadius * 0.68
        
        return letters.enumerated().map { index, char in
            let angle = (Double(index) * (2 * Double.pi / Double(count))) - (Double.pi / 2)
            let x = center.x + CGFloat(cos(angle)) * placementRadius
            let y = center.y + CGFloat(sin(angle)) * placementRadius
            return (index, char, CGPoint(x: x, y: y))
        }
    }
    
    private var currentDraftWord: String {
        selectedIndices.map { String(letters[letters.index(letters.startIndex, offsetBy: $0)]) }.joined()
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            // Draft Preview Pill
            HStack {
                Text(currentDraftWord.isEmpty ? "SWIPE OR TAP LETTERS" : currentDraftWord)
                    .font(.system(size: currentDraftWord.isEmpty ? 12 : 20, weight: .black, design: .rounded))
                    .tracking(2)
                    .foregroundColor(currentDraftWord.isEmpty ? Color.gray : Color(red: 0.47, green: 0.21, blue: 0.06))
            }
            .frame(height: 40)
            .padding(.horizontal, 20)
            .background(currentDraftWord.isEmpty ? Color.white : Color(red: 1.0, green: 0.98, blue: 0.86))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(currentDraftWord.isEmpty ? Color(white: 0.85) : Color(red: 1.0, green: 0.70, blue: 0.0), lineWidth: 1.5)
            )
            
            // Wheel Canvas & Gesture Area
            ZStack {
                // Background Wheel Pan
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color.white, Color(red: 0.94, green: 0.98, blue: 1.0), Color(red: 0.88, green: 0.95, blue: 1.0)],
                            center: .center,
                            startRadius: 10,
                            endRadius: wheelRadius
                        )
                    )
                    .overlay(Circle().stroke(Color(red: 0.73, green: 0.90, blue: 0.99), lineWidth: 3))
                    .overlay(Circle().stroke(Color(white: 0.90), lineWidth: 6))
                    .frame(width: wheelRadius * 2, height: wheelRadius * 2)
                
                // Connecting lines
                Canvas { context, size in
                    if selectedIndices.count > 1 {
                        for i in 0..<(selectedIndices.count - 1) {
                            let idx1 = selectedIndices[i]
                            let idx2 = selectedIndices[i + 1]
                            if let p1 = tilePositions.first(where: { $0.index == idx1 })?.center,
                               let p2 = tilePositions.first(where: { $0.index == idx2 })?.center {
                                var path = Path()
                                path.move(to: p1)
                                path.addLine(to: p2)
                                context.stroke(path, with: .color(Color.orange.opacity(0.85)), lineWidth: 10)
                                context.stroke(path, with: .color(Color.yellow), lineWidth: 5)
                            }
                        }
                    }
                    if let lastIdx = selectedIndices.last,
                       let lastPos = tilePositions.first(where: { $0.index == lastIdx })?.center,
                       let drag = dragLocation {
                        var path = Path()
                        path.move(to: lastPos)
                        path.addLine(to: drag)
                        context.stroke(path, with: .color(Color.orange.opacity(0.7)), lineWidth: 6)
                    }
                }
                .frame(width: wheelRadius * 2, height: wheelRadius * 2)
                
                // Letter Tiles
                ForEach(tilePositions, id: \.index) { item in
                    let isSelected = selectedIndices.contains(item.index)
                    Circle()
                        .fill(isSelected ?
                              LinearGradient(colors: [Color.yellow, Color.orange], startPoint: .top, endPoint: .bottom) :
                              LinearGradient(colors: [Color.white, Color(red: 1.0, green: 0.98, blue: 0.92)], startPoint: .top, endPoint: .bottom))
                        .frame(width: tileRadius * 2, height: tileRadius * 2)
                        .overlay(Circle().stroke(isSelected ? Color(red: 0.9, green: 0.3, blue: 0) : Color.yellow, lineWidth: isSelected ? 3 : 2))
                        .shadow(color: Color.black.opacity(0.12), radius: 3, x: 0, y: 2)
                        .overlay(
                            Text(String(item.char))
                                .font(.system(size: 22, weight: .heavy, design: .rounded))
                                .foregroundColor(isSelected ? .white : Color(red: 0.27, green: 0.10, blue: 0.01))
                        )
                        .position(item.center)
                        .onTapGesture {
                            if selectedIndices.contains(item.index) {
                                selectedIndices.removeAll { $0 == item.index }
                            } else {
                                selectedIndices.append(item.index)
                            }
                        }
                }
                
                // Center Shuffle Button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        rotationAngle += 360
                    }
                    selectedIndices.removeAll()
                    onShuffle()
                }) {
                    Circle()
                        .fill(LinearGradient(colors: [Color(red: 1.0, green: 0.16, blue: 0.48), Color(red: 0.88, green: 0.11, blue: 0.28)], startPoint: .top, endPoint: .bottom))
                        .frame(width: 50, height: 50)
                        .overlay(Circle().stroke(Color.yellow, lineWidth: 2.5))
                        .shadow(color: Color.red.opacity(0.3), radius: 4, x: 0, y: 2)
                        .overlay(
                            Image(systemName: "shuffle")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(rotationAngle))
                        )
                }
                .buttonStyle(.plain)
            }
            .frame(width: wheelRadius * 2, height: wheelRadius * 2)
            .gesture(
                DragGesture(minimumDistance: 4)
                    .onChanged { value in
                        dragLocation = value.location
                        // Check if hitting any tile
                        for tile in tilePositions {
                            let dist = hypot(tile.center.x - value.location.x, tile.center.y - value.location.y)
                            if dist <= tileRadius * 1.3 && !selectedIndices.contains(tile.index) {
                                selectedIndices.append(tile.index)
                            }
                        }
                    }
                    .onEnded { _ in
                        if selectedIndices.count >= 2 {
                            onWordSelected(currentDraftWord)
                        }
                        selectedIndices.removeAll()
                        dragLocation = nil
                    }
            )
            
            // Bottom Action Controls
            HStack(spacing: 16) {
                // Hint Button
                Button(action: onHint) {
                    HStack(spacing: 4) {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(.orange)
                        Text("Hint (25🪙)")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.7, green: 0.35, blue: 0.05))
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                    .cornerRadius(14)
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.yellow, lineWidth: 1))
                }
                
                // Backspace
                if !selectedIndices.isEmpty {
                    Button(action: {
                        if !selectedIndices.isEmpty {
                            selectedIndices.removeLast()
                        }
                    }) {
                        Image(systemName: "delete.left.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.red)
                            .padding(8)
                            .background(Color(red: 1.0, green: 0.93, blue: 0.94))
                            .clipShape(Circle())
                    }
                }
                
                // Submit Button
                Button(action: {
                    if !currentDraftWord.isEmpty {
                        onWordSelected(currentDraftWord)
                        selectedIndices.removeAll()
                    }
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .black))
                        Text("GUESS")
                            .font(.system(size: 13, weight: .black, design: .rounded))
                    }
                    .foregroundColor(selectedIndices.isEmpty ? Color.gray : Color.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(selectedIndices.isEmpty ? Color(white: 0.92) : Color(red: 0.0, green: 0.9, blue: 0.46))
                    .cornerRadius(14)
                }
                .disabled(selectedIndices.isEmpty)
            }
        }
    }
}
