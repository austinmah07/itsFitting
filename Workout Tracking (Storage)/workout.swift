import Foundation

struct Workout: Identifiable, Codable {
    let id: UUID
    let activity: String
    let duration: Int
    let workoutMood: String
    let date: Date
}

//
//  workout.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-07.
//

