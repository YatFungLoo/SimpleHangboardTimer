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
                NavigationLink(destination: ExerciseView(exercise: exercise)) {
                    VStack(alignment: .center) {
                        Text(exercise.title)
                            .font(.headline)
                        Spacer()
                        HStack {
                            if (exercise.intervals[0].off <= 60) {
                                Label("\(exercise.intervals[0].hang)-\(exercise.intervals[0].rest) x \(exercise.intervals[0].repeats) /  \(exercise.intervals[0].off) sec rest", systemImage: "carrot")
                            } else if (exercise.intervals[0].off > 60) {
                                let offInMintues = exercise.intervals[0].off / 60
                                Label("\(exercise.intervals[0].hang)-\(exercise.intervals[0].rest) x \(exercise.intervals[0].repeats) / \(offInMintues) min rest", systemImage: "carrot")
                            }
                            Spacer()
                            Label("\(exercise.sets) sets", systemImage: "arrow.clockwise")
                                .labelStyle(.trailingIcon)
                        }
                        .font(.caption)
                    }
                    .padding()
                    .foregroundStyle(exercise.theme.accentColor)
                }
                .listRowBackground(exercise.theme.mainColor)
                .opacity(1.0)
            }
            .navigationTitle("Hangboard Timer")
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
