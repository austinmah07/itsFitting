import SwiftUI

struct OnboardingFlowView: View {
    
    @State private var step = 0
    
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    @AppStorage("userName") var userName = ""
    @AppStorage("userAge") var userAge = 18
    @AppStorage("userSex") var userSex = ""
    @AppStorage("workoutGoal") var workoutGoal = ""
    @AppStorage("edHistory") var edHistory = false
    @AppStorage("userWeight") var userWeight = ""
    @AppStorage("preferredWorkoutTime") var preferredWorkoutTime = 30
    
    var progressIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<7) { index in
                Capsule()
                    .fill(index <= step ? Color.black : Color.gray.opacity(0.3))
                    .frame(height: 6)
                    .animation(.easeInOut, value: step)
            }
        }
    }

    var body: some View {
        
        VStack {
            
            progressIndicator
            
            // Back button
            if step > 0 {
                HStack {
                    Button("Back") {
                        withAnimation {
                            step -= 1
                        }
                    }
                    .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            if step == 0 { welcome }
            if step == 1 { nameAgeQuestion }
            if step == 2 { sexQuestion }
            if step == 3 { workoutGoalQuestion }
            if step == 4 { edQuestion }
            if step == 5 { weightQuestion }
            if step == 6 { workoutTimeQuestion }
            
            Spacer()
        }
        .padding()
        .animation(.easeInOut, value: step)
    }
}

extension OnboardingFlowView {

    
    var welcome: some View {
        VStack(spacing: 30) {
            
            Text("Welcome to itsFitting.")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Fitness focused on wellbeing, not pressure.")
                .multilineTextAlignment(.center)
                .padding()
            
            Button {
                withAnimation {
                    step = 1
                }
            } label: {
                Text("Start")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
        }
    }
    
    var nameAgeQuestion: some View {
        
        VStack(spacing: 30) {
            
            Text("Tell us about yourself")
                .font(.title2)
            
            TextField("Your name", text: $userName)
                .textFieldStyle(.roundedBorder)
            
            Stepper("Age: \(userAge)", value: $userAge, in: 5...100)
            
            if userAge < 13 {
                Text("This app is designed for teens and adults. Please come back when you're older.")
                    .font(.footnote)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            
            Button("Next") {
                withAnimation {
                    step = 2
                }
            }
            .disabled(userAge < 13)   // Prevents continuing if you are under 13. People under 13 should not have to worry about losing weight and gain a toxic mindset.
            
        }
    }
    
    var sexQuestion: some View {
        VStack(spacing: 30) {
            
            Text("What is your sex?")
                .font(.title2)
            
            Picker("Sex", selection: $userSex) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
                Text("Other").tag("Other")
                Text("Prefer not to say").tag("None")
            }
            .pickerStyle(.wheel)
            
            Button("Next") {
                withAnimation {
                    step = 3
                }
            }
        }
    }
    
    var workoutGoalQuestion: some View {
        VStack(spacing: 30) {
            
            Text("How often do you want to work out?")
                .font(.title2)
            
            Picker("Goal", selection: $workoutGoal) {
                Text("Light").tag("Light")
                Text("Moderate").tag("Moderate")
                Text("High").tag("High")
            }
            .pickerStyle(.segmented)
            
            Button("Next") {
                withAnimation {
                    step = 4
                }
            }
        }
    }
    
    var edQuestion: some View {
        VStack(spacing: 30) {
            
            Text("Health considerations")
                .font(.title2)
            
            Toggle("History of eating disorder?", isOn: $edHistory)
            
            Button("Next") {
                withAnimation {
                    
                    if edHistory {
                        step = 6
                    } else {
                        step = 5
                    }
                }
            }
            
            Text("This information helps us provide appropriate support. Your response is optional and will be kept confidential.")
                .font(.caption)
                .multilineTextAlignment(.center)
        }
    }
    
    var weightQuestion: some View {
        VStack(spacing: 30) {
            
            Text("Weight (optional)")
                .font(.title2)
            
            TextField("Enter weight", text: $userWeight)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            
            Button("Next") {
                withAnimation {
                    step = 6
                }
            }
        }
    }
    
    var workoutTimeQuestion: some View {
        VStack(spacing: 30) {
            
            Text("Preferred workout duration")
                .font(.title2)
            
            Stepper("\(preferredWorkoutTime) minutes",
                    value: $preferredWorkoutTime,
                    in: 10...120)
            
            if edHistory {
                Text("Consistency matters more than long workouts. Don't overwork yourself! <3")
                    .font(.footnote)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)
            }
            
            Button("Start App") {
                hasCompletedOnboarding = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.black)
            .foregroundColor(.white)
            .cornerRadius(16)
        }
    }
}


#Preview {
    OnboardingFlowView()
}

//
//  OnboardingFlowView.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-07.
//

