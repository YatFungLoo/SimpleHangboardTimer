//
//  ExerciseView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 15/4/2025.
//

import SwiftUI

struct ExerciseView: View {
    @Binding var exercise: Exercise
    @StateObject var exerciseTimer = ExerciseTimer()
    
    func startExercise() {
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
            ExerciseViewTimerView(exerciseTimer: exerciseTimer)
            Spacer()
            ExerciseViewButtonsView(exerciseTimer: exerciseTimer, startExercise: startExercise)
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
