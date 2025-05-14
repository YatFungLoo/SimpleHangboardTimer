//
//  ExerciseView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 15/4/2025.
//

import SwiftUI

struct ExerciseView: View {
    @Binding var exercise: Exercise
    @State private var confirmationShown = false
    
    @StateObject var exerciseTimer = ExerciseTimer()
    
    func startExercise () {
        let compilation: [UniqueExec] = exercise.tasksCompilation()
        exerciseTimer.setup(execs: compilation)
        exerciseTimer.readyExercise()
    }
    
    private var progress: Double {
        guard exercise.totalDurationInSec() > 0 else { return 1 }  // Base case check.
        return Double(exerciseTimer.totalSecondsElasped) / Double(exercise.totalDurationInSec())
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(DefaultProgressViewStyle())
                .tint(exercise.theme.mainColor)
            Spacer()
            Text("\(exerciseTimer.currentExecIndex) -> \(exerciseTimer.activeExecName): \(exerciseTimer.secondsRemaining) / \(exerciseTimer.currentExecDuration)")
            Text("\(exerciseTimer.totalSecondsElasped) of \(exerciseTimer.totalSecondsRemaining) where total = \(exerciseTimer.totalSeconds)")
            Spacer()
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
        .onAppear {
            startExercise()
        }
    }
}

struct ExerciseView_Preview: PreviewProvider {
    static var previews: some View {
        ExerciseView(exercise: .constant(Exercise.sampleData[0]))
    }
}
