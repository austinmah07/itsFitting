import SwiftUI

struct MoodButton: View {

    var emoji: String
    var label: String
    @Binding var selectedMood: String

    var body: some View {

        Button {
            selectedMood = label
        } label: {

            HStack(spacing: 16) {

                // Emoji bubble
                Text(emoji)
                    .font(.title)
                    .frame(width: 55, height: 50)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                // Black label pill
                Text(label)
                    .font(.headline)
                    .frame(width: 75)
                    .padding(8)
                    .background(
                        selectedMood == label
                        ? Color(red: 75/255, green: 126/255, blue: 121/255) // selected color
                        : Color.black
                    )
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .buttonStyle(.plain) // prevents default blue tap style
    }
}

//
//  MoodButton.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-06.
//

