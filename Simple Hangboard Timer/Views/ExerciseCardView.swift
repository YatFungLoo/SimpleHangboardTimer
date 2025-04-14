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
        VStack(alignment: .center) {
            Text(exercise.title)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(exercise.intervals[0].hang)-\(exercise.intervals[0].rest) \u{00D7} \(exercise.intervals[0].repeats) /  \(exercise.secOrMin(lengthInSeconds: exercise.intervals[0].off)) rest", systemImage: "carrot")
                Spacer()
                Label("\(exercise.sets) sets", systemImage: "arrow.clockwise")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundStyle(exercise.theme.accentColor)
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
