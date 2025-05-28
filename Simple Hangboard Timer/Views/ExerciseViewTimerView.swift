//
//  ExerciseViewTimerView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 28/5/2025.
//

import SwiftUI

struct ExerciseViewTimerView: View {
    @ObservedObject var exerciseTimer: ExerciseTimer
    
    var body: some View {
        Text("\(exerciseTimer.currentExecIndex) -> \(exerciseTimer.activeExecName): \(exerciseTimer.secondsRemaining) / \(exerciseTimer.currentExecDuration)")
        Text("\(exerciseTimer.totalSecondsElasped) of \(exerciseTimer.totalSecondsRemaining) where total = \(exerciseTimer.totalSeconds)")
    }
}

//#Preview {
//    ExerciseViewTimerView()
//}
