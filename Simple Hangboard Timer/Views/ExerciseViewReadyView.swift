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
        VStack {
            Text("Ready")
                .frame(maxWidth: .infinity, minHeight: 100)
                .padding(4)
                .font(.largeTitle)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            Text("\(exerciseTimer.secondsRemaining)")
                .frame(maxWidth: .infinity)
                .padding(4)
                .font(.largeTitle)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    let exerciseTimer = ExerciseTimer()
    ExerciseViewReadyView(exerciseTimer: exerciseTimer)
}
