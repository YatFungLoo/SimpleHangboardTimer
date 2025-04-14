//
//  History.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 12/4/2025.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var title: String
    var durations: [Exercise.Duration]
    
    init(id: UUID, date: Date, title: String, timers: [Exercise.Duration]) {
        self.id = id
        self.date = date
        self.title = title
        self.durations = timers
    }
}
