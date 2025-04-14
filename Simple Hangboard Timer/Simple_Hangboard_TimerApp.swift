//
//  Simple_Hangboard_TimerApp.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 12/4/2025.
//

import SwiftUI

@main
struct Simple_Hangboard_TimerApp: App {
    @State private var exercises = Exercise.sampleData

    var body: some Scene {
        WindowGroup {
            ExerciseListView(exercises: $exercises)
        }
    }
}
