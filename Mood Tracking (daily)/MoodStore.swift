import SwiftUI
import Combine

class MoodStore: ObservableObject {

    @Published var moods: [DailyMood] = [] {
        didSet {
            saveMoods()
        }
    }

    init() {
        loadMoods()
    }

    // Add or replace today's mood
    func addMood(_ mood: String) {

        let calendar = Calendar.current
        let today = Date()

        if let index = moods.firstIndex(where: {
            calendar.isDate($0.date, inSameDayAs: today)
        }) {

            // Replace today's mood completely
            moods[index] = DailyMood(
                id: moods[index].id,
                mood: mood,
                date: today
            )

        } else {

            let newMood = DailyMood(
                id: UUID(),
                mood: mood,
                date: today
            )

            moods.append(newMood)
        }
    }

    // Save to device storage
    private func saveMoods() {

        if let encoded = try? JSONEncoder().encode(moods) {
            UserDefaults.standard.set(encoded, forKey: "savedMoods")
        }

    }

    // Load when app starts
    private func loadMoods() {

        if let data = UserDefaults.standard.data(forKey: "savedMoods"),
           let decoded = try? JSONDecoder().decode([DailyMood].self, from: data) {

            moods = decoded
        }

    }

}

//
//  MoodStore.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-07.
//

