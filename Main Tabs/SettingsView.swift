import SwiftUI

struct SettingsView: View {
    
    @AppStorage("userSex") var userSex = ""
    @AppStorage("workoutGoal") var workoutGoal = ""
    @AppStorage("edHistory") var edHistory = false
    @AppStorage("userWeight") var userWeight = ""
    @AppStorage("preferredWorkoutTime") var preferredWorkoutTime = 30
    @AppStorage("userName") var userName = ""
    @AppStorage("userAge") var userAge = 18
    
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = true
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                // Profile
                Section(header: Text("Profile")) {
                    
                    TextField("Name", text: $userName)
                    
                    Stepper("Age: \(userAge)", value: $userAge, in: 13...100)

                    Picker("Sex", selection: $userSex) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                        Text("Other").tag("Other")
                        Text("Prefer not to say").tag("None")
                    }
                    
                    Toggle("History of eating disorder", isOn: $edHistory)
                    
                    if !edHistory {
                        TextField("Weight in lbs (optional)", text: $userWeight)
                            .keyboardType(.decimalPad)
                    }
                }
                
                // Fitness preferences
                Section(header: Text("Workout Preferences")) {
                    
                    Picker("Workout Intensity", selection: $workoutGoal) {
                        Text("Light").tag("Light")
                        Text("Moderate").tag("Moderate")
                        Text("High").tag("High")
                    }
                    
                    Stepper(
                        "\(preferredWorkoutTime) minutes",
                        value: $preferredWorkoutTime,
                        in: 10...120
                    )
                }
                
                // Reset onboarding
                Section {
                    
                    Button("Redo Onboarding") {
                        hasCompletedOnboarding = false
                    }
                    .foregroundColor(.blue)
                    
                }
                
                // App info
                Section(header: Text("About")) {
                    
                    Text("itsFitting | 2026")
                        .font(.headline)
                    
                    Text("Fitness focused on wellbeing.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                   
                    Text("Austin Mah and Lara Vercella ©")
                    .font(.footnote)
                    .foregroundColor(.red)
                
            }
            .navigationTitle("Settings")
        }
    }
}

//
//  SettingsView.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-06.
//

