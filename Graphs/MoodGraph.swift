import SwiftUI

struct MoodGraph: View {

    @EnvironmentObject var moodStore: MoodStore

    var body: some View {

        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: Date())!.start
        let days = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]

        VStack(spacing: 12) {

            Text("Your Weekly Mood")
                .font(.headline)

            Divider()

            // Day labels
            HStack {

                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }

            }

            // Mood row
            HStack {

                ForEach(0..<7) { index in

                    let dayDate = calendar.date(byAdding: .day, value: index, to: startOfWeek)!

                    let mood = moodStore.moods.first {
                        calendar.isDate($0.date, inSameDayAs: dayDate)
                    }

                    Text(mood?.mood ?? "-")
                        .font(.title3)
                        .frame(maxWidth: .infinity)

                }

            }

        }
        .padding()
        .background(.white)
        .cornerRadius(16)
        .shadow(radius: 3)

    }

}

//
//  MoodGraph.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-07.
//

