//
//  ExerciseView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 12/4/2025.
//

import SwiftUI

struct ExerciseDetailView: View {
    @Binding var exercise: Exercise
    
    @State private var editingExercise = Exercise.emptyExercise
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Workout Info")) {
                NavigationLink(destination: ExerciseView(exercise: $exercise)) {
                    Label("Start Timer", systemImage: "timer")
                        .symbolEffect(.bounce, value: 1)
                        .font(.headline)
                }
                HStack {
                    Label("Duration", systemImage: "clock")
                    Spacer()
                    Text("\(exercise.totalDurationInSec())")
                }
            }
            Section(header: Text("Training Details")) {
                HStack {
                    Label("On", systemImage: "carrot.fill")
                    Spacer()
                    Text("\(exercise.secOrMin(lengthInSeconds: exercise.intervals[0].hang))")
                }
                HStack {
                    Label("Off", systemImage: "carrot")
                    Spacer()
                    Text("\(exercise.secOrMin(lengthInSeconds: exercise.intervals[0].rest))")
                }
                HStack {
                    Label("Rest", systemImage: "powersleep")
                    Spacer()
                    Text("\(exercise.secOrMin(lengthInSeconds: exercise.intervals[0].off))")
                }
                HStack {
                    Label("Reps", systemImage: "repeat")
                    Spacer()
                    Text("\(exercise.intervals[0].repeats)")
                }
                HStack {
                    Label("Sets", systemImage: "arrow.trianglehead.clockwise.rotate.90")
                    Spacer()
                    Text("\(exercise.sets)")
                }
            }
            Section(header: Text("Misc")) {
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text("\(exercise.theme.name)")
                        .padding(4)
                        .foregroundColor(exercise.theme.accentColor)
                        .background(exercise.theme.mainColor)
                        .cornerRadius(4)
                }
            }
        }
        .navigationTitle(exercise.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                editingExercise = exercise
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            
        }
    }
}

struct ExerciseDetailView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExerciseDetailView(exercise: .constant(Exercise.sampleData[1]))
        }
    }
}
