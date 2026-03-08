import SwiftUI

struct MoodButton2: View {
    var label: String
    @Binding var selectedMood: String

    var body: some View {

        Button {
            selectedMood = label
        } label: {

            HStack(spacing: 16) {

                // Black label pill
                Text(label)
                    .font(.headline)
                    .frame(width: 100)
                    .padding(8)
                    .background(
                        selectedMood == label
                        ? Color.black // selected color
                        : Color.white
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

