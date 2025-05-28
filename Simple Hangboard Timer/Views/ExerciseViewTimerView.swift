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
                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                if exerciseTimer.activeExecName == "hang" {
                    Text("\(exerciseTimer.activeExecName)")
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .padding(4)
                        .font(.largeTitle)
                        .foregroundColor(theme.accentColor)
                        .background(theme.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                } else if exerciseTimer.activeExecName == "rest" {
                    Text("\(exerciseTimer.activeExecName)")
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .padding(4)
                        .font(.largeTitle)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                } else if exerciseTimer.activeExecName == "off" {
                    Text("\(exerciseTimer.activeExecName)")
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .padding(4)
                        .font(.largeTitle)
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                } else {
                    Text("\(exerciseTimer.activeExecName)")
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .padding(4)
                        .font(.largeTitle)
                        .foregroundColor(theme.accentColor)
                        .background(theme.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                }
                Text(" \(exerciseTimer.secondsRemaining) / \(exerciseTimer.currentExecDuration)")
                    .frame(maxWidth: .infinity)
                    .padding(4)
                    .font(.largeTitle)
                    .foregroundColor(theme.accentColor)
                    .background(theme.mainColor)
                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            }
            .padding(.horizontal, 20)
            Spacer()
            Text("\(exerciseTimer.totalSecondsElasped) of \(exerciseTimer.totalSecondsRemaining) where total = \(exerciseTimer.totalSeconds)")
        }
    }
}

#Preview {
let exerciseTimer = ExerciseTimer()
    ExerciseViewTimerView(exerciseTimer: exerciseTimer, theme: .constant(.bubblegum))
}
