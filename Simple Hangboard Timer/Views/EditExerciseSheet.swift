//
//  EditingExerciseView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 16/5/2025.
//

import SwiftUI

struct EditingExerciseSheet: View {
    @Binding var exercise: Exercise
    @Binding var editingExercise: Exercise
    @Binding var isPresentingEditView: Bool
    
    var body: some View {
        NavigationStack {
            EditExerciseView(exercise: $editingExercise)
                .navigationTitle("Editing: \(exercise.title)")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Weak") {
                            isPresentingEditView = false
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Strong") {
                            isPresentingEditView = false
                            exercise = editingExercise
                        }
                    }
                }
        }
    }
}

struct EditExerciseSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditingExerciseSheet(exercise: .constant(Exercise.sampleData[0]), editingExercise: .constant(Exercise.sampleData[1]), isPresentingEditView: .constant(true))
    }
}
