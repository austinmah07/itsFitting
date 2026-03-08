import SwiftUI

struct CardView: View {
    
    var text: String
    
    var body: some View {
        
        Text(text)
            .font(.headline)
            .padding()
            .frame(width: 280)
            .background(Color(red: 120/255, green: 176/255, blue: 177/255))
            .foregroundColor(.white)
            .cornerRadius(16)
    }
}



//
//  CardView.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-06.
//
