//
//  NewExerciseSheet.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 12/4/2025.
//

import SwiftUI

struct NewExerciseSheet: View {
    @State private var newExercise = Exercise.emptyExercise
    @Binding var exercises: [Exercise]
    @Binding var isPresentingNewExerciseView: Bool

    var body: some View {
        NavigationStack {
            EditExerciseView(exercise: $newExercise)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewExerciseView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            exercises.append(newExercise)
                            isPresentingNewExerciseView = false
                        }
                    }
                }
        }
    }
}

struct NewExerciseSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewExerciseSheet(
            exercises: .constant(Exercise.sampleData),
            isPresentingNewExerciseView: .constant(true))
    }
}
