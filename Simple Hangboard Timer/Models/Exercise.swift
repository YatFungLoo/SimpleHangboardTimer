//
//  Exercise.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 12/4/2025.
//

import Foundation
import ActivityKit

struct Exercise: Identifiable, Codable {
    let id: UUID
    var title: String
    var intervals: [Interval]
    var sets: Int
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, intervals: [Interval], sets: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.intervals = intervals
        self.sets = sets
        self.theme = theme
    }
}

extension Exercise {
    struct Interval: Identifiable, Codable {
        let id: UUID
        var hangMinIndex: Int
        var hangSecIndex: Int
        var hang: Int {
            get {
                hangMinIndex * 60 + hangSecIndex
            }
        }
        var restMinIndex: Int
        var restSecIndex: Int
        var rest: Int {
              get {
                restMinIndex * 60 + restSecIndex
            }
        }
        var offMinIndex: Int
        var offSecIndex: Int
        var off: Int {
                    get {
                offMinIndex * 60 + offSecIndex
            }
        }
        var repeats: Int

        init(id: UUID = UUID(), hangMinIndex: Int, hangSecIndex: Int, restMinIndex: Int, restSecIndex: Int, offMinIndex: Int, offSecIndex: Int, repeats: Int) {
            self.id = id
            self.hangMinIndex = hangMinIndex
            self.hangSecIndex = hangSecIndex
            self.restMinIndex = restMinIndex
            self.restSecIndex = restSecIndex
            self.offMinIndex = offMinIndex
            self.offSecIndex = offSecIndex
            self.repeats = repeats
        }
    }
    
    static var emptyExercise: Exercise {
        Exercise(
            title :"",
            intervals :[emptyInterval], // need to add a default interval
            sets :1,
            theme :.sky)
    }
    
    static var emptyInterval: Interval {
        Interval(hangMinIndex: 0,
                 hangSecIndex: 0,
                 restMinIndex: 0,
                 restSecIndex: 0,
                 offMinIndex: 0,
                 offSecIndex: 0,
                 repeats: 1
        )
    }
}

struct UniqueExec: Identifiable {
    let id: UUID
    let name: String
    let durationInSeconds: Int
    var isCompleted: Bool
    
    init(id: UUID = UUID(), name: String, durationInSeconds: Int, isCompleted: Bool) {
        self.id = id
        self.name = name
        self.durationInSeconds = durationInSeconds
        self.isCompleted = isCompleted
    }
}

extension Exercise {
    func secOrMin(lengthInSeconds: Int) -> String {
        guard lengthInSeconds > 0 else { return "error" }
        return lengthInSeconds < 60 ? "\(lengthInSeconds) sec" : "\(lengthInSeconds / 60) min"
    }

    func timeFormatter(_ length: Int) -> String {
        guard length > 0 else { return "00" }
        guard length <= 60 else { return "error" }
        return length < 10 ? "0\(length)" : "\(length)"
    }
    
    func totalDurationInSec() -> Int {
        let total: Int = ((self.intervals[0].hang + self.intervals[0].rest) * self.intervals[0].repeats + self.intervals[0].off) * self.sets - self.intervals[0].off
        return total
    }
    
    func totalDurationFormatter() -> String {
        let lengthInSeconds = totalDurationInSec()
        let min = timeFormatter(lengthInSeconds / 60)
        let sec = timeFormatter(lengthInSeconds % 60)
        return "\(min):\(sec)"
    }
    
    func tasksCompilation() -> [UniqueExec] {
        let baseTasks = Array(repeating: [
            UniqueExec(name: "hang", durationInSeconds: self.intervals[0].hang, isCompleted: false),
            UniqueExec(name: "rest", durationInSeconds: self.intervals[0].rest, isCompleted: false)
        ], count: self.intervals[0].repeats).flatMap { $0 }
        
        let baseTasksWithOff = baseTasks + [UniqueExec(name: "off", durationInSeconds: self.intervals[0].off, isCompleted: false)]
        
        return Array(repeating: baseTasksWithOff, count: self.sets - 1).flatMap { $0 } + baseTasks + [UniqueExec(name: "end", durationInSeconds: 0, isCompleted: false)]
    }
}

extension Exercise {
    static var sampleData: [Exercise] =
    [
        Exercise(title: "7-3 hang",
                 intervals:[Interval(hangMinIndex: 0, hangSecIndex: 7, restMinIndex: 0, restSecIndex: 3, offMinIndex: 1, offSecIndex: 0, repeats: 5)],
                 sets: 3,
                 theme: .orange),
        Exercise(title: "10-30 feet-on",
                 intervals:[Interval(hangMinIndex: 0, hangSecIndex: 10, restMinIndex: 0, restSecIndex: 30, offMinIndex: 2, offSecIndex: 0, repeats: 3)],
                 sets: 2,
                 theme: .tan),
        Exercise(title: "Rehab",
                 intervals:[Interval(hangMinIndex: 1, hangSecIndex: 0, restMinIndex: 2, restSecIndex: 0, offMinIndex: 3, offSecIndex: 0, repeats: 2)],
                 sets: 5,
                 theme: .indigo),
    ]
}
