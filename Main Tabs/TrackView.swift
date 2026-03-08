import SwiftUI



struct TrackView: View {
    
    //Buttons
    @State private var showActivities = false
    @State private var hours = 0
    @State private var minutes = 30
    
    //Data for workout
    @State private var selectedActivity = "None"
    @State private var workoutMood: String = ""
    
    //Save variable
    @EnvironmentObject var workoutStore: WorkoutStore
    @State private var workoutHours: Int = 0
    @State private var workoutMinutes: Int = 0
    
    
    struct PressableButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .opacity(configuration.isPressed ? 0.7 : 1)
                .scaleEffect(configuration.isPressed ? 0.97 : 1)
                .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Color(red: 197/255, green: 219/255, blue: 217/255)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Banner
                Text("Tracking your workout")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(red: 75/255, green: 126/255, blue: 121/255))
                    .foregroundColor(.white)
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                       (Text("Activity Completed: ") +
                        Text(selectedActivity).fontWeight(.bold))
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .padding(6)
                            .frame(width: 195)
                            .foregroundColor(Color(red: 55/255, green: 105/255, blue: 100/255))
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(red: 75/255, green: 126/255, blue: 121/255), lineWidth: 2)
                            )
                            .padding(.top, 20)
                        
                        // Button
                        ZStack {
                            
                            // MAIN UI
                            VStack {
                                Button {
                                    withAnimation(.spring()) {
                                        showActivities = true
                                    }
                                } label: {
                                    Text("Select Activity")
                                        .padding(8)
                                        .font(.headline)
                                        .frame(width: 140)
                                        .background(.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                                .buttonStyle(PressableButtonStyle())
                            }
                            
                            // SELECTOR + OVERLAY
                            if showActivities {
                                
                                // tap outside to dismiss
                                Color.black.opacity(0.001)
                                    .ignoresSafeArea()
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            showActivities = false
                                        }
                                    }
                                
                                VStack {
                                    Spacer()
                                    
                                    ActivitySelectionView(
                                        selectedActivity: $selectedActivity,
                                        showActivities: $showActivities
                                    )
                                    .frame(height: 300)
                                    .background(.white)
                                    .cornerRadius(20)
                                    .transition(.move(edge: .bottom))
                                    
                                }
                                .ignoresSafeArea()
                            }
                            
                        }
                        
                        Text("How long did you workout for?")
                            .font(.headline)
                            .padding(6)
                            .frame(width: 300)
                            .foregroundColor(.black)
                        
                        //time selector
                        HStack {
                            
                            Picker("Hours", selection: $workoutHours) {
                                ForEach(0...2, id: \.self) { hour in
                                    Text("\(hour) hr")
                                }
                            }
                            
                            Picker("Minutes", selection: $workoutMinutes) {
                                ForEach(0...59, id: \.self) { minute in
                                    Text("\(minute) min")
                                }
                            }
                            
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 120)
                        
                        Text("How did the workout make you feel?")
                            .font(.headline)
                        
                        MoodButton(emoji: "🤩", label: "Great", selectedMood: $workoutMood)
                        MoodButton(emoji: "🙂", label: "Alright", selectedMood: $workoutMood)
                        MoodButton(emoji: "😕", label: "Meh", selectedMood: $workoutMood)
                        MoodButton(emoji: "🫠", label: "Drained", selectedMood: $workoutMood)
                        
                        Text("Great job on showing up today for yourself. You did this for yourself, and that's something to be proud of!")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding()
                        
                    }
                    
                    Button {
                        
                        //Calculating total minutes
                        let totalMinutes = workoutMinutes + workoutHours * 60
                        
                        workoutStore.addWorkout(
                            activity: selectedActivity,
                            duration: totalMinutes,
                            mood: workoutMood
                        )
                        
                        // Reset everything
                            selectedActivity = "None"
                            workoutHours = 0
                            workoutMinutes = 0
                            workoutMood = ""

                    } label: {
                        
                        Text("Save Workout")
                            .padding(8)
                            .frame(maxWidth: 200)
                            .background(Color(red: 75/255, green: 126/255, blue: 121/255))
                            .foregroundColor(.white)
                            .cornerRadius(16)

                    }
                    .padding()
                    
                }
                
            }
        }
    }
}

//
//  TrackView.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-06.
//

