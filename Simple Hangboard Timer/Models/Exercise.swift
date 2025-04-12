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

extension Exercise {
    static var sampleData: [Exercise] =
    [
        Exercise(title: "7-3 hang",
                 intervals:[Interval(hang: 7, rest: 3, repeats: 5, off: 60)],
                 sets: 5,
                 theme: .orange,
                 history: []),
        Exercise(title: "10-30 hang",
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
