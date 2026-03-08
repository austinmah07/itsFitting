import SwiftUI

struct ActivitySelectionView: View {

    @Binding var selectedActivity: String
    @Binding var showActivities: Bool

    let activities = [
        "Running",
        "Walking",
        "Cycling",
        "Strength Training",
        "Yoga",
        "Other"
    ]

    var body: some View {

        ScrollView {
            VStack(spacing: 16) {
                
                ForEach(activities, id: \.self) { activity in
                    Button {
                        selectedActivity = activity
                        
                        withAnimation(.spring()) {
                            showActivities = false
                        }
                        
                    } label: {
                        Text(activity)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(14)
                            .foregroundColor(.gray)
                    }
                    
                }
                
            }
            .padding()
        }
        .padding()
    }
}

//
//  ActivitySelectionView.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-07.
//

