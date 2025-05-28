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
    
    func resumePause() -> String {
        return exerciseTimer.timerStopped ? "Resume" : "Pause"
    }

    var body: some View {
        HStack {
            Button("Previous") {
                exerciseTimer.previousExercise()
            }
            .buttonStyle(.controlButton)
            Spacer()
            Button(resumePause()) {
                exerciseTimer.resumePauseExercise()
            }
            .buttonStyle(.controlButton)
            Spacer()
            Button("Skip") {
                exerciseTimer.skipExercise()
            }
            .buttonStyle(.controlButton)
        }
        .padding(.horizontal, 20)
        Button("Restart") {
            exerciseTimer.pauseExercise()
            confirmationShown = true
        }
        .confirmationDialog("This is a test", isPresented: $confirmationShown) {
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

#Preview {
    let exerciseTimer = ExerciseTimer()
    ExerciseViewButtonsView(exerciseTimer: exerciseTimer, startExercise: {})
}
