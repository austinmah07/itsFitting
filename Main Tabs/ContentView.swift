//
//  ContentView.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-06.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    
    var body: some View {
        
        if hasCompletedOnboarding {
            
            TabView {
                
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                TrackView()
                    .tabItem {
                        Image(systemName: "figure.walk")
                        Text("Track")
                    }
                
                HistoryView()
                    .tabItem {
                        Image(systemName: "clock.fill")
                        Text("History")
                    }
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
            }
            
        } else {
            
            OnboardingFlowView()
            
        }
    }
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}
