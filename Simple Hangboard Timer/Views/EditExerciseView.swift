//
//  EditExerciseDetailView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 16/5/2025.
//

import SwiftUI

struct EditExerciseView: View {
    @Binding var exercise: Exercise
    
    private let minRange = 0..<6
    private let secRange = 0..<60
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $exercise.title)
            }
            Section(header: Text("Training Details")) {
                HStack {
                    VStack {
                        HStack {
                            Label("Off", systemImage: "carrot")
                            Spacer()
                            Text("\(exercise.intervals[0].hang)")
                        }
                        HStack {
                            Picker(selection: $exercise.intervals[0].hangMinIndex, label: Text("Hang")) {
                                ForEach(minRange, id: \.self) {     // TODO: look into this more soon.
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            Picker(selection: $exercise.intervals[0].hangSecIndex, label: Text("Hang")) {
                                ForEach(secRange, id: \.self) { 
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                    }
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
