//
//  ExerciseCardView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 12/4/2025.
//

import SwiftUI

struct ExerciseCardView: View {
    let exercise: Exercise
    var body: some View {
        VStack() {
            Text("ExerciseCardView")
        }
        .foregroundStyle(exercise.theme.mainColor)
    }
}

struct ExerciseCardView_Preview: PreviewProvider {
    static var exercise = Exercise.sampleData[0]
    static var previews: some View {
        ExerciseCardView(exercise: exercise)
            .background(exercise.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
