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
    var intervals: [Exercise.Interval]
    
    init(id: UUID, date: Date, title: String, intervals: [Exercise.Interval]) {
        self.id = id
        self.date = date
        self.title = title
        self.intervals = intervals
    }
}
