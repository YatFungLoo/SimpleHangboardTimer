//
//  TimerListView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 12/4/2025.
//

import SwiftUI

struct ExerciseListView: View {
    @Binding var exercises: [Exercise]
    @Environment(\.scenePhase) private var scenePhase  // Return current view operational state.
    @State private var isPresentingNewExerciseView = false
    let saveAction: () -> Void

    var body: some View {
        NavigationStack {
            List($exercises, editActions: .delete) { $exercise in
                NavigationLink(destination: ExerciseDetailView(exercise: $exercise)) {
                    ExerciseCardView(exercise: exercise)
                }
                .listRowBackground(exercise.theme.mainColor)
            }
            .navigationTitle("Hangboard Timer")
            .toolbar {
                Button(action: {
                    isPresentingNewExerciseView = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isPresentingNewExerciseView) {
                NewExerciseSheet(
                    exercises: $exercises,
                    isPresentingNewExerciseView: $isPresentingNewExerciseView
                )
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView(exercises: .constant(Exercise.sampleData), saveAction: {})
    }
}
