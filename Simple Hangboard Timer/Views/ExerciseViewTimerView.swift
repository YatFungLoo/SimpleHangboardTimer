//
//  ExerciseViewTimerView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 28/5/2025.
//

import SwiftUI

struct ExerciseViewTimerView: View {
    @ObservedObject var exerciseTimer: ExerciseTimer
    @Binding var theme: Theme

    var body: some View {
        LazyVStack {
            VStack() {
                Text("\(exerciseTimer.currentExecIndex)")
                    .frame(maxWidth: .infinity)
                    .padding(4)
                    .foregroundColor(theme.accentColor)
                    .background(theme.mainColor)
                    .cornerRadius(4)
                Text("\(exerciseTimer.activeExecName)")
                    .frame(maxWidth: .infinity)
                    .padding(4)
                    .font(.largeTitle)
                    .foregroundColor(theme.accentColor)
                    .background(theme.mainColor)
                    .cornerRadius(4)
                Text(" \(exerciseTimer.secondsRemaining) / \(exerciseTimer.currentExecDuration)")
                    .frame(maxWidth: .infinity)
                    .padding(4)
                    .font(.largeTitle)
                    .foregroundColor(theme.accentColor)
                    .background(theme.mainColor)
                    .cornerRadius(4)
            }
            Spacer()
            Text("\(exerciseTimer.totalSecondsElasped) of \(exerciseTimer.totalSecondsRemaining) where total = \(exerciseTimer.totalSeconds)")
        }
    }
}

#Preview {
let exerciseTimer = ExerciseTimer()
    ExerciseViewTimerView(exerciseTimer: exerciseTimer, theme: .constant(.bubblegum))
}
