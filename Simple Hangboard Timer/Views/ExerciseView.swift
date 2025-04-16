//
//  ExerciseView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 15/4/2025.
//

import SwiftUI

struct ExerciseView: View {
    @Binding var exercise: Exercise
    @State var tasks: [Exec]
    @StateObject var exerciseTimer = ExerciseTimer()
    
    func startExercise () {
        ExerciseTimer().startExercise()
    }
    
    private var progress: Double {
        guard exercise.totalDurationInSec() > 0 else { return 1 }  // Base case check.
        return Double(exerciseTimer.secondsElasped) / Double(exercise.totalDurationInSec())
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
            ProgressView()
            Spacer()
            Text("\(exerciseTimer.secondsElasped)")
            Spacer()
            Text("Hello, World!")
        }
        .onAppear {
            startExercise()
        }
    }
}

struct ExerciseView_Preview: PreviewProvider {
    static var previews: some View {
        ExerciseView(exercise: .constant(Exercise.sampleData[2]), tasks: Exercise.sampleData[2].tasksCompilation())
    }
}
