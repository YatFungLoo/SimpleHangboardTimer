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
    
    init(id: UUID = UUID(), title: String, intervals: [Interval], sets: Int, theme: Theme, history: [History]) {
        self.id = id
        self.title = title
        self.intervals = intervals
        self.sets = sets
        self.theme = theme
        self.history = history
    }
}

extension Exercise {
    struct Interval: Identifiable, Codable {
        let id: UUID
        var hang: Int
        var rest: Int
        var repeats: Int
        var off: Int
        
        init(id: UUID = UUID(), hang: Int, rest: Int, repeats: Int, off: Int) {
            self.id = id
            self.hang = hang
            self.rest = rest
            self.repeats = repeats
            self.off = off
        }
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
                 intervals:[Interval(hang: 3, rest: 2, repeats: 2, off: 5)],
                 sets: 5,
                 theme: .bubblegum,
                 history: []),
        Exercise(title: "Carrot Power",
                 intervals:[Interval(hang: 7, rest: 3, repeats: 5, off: 60)],
                 sets: 5,
                 theme: .orange,
                 history: []),
        Exercise(title: "10-30 feet-on",
                 intervals:[Interval(hang: 10, rest: 30, repeats: 3, off: 120)],
                 sets: 3,
                 theme: .tan,
                 history: []),
        Exercise(title: "Rehab hang",
                 intervals:[Interval(hang: 60, rest: 120, repeats: 2, off: 180)],
                 sets: 5,
                 theme: .indigo,
                 history: []),
    ]
}
