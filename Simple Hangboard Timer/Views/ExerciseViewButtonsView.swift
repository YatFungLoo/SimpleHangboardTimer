//
//  ExerciseViewButtonsView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 28/5/2025.
//

import SwiftUI

struct ExerciseViewButtonsView: View {
    @ObservedObject var exerciseTimer: ExerciseTimer
    @State private var confirmationShown = false
    
    let startExercise: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button("Previous") {
                    exerciseTimer.previousExercise()
                }
                Button("Resume/Pause") {
                    exerciseTimer.resumePauseExercise()
                }
                Button("Skip") {
                    exerciseTimer.skipExercise()
                }
            }
            HStack {
                Button("Restart") {
                    exerciseTimer.pauseExercise()
                    confirmationShown = true
                }.confirmationDialog("This is a test", isPresented: $confirmationShown) {
                    Button("Restart", role: .destructive) {
                        exerciseTimer.reset()
                        startExercise()
                    }
                    Button("Cancel", role: .cancel) {
                        exerciseTimer.resumeExercise()
                    }
                } message: {
                    Text("This cannot ;_;")
                }
            }
        }
    }
}

//#Preview {
//    ExerciseViewButtonsView()
//}
