//
//  Exercise.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 12/4/2025.
//

import Foundation

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
            intervals :[],
            sets :0,
            theme :.sky)
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
        if (lengthInSeconds <= 0) {
            return "invalid input"
        } else if (lengthInSeconds < 60) {
            return "\(lengthInSeconds) sec"
        } else if (lengthInSeconds >= 60) {
            let lengthInMinutes: Int = lengthInSeconds / 60
            return "\(lengthInMinutes) min"
        }
        return ""
    }
    
    func totalDurationInSec() -> Int {
        let total: Int = ((self.intervals[0].hang + self.intervals[0].rest) * self.intervals[0].repeats + self.intervals[0].off) * self.sets - self.intervals[0].off
        return total
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
        Exercise(title: "Test",
                 intervals: [Interval(hangMinIndex: 0, hangSecIndex: 3, restMinIndex: 0, restSecIndex: 3, offMinIndex: 0, offSecIndex: 5, repeats: 2)],
                 sets: 5,
                 theme: .bubblegum),
        Exercise(title: "Carrot Power",
                 intervals:[Interval(hangMinIndex: 0, hangSecIndex: 7, restMinIndex: 0, restSecIndex: 3, offMinIndex: 0, offSecIndex: 60, repeats: 5)],
                 sets: 5,
                 theme: .orange),
        Exercise(title: "10-30 feet-on",
                 intervals:[Interval(hangMinIndex: 0, hangSecIndex: 10, restMinIndex: 0, restSecIndex: 30, offMinIndex: 0, offSecIndex: 120, repeats: 3)],
                 sets: 3,
                 theme: .tan),
        Exercise(title: "Rehab hang",
                 intervals:[Interval(hangMinIndex: 0, hangSecIndex: 60, restMinIndex: 0, restSecIndex: 120, offMinIndex: 0, offSecIndex: 180, repeats: 2)],
                 sets: 5,
                 theme: .indigo),
    ]
}
