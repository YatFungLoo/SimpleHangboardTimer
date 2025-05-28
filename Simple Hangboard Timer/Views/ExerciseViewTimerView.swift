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
            HStack () {
                Spacer()
                Text("\(exerciseTimer.currentExecIndex)")
                    .padding(4)
                    .foregroundColor(theme.accentColor)
                    .background(theme.mainColor)
                    .cornerRadius(4)
                Text("\(exerciseTimer.activeExecName)")
                    .padding(4)
                    .foregroundColor(theme.accentColor)
                    .background(theme.mainColor)
                    .cornerRadius(4)
                Text(" \(exerciseTimer.secondsRemaining) / \(exerciseTimer.currentExecDuration)")
                    .padding(4)
                    .foregroundColor(theme.accentColor)
                    .background(theme.mainColor)
                    .cornerRadius(4)
                Spacer()
            }
            Spacer()
            Text("\(exerciseTimer.totalSecondsElasped) of \(exerciseTimer.totalSecondsRemaining) where total = \(exerciseTimer.totalSeconds)")
        }
    }
}

//#Preview {
//    ExerciseViewTimerView()
//}
