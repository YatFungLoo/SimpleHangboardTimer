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
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingEditView = false
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Edit Details")
                            .font(.headline)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
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
