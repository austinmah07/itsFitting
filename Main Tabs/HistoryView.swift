import SwiftUI

struct HistoryView: View {

    @EnvironmentObject var workoutStore: WorkoutStore
    @EnvironmentObject var moodStore: MoodStore

    var body: some View {

        List {
            //Activities Completed Title Space
            Section(header: Text("Activities Completed 🏅")) {

                ForEach(workoutStore.workouts) { workout in
                    
                    //Cards were created using the training storage
                    HStack {

                        Text("\(workout.activity) | \(workout.duration) Min")

                        Spacer()

                        Text("\(workout.workoutMood) |")
                        
                        //If there is no mood stored from the homepage, it is ignored.
                        if let mood = moodStore.moods.last {
                            Text(mood.mood)
                        } else {
                            Text("No Daily Mood")
                                .font(.caption2)
                        }

                    }
                    .padding()
                    .background(
                        Color(red: 75/255, green: 126/255, blue: 121/255)
                    )
                    .cornerRadius(16)
                    .foregroundColor(.white)

                    .swipeActions(allowsFullSwipe: true) {

                        Button(role: .destructive) {

                            withAnimation {
                                workoutStore.deleteWorkout(workout)
                            }

                        } label: {
                            Label("Delete", systemImage: "trash")
                        }

                    }

                }

            }

        }
        .listStyle(.plain)

    }

}
        
            

//
//  HistoryView.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-06.
//

