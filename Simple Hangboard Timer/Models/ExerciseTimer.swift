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
    private var currExecElaspedSeconds: Int = 0 // keep track total seconds elasped
    
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
    
    func reset() {
        activeExecName = ""
        totalSecondsElasped = 0
        totalSecondsRemaining = 0
        totalSeconds = 0
        secondsRemaining = 0 // for each exercise
        currentExecDuration = 0
        currentExecIndex = 0
        currExecElaspedSeconds = 0
        timerStopped = false
        secondsElapsedForExec = 0
        execIndex = 0
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
        currentExecIndex = index
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
            totalSecondsElasped = execs.prefix(index).reduce(0) {$0 + $1.durationInSeconds}
            currExecElaspedSeconds = totalSecondsElasped
        }
        secondsRemaining = execs[index].durationInSeconds
        startDate = Date()
    }
    
    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate, !timerStopped else { return }
            let secondsElapsed = Int(
                Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            self.secondsRemaining = currentExecDuration - secondsElapsed // count down
            self.totalSecondsElasped = currExecElaspedSeconds + secondsElapsed // count up
            self.totalSecondsRemaining = max(self.totalSeconds - self.totalSecondsElasped, 0)
            
            if self.secondsRemaining <= 0 {
                execIndex = execIndex + 1
                changeToExec(at: execIndex)
                execChangedAction?()
            }
            
            if execIndex >= execs.count {
                stopExercise()
            }
            //
            //            if secondsElapsedForExec >= secondsPerExec {
            //                changeToExec(at: execIndex + 1)
            //                execChangedAction?()
            //            }
        }
    }
}
