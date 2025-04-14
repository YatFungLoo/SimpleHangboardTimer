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
    var durations: [Duration]
    var repeats: Int
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, durations: [Duration], repeats: Int, theme: Theme, history: [History]) {
        self.id = id
        self.title = title
        self.durations = durations
        self.repeats = repeats
        self.theme = theme
        self.history = history
    }
}

extension Exercise {
    struct Duration: Identifiable, Codable {
        let id: UUID
        var duration: Int
        
        init(id: UUID = UUID(), duration: Int) {
            self.id = id
            self.duration = duration
        }
    }
}

extension Exercise {
    static var sampleData: [Exercise] =
    [
        Exercise(title: "7-3 hang",
                 durations:[Duration(duration: 7), Duration(duration: 3)],
                 repeats: 5,
                 theme: .orange,
                 history: []),
        Exercise(title: "10-30 hang",
                 durations:[Duration(duration: 10), Duration(duration: 30)],
                 repeats: 3,
                 theme: .orange,
                 history: []),
    ]
}
