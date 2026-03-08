import SwiftUI


struct HomeView: View {
    
    @State private var quoteText = "Loading quote..."
    @State private var quoteAuthor = ""
    @State private var overallMood: String = ""
    @EnvironmentObject var moodStore: MoodStore
    @EnvironmentObject var restStore: RestStore
    @EnvironmentObject var workoutStore: WorkoutStore
    @State private var showRunGuide = false
    @State private var showMeditatePlaylist = false
    
    func consecutiveWorkoutDays() -> Int {
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let workoutDays = workoutStore.workouts
            .map { calendar.startOfDay(for: $0.date) }
            .sorted(by: >)
        
        var streak = 0
        
        for i in 0..<7 {
            
            let checkDate = calendar.date(byAdding: .day, value: -i, to: today)!
            
            if workoutDays.contains(where: { calendar.isDate($0, inSameDayAs: checkDate) }) {
                streak += 1
            } else {
                break
            }
        }
        
        return streak
    }
    
    var body: some View {
        
        
        
        ZStack {
            
            Color(red: 197/255, green: 219/255, blue: 217/255)
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack(spacing: 8) {
                    
                    Text("")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    
                    //Title of Home Page
                    
                    Text("Welcome to \(Text("itsFitting.").bold())")
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                    // Recommendation Card
                    
                    Text(
                        restStore.hasRestToday() || consecutiveWorkoutDays() >= 4
                        ? "You should rest today.\nRest is important to keep up the hard work!"
                        : "You can work out today, if you're in the mood!"
                    )
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 75/255, green: 126/255, blue: 121/255))
                    .foregroundColor(.white)
                    
                    //Weekly graph for breaks in workout
                    
                    VStack(spacing: 20) {

                        Text("Your Weekly Balance")
                            .font(.headline)

                        WeekGraph()

                    }
                    
                    //Rest day button that indiciates a rest day
                    Button {

                        restStore.toggleRestDay()

                    } label: {
                        
                        Text(restStore.hasRestToday() ? "Remove Rest Day" : "Take a Rest Day")
                            .padding(10)
                            .frame(width: 150)
                            .background(
                                restStore.hasRestToday()
                                ? Color.red
                                : Color(red: 241/255, green: 235/255, blue: 227/255)
                            )
                            .foregroundColor(.black)
                            .cornerRadius(16)

                    }
                    
                    //Daily Quotes
                    
                    VStack {

                        Text(quoteText)
                            .font(.caption)
                            .bold(false)
                            .multilineTextAlignment(.center)

                        Text("- \(quoteAuthor)")
                            .font(.caption)
                            .fontWeight(.bold)
                        }
                    .onAppear {
                        QuoteService().fetchQuote { quote in
                            DispatchQueue.main.async {
                                quoteText = quote?.q ?? "Stay balanced."
                                quoteAuthor = quote?.a ?? ""
                            }
                        }
                    }
                    .padding()
                    
                    //Weekly Graph Moods
                    
                    VStack(spacing: 20) {

                        MoodGraph()

                    }
                    .padding()
                    
                    
                    //Suggestions for user to complete
                    
                    VStack (spacing: 20) {
                        
                        if consecutiveWorkoutDays() >= 4 {

                            CardView(text: "Guided Meditation")
                                .onTapGesture {
                                    showMeditatePlaylist = true
                                }
                                .sheet(isPresented: $showMeditatePlaylist) {
                                    YouTubeView(playlistID: "PL8dPuuaLjXtOAKed_MxxWBNaqt1QYyUQ6")
                                }
                            
                            CardView(text: "Guided walk")
                                .onTapGesture {
                                    withAnimation {
                                        showRunGuide.toggle()
                                    }
                                }
                            if showRunGuide {
                                
                                Text("""
                            Quick 4-step walking meditation routine (3-5 mins)
                            
                            1. Start and breathe (30 secs)
                            
                            2. Walk Slowly and Notice the feeling of the ground and feel your breathing (1–2 mins)
                            
                            3. Say what you see around you, listen to the environment , acknowledge the feeling of air on your skin (1–2 mins)
                            
                            4. Take a deep breath and notice how your body and mind feel. (30 secs)

                            """)
                                .font(.footnote)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .transition(.opacity)
                            }

                        } else {

                            CardView(text: "Do Push Day at the gym")
                                .onTapGesture {
                                    withAnimation {
                                        showRunGuide.toggle()
                                    }
                                }
                            if showRunGuide {
                                
                                Text("""
                            1. Start with a 5 minute warm up.
                            Light treadmill walk or cycling.
                            Do 10–15 pushups to activate your chest and shoulders.

                            2. Bench Press – 3 sets
                            8–10 reps per set.
                            Focus on controlled movement and steady breathing.

                            3. Dumbbell Shoulder Press – 3 sets
                            8–10 reps.
                            Keep your core tight and press straight upward.

                            4. Incline Dumbbell Press – 3 sets
                            8–10 reps.
                            Targets the upper chest and shoulders.

                            5. Tricep Pushdowns – 3 sets
                            10–12 reps.
                            Fully extend your arms and control the return.

                            6. Cool down for 3 minutes.
                            Stretch your chest and shoulders.
                            Take slow breaths and let your heart rate drop.

                            """)
                                .font(.footnote)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .transition(.opacity)
                            }
                            
                            CardView(text: "Short Speed Run")
                                .onTapGesture {
                                    withAnimation {
                                        showRunGuide.toggle()
                                    }
                                }
                            if showRunGuide {
                                
                                Text("""
                            1. Start with a 5 minute warm up.
                            Begin with a light jog or fast walk.
                            Focus on loosening your legs and steady breathing.

                            2. First sprint interval.
                            Run fast for 30 seconds.
                            Push yourself, but keep control of your form.

                            3. Recovery jog.
                            Jog slowly for 60 seconds to catch your breath.

                            4. Repeat the interval.
                            Sprint for another 30 seconds.
                            Follow with a 60 second slow jog.

                            5. Complete 4–6 total sprint intervals.
                            Maintain strong posture and controlled breathing.

                            6. Cool down for 3–5 minutes.
                            Walk slowly and stretch your calves, hamstrings, and quads.
                            Let your heart rate gradually return to normal.

                            """)
                                .font(.footnote)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .transition(.opacity)
                            }

                        }
                        
                        
                        Text("How are you feeling today?")
                            .font(.headline)
                        
                        MoodButton2(label: "⭐️⭐️⭐️⭐️", selectedMood: $overallMood)
                        MoodButton2(label: "⭐️⭐️⭐️", selectedMood: $overallMood )
                        MoodButton2(label: "⭐️⭐️", selectedMood: $overallMood)
                        MoodButton2(label: "⭐️",selectedMood: $overallMood)
                        
                        
                        Button {

                            guard !overallMood.isEmpty else { return }

                            moodStore.addMood(overallMood)
                            overallMood = ""

                        } label: {

                            Text("Save Mood")
                                .padding(8)
                                .frame(width: 160)
                                .background(Color(red: 75/255, green: 126/255, blue: 121/255))
                                .foregroundColor(.white)
                                .cornerRadius(16)

                        }
                        
                        //Adaptive motivational message dependent on consequtive workout days
                        Text(
                            restStore.hasRestToday() || consecutiveWorkoutDays() >= 4
                            ? "You should rest today.\nRest is important to keep up the hard work!"
                            : "Getting out could better your moods! Try a run or a walk today."
                        )
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 75/255, green: 126/255, blue: 121/255))
                        .foregroundColor(.white)
                        
                    }
                }
                
                
                .background(Color(red: 197/255, green: 219/255, blue: 217/255))
                
            }
        }
    }
}
