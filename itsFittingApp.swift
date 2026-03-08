//
//  itsFittingApp.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-06.
//

import SwiftUI

@main
struct itsFittingApp: App {

    @StateObject var workoutStore = WorkoutStore()
    @StateObject var moodStore = MoodStore()
    @StateObject var restStore = RestStore()

        var body: some Scene {

            WindowGroup {
                ContentView()
                    .environmentObject(workoutStore)
                    .environmentObject(moodStore)
                    .environmentObject(restStore)
            }

        }

    }

