//
//  TimerListView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 12/4/2025.
//

import SwiftUI

struct ExerciseListView: View {
    @Binding var exercises: [Exercise]
    @State private var isPresentingNewExerciseView = false
    
    var body: some View {
        NavigationStack {
            List($exercises) { $exercise in
                NavigationLink(destination: ExerciseView()) {
                    Text(exercise.title)
                }
                .navigationTitle("Exercises")
                
            }
            .toolbar {
                Button(action: {
                    isPresentingNewExerciseView = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewExerciseView) {
            NewExerciseSheet()
        }
    }
}

struct TimerListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView(exercises: .constant(Exercise.sampleData))
    }
}
