//
//  ExerciseViewReadyView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 29/5/2025.
//

import SwiftUI

struct ExerciseViewReadyView: View {
    @ObservedObject var exerciseTimer: ExerciseTimer
    
    var body: some View {
        Text("Ready")
            .frame(maxWidth: .infinity)
            .padding(4)
            .font(.largeTitle)
            .background(.gray)
            .cornerRadius(4)
        Text("\(exerciseTimer.secondsRemaining)")
            .frame(maxWidth: .infinity)
            .padding(4)
            .font(.largeTitle)
            .background(.gray)
            .cornerRadius(4)
    }
}

#Preview {
    let exerciseTimer = ExerciseTimer()
    ExerciseViewReadyView(exerciseTimer: exerciseTimer)
}
