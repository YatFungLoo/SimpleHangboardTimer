//
//  ScrumTimer.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 5/2/2025.
//

import Foundation

@MainActor
final class ExerciseTimer: ObservableObject {
    @Published var activeExecName = ""
    @Published var totalSecondsElasped = 0
    @Published var totalSecondsRemaining = 0
    @Published var totalSeconds = 0
    @Published var secondsRemaining = 0 // for each exercise
    @Published var currentExecDuration = 0
    @Published var currentExecIndex = 0
    
    private var execs: [UniqueExec] = []
    private var lengthInSeconds: Int = 0
    
    var execChangedAction: (() -> Void)?
    private weak var timer: Timer?
    
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 } // 60fps
    private var secondsElapsedForExec: Int = 0
    private var execIndex: Int = 0
    private var startDate: Date?
    
    init(execs: [UniqueExec] = []) {}
    
    func setup(execs: [UniqueExec]) {
        self.execs = execs
        self.secondsRemaining = self.execs.first?.durationInSeconds ?? 0
        self.totalSeconds = execs.reduce(0) { $0 + $1.durationInSeconds }
    }
    
    func startExercise() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true)
        {
            [weak self] timer in
            self?.update()
        }
        timer?.tolerance = 0.1
        changeToExec(at: 0)
    }
    
    func stopExercise() {
        timer?.invalidate()
        timerStopped = true
    }
    
    private func changeToExec(at index: Int) {
        if index > 0 {
            let previousExecIndex = index - 1
            execs[previousExecIndex].isCompleted = true
        }
        secondsElapsedForExec = 0
        guard index < execs.count else { return }
        let currentExec = execs[index]
        activeExecName = currentExec.name
        currentExecDuration = currentExec.durationInSeconds
        
        if index <= 0 {
            totalSecondsElasped = 0
        } else {
            totalSecondsElasped = execs.prefix(index - 1).reduce(0) {$0 + $1.durationInSeconds}
        }
        secondsRemaining = execs[index].durationInSeconds
        startDate = Date()
    }
    
    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate, !timerStopped else { return }
            let secondsElapsed = Int(
                Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            self.secondsRemaining = currentExecDuration - secondsElapsed
            self.totalSecondsElasped = secondsElapsed
//            self.secondsElasped =
//            secondsPerExec * execIndex + secondsElapsedForExec
//            guard secondsElapsed <= secondsPerExec else {
//                return
//            }
            self.totalSecondsRemaining = max(self.totalSeconds - self.totalSecondsElasped, 0)
//
//            if secondsElapsedForExec >= secondsPerExec {
//                changeToExec(at: execIndex + 1)
//                execChangedAction?()
//            }
        }
    }
}
