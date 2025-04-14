//
//  ExerciseView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 12/4/2025.
//

import SwiftUI

struct ExerciseDetailView: View {
    @Binding var exercise: Exercise
    var body: some View {
        List {
            Section(header: Text("Workout Info")) {
                Label("Start Timer", systemImage: "timer")
                HStack {
                    Label("Duration", systemImage: "clock")
                }
            }
            Section(header: Text("Training Details")) {
                HStack {
                    Label("On", systemImage: "carrot")
                    Spacer()
                    Text("\(exercise.secOrMin(lengthInSeconds: exercise.intervals[0].hang))")
                }
                HStack {
                    Label("Off", systemImage: "carrot.fill")
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
    }
}

struct ExerciseView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExerciseDetailView(exercise: .constant(Exercise.sampleData[1]))
        }
    }
}
