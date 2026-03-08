import SwiftUI
import Combine

class WorkoutStore: ObservableObject {
    

    @Published var workouts: [Workout] = [] {
        didSet {
            saveWorkouts()
        }
    }

    init() {
        loadWorkouts()
    }

    func addWorkout(activity: String, duration: Int, mood: String) {
        let newWorkout = Workout(
            id: UUID(),
            activity: activity,
            duration: duration,
            workoutMood: mood,
            date: Date()
        )

        workouts.append(newWorkout)
    }
    
    func deleteWorkout(_ workout: Workout) {
        workouts.removeAll { $0.id == workout.id }
    }

    private func saveWorkouts() {
        if let encoded = try? JSONEncoder().encode(workouts) {
            UserDefaults.standard.set(encoded, forKey: "savedWorkouts")
        }
    }

    private func loadWorkouts() {
        if let data = UserDefaults.standard.data(forKey: "savedWorkouts"),
           let decoded = try? JSONDecoder().decode([Workout].self, from: data) {
            workouts = decoded
        }
    }
}

//
//  WorkoutStore.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-07.
//

