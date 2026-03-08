import SwiftUI
import Combine

struct RestDay: Identifiable, Codable {
    let id: UUID
    let date: Date
}

class RestStore: ObservableObject {

    @Published var restDays: [RestDay] = [] {
        didSet { save() }
    }

    init() {
        load()
    }

    func addRestDay() {

        let today = Calendar.current.startOfDay(for: Date())

        if !restDays.contains(where: {
            Calendar.current.isDate($0.date, inSameDayAs: today)
        }) {

            restDays.append(RestDay(id: UUID(), date: today))

        }

    }

    func hasRestToday() -> Bool {

        let today = Calendar.current.startOfDay(for: Date())

        return restDays.contains {
            Calendar.current.isDate($0.date, inSameDayAs: today)
        }

    }
    
    func toggleRestDay() {

        let today = Calendar.current.startOfDay(for: Date())

        if let index = restDays.firstIndex(where: {
            Calendar.current.isDate($0.date, inSameDayAs: today)
        }) {

            restDays.remove(at: index)

        } else {

            restDays.append(RestDay(id: UUID(), date: today))

        }

    }

    private func save() {

        if let encoded = try? JSONEncoder().encode(restDays) {
            UserDefaults.standard.set(encoded, forKey: "savedRestDays")
        }

    }

    private func load() {

        if let data = UserDefaults.standard.data(forKey: "savedRestDays"),
           let decoded = try? JSONDecoder().decode([RestDay].self, from: data) {
            restDays = decoded
        }

    }

}

//
//  RestStore.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-07.
//

