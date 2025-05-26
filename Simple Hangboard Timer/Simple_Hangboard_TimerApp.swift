//
//  Simple_Hangboard_TimerApp.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 12/4/2025.
//

import SwiftUI

@main
struct Simple_Hangboard_TimerApp: App {
    @StateObject private var store = ExerciseStore()
    @State private var errorWrapper: ErrorWrapper?  // Default value of an optional is nil. (Note: use ":")

    var body: some Scene {
        WindowGroup {
            ExerciseListView(exercises: $store.exercises) {
                Task {
                    do {
                        try await store.save(exercises: store.exercises)
                    } catch {
                        errorWrapper = ErrorWrapper(
                            error: error, guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(
                        error: error,
                        guidance:
                            "Simple Hangboard Timer will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.exercises = Exercise.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
