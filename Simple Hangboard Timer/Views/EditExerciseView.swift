//
//  EditExerciseDetailView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 16/5/2025.
//

import SwiftUI

struct EditExerciseView: View {
    @State private var confirmationShown = false
    @Binding var exercise: Exercise
    
    var body: some View {
        Form {
            Section(header: Text("Click To Change Title")) {
                TextField("Title", text: $exercise.title)
            }
            Section(header: Text("Click On Item To Edit")) {
                CollapsibleMinSecPicker(minutes: $exercise.intervals[0].hangMinIndex, seconds: $exercise.intervals[0].hangSecIndex) {
                    Label("On", systemImage: "carrot.fill")
                    Spacer()
                    Text("\(exercise.timeFormatter(exercise.intervals[0].hangMinIndex)):\(exercise.timeFormatter(exercise.intervals[0].hangSecIndex))")
                        .foregroundStyle(.blue)
                }
                CollapsibleMinSecPicker(minutes: $exercise.intervals[0].restMinIndex, seconds: $exercise.intervals[0].restSecIndex) {
                    Label("Off", systemImage: "carrot")
                    Spacer()
                    Text("\(exercise.timeFormatter(exercise.intervals[0].restMinIndex)):\(exercise.timeFormatter(exercise.intervals[0].restSecIndex))")
                        .foregroundStyle(.blue)
                }
                CollapsibleMinSecPicker(minutes: $exercise.intervals[0].offMinIndex, seconds: $exercise.intervals[0].offSecIndex) {
                    Label("Rest", systemImage: "powersleep")
                    Spacer()
                    Text("\(exercise.timeFormatter(exercise.intervals[0].offMinIndex)):\(exercise.timeFormatter(exercise.intervals[0].offSecIndex))")
                        .foregroundStyle(.blue)
                }
                HStack {
                    Label("Reps: ", systemImage: "repeat")
                    Spacer()
                    Stepper("\(exercise.intervals[0].repeats)",
                            value: $exercise.intervals[0].repeats,
                            in: 1...20,
                            step: 1)
                }
                HStack {
                    Label("Sets: ", systemImage: "arrow.trianglehead.clockwise.rotate.90")
                    Spacer()
                    Stepper("\(exercise.sets)",
                            value: $exercise.sets,
                            in: 1...20,
                            step: 1)
                }
            }
            Section(header: Text("Misc")) {
                HStack {
                    Picker("Theme", selection: $exercise.theme) {
                        ForEach(Theme.allCases) { theme in
                            ThemeView(theme: theme)
                                .tag(theme)  // TODO: what are SwiftUI tag
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
            }
            Section {
                    Button("Delete timer", role: .destructive) {
                        confirmationShown = true
                    }
                    .confirmationDialog("", isPresented: $confirmationShown) {
                        Button("Confirm", role: .destructive) {
                        }
                        Button("Cancel", role: .cancel) {
                        }
                    } message: {
                        Text("This isn't implemeted just yet, Please delete from main page by swaping left")
                    }
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        EditExerciseView(exercise: .constant(Exercise.sampleData[0]))
    }
}
