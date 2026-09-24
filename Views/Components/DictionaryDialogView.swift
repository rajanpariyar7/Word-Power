import SwiftUI

public struct DictionaryDialogView: View {
    public let entry: DictionaryEntry
    public let onDismiss: () -> Void

    public var body: some View {
        ZStack {
            Color.black.opacity(0.65)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }

            VStack(alignment: .leading, spacing: 14) {
                // Header Bar with Word & Close button
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.word)
                            .font(.system(size: 26, weight: .black))
                            .foregroundColor(AppTheme.goldAccent)

                        if let phonetic = entry.phonetic, !phonetic.isEmpty {
                            Text(phonetic)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }

                    Spacer()

                    Button(action: onDismiss) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 26))
                            .foregroundColor(.white.opacity(0.6))
                    }
                }

                // Part of speech badge
                Text(entry.partOfSpeech.uppercased())
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(AppTheme.vibrantPrimary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(AppTheme.vibrantPrimaryContainer.opacity(0.5))
                    .clipShape(Capsule())

                Divider()
                    .background(Color.white.opacity(0.15))

                // Definition
                VStack(alignment: .leading, spacing: 4) {
                    Text("Definition")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white.opacity(0.6))

                    Text(entry.definition)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                        .lineSpacing(3)
                }

                // Example Sentence
                if let example = entry.example, !example.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Example")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white.opacity(0.6))

                        Text("\"\(example)\"")
                            .font(.system(size: 14, weight: .medium))
                            .italic()
                            .foregroundColor(AppTheme.goldLight)
                            .padding(10)
                            .background(Color.white.opacity(0.06))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }

                // Dismiss Button
                Button(action: onDismiss) {
                    Text("GOT IT")
                        .font(.system(size: 14, weight: .black))
                        .foregroundColor(Color(0xFF331A00))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(AppTheme.goldAccent)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top, 6)
            }
            .padding(22)
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
                    .stroke(AppTheme.goldAccent.opacity(0.6), lineWidth: 1.5)
            )
            .padding(24)
        }
    }
}
