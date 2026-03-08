import SwiftUI

struct WorkoutDay {
    var workedOut: Bool
    var isRestDay: Bool
}

struct WeekGraph: View {
    
    @EnvironmentObject var workoutStore: WorkoutStore
    @EnvironmentObject var restStore: RestStore
    
    func generateWeekData() -> [WorkoutDay] {
        
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: Date())!.start
        
        var energy = 7
        var days: [WorkoutDay] = []
        
        for index in 0..<7 {
            
            let dayDate = calendar.date(byAdding: .day, value: index, to: startOfWeek)!
            
            let workoutExists = workoutStore.workouts.contains {
                calendar.isDate($0.date, inSameDayAs: dayDate)
            }
            
            let restExists = restStore.restDays.contains {
                calendar.isDate($0.date, inSameDayAs: dayDate)
            }
            
            if restExists {
                energy = 7
            }
            
            if workoutExists {
                energy -= 1
            }
            
            days.append(
                WorkoutDay(
                    workedOut: workoutExists,
                    isRestDay: restExists
                )
            )
        }
        
        return days
    }
    
    func remainingEnergy() -> Int {
        
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: Date())!.start
        
        let workouts = workoutStore.workouts.filter {
            $0.date >= startOfWeek
        }.count
        
        let restDays = restStore.restDays.filter {
            $0.date >= startOfWeek
        }.count
        
        if restDays > 0 {
            return 7
        }
        
        return max(7 - workouts, 0)
    }
    
    var body: some View {
        
        let weekData = generateWeekData()
        
        HStack(spacing: 10) {
            
            ForEach(0..<weekData.count, id: \.self) { index in
                
                if weekData[index].isRestDay {
                    
                    Text("😴")
                        .frame(width: 30, height: 30)
                    
                } else {
                    
                    Circle()
                        .fill(index < remainingEnergy() ?
                              Color(red: 102/255, green: 102/255, blue: 102/255) :
                              Color.gray.opacity(0.2))
                        .frame(width: 30, height: 30)
                    
                }
                
            }
        }
    }
}

extension WeekGraph {
}

//
//  WeekGraph.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-07.
//

