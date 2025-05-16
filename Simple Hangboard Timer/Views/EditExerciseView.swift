//
//  EditExerciseDetailView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 16/5/2025.
//

import SwiftUI

struct EditExerciseView: View {
    @Binding var exercise: Exercise
    
    var body: some View {
        Form {
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
        }
    }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        EditExerciseView(exercise: .constant(Exercise.sampleData[0]))
    }
}
