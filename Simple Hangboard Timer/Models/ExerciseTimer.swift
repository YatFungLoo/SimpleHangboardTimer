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
    @Published var timerStopped = false
    @Published var isReady = false

    private var execs: [UniqueExec] = []
    private var currExecElaspedSeconds: Int = 0 // keep track total seconds elasped
    
    var execChangedAction: (() -> Void)?
    private weak var timer: Timer?
    
    private var frequency: TimeInterval { 1.0 / 60.0 } // 60fps
    private var secondsElapsedForExec: Int = 0
    private var deltaSeconds: Int = 0 // store difference for update()
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
        timerStopped = false
        isReady = false
        currExecElaspedSeconds = 0
        secondsElapsedForExec = 0
        execIndex = 0
    }
    
    func startExercise() {
        timer?.invalidate()
        timerStopped = false
        isReady = true
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
    
    func readyExercise() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true)
        {
            [weak self] timer in
            self?.ready()
        }
        timer?.tolerance = 0.1
        currentExecDuration = 3
        startDate = Date()
    }
    
    func resumeExercise() {
        timer?.invalidate()
        timerStopped = false
        if isReady == true {
            timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true)
            {
                [weak self] timer in
                self?.update()
            }
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true)
            {
                [weak self] timer in
                self?.ready()
            }
        }
        timer?.tolerance = 0.1
        startDate = Date()
    }
    
    func pauseExercise() {
        deltaSeconds = currentExecDuration - secondsRemaining
        startDate = nil
        timer?.invalidate()
        timerStopped = true
    }
    
    func resumePauseExercise() {
        timerStopped ? resumeExercise() : pauseExercise()
    }
    
    func skipExercise() {
        if execIndex >= execs.count - 1 {
            execIndex = execs.count - 1
        } else if isReady == false {
            isReady = true
            execIndex = 0
            startExercise()
        } else {
            execIndex = execIndex + 1
        }
        changeToExec(at: execIndex)
        execChangedAction?()
    }
    
    func previousExercise() {
        if execIndex <= 0 {
            execIndex = 0
        } else {
            execIndex = execIndex - 1
        }
        changeToExec(at: max(execIndex, 0))
        execChangedAction?()
    }
    
    private func changeToExec(at index: Int) {
        currentExecIndex = index
        if index > 0 {
            let previousExecIndex = index - 1
            execs[previousExecIndex].isCompleted = true
            // TODO: mark isCompleted false for Exec after current.
        }
        secondsElapsedForExec = 0
        guard index < execs.count else { return }
        let currentExec = execs[index]
        activeExecName = currentExec.name
        currentExecDuration = currentExec.durationInSeconds
        
        if index <= 0 {
            totalSecondsElasped = 0
            currExecElaspedSeconds = 0
            totalSecondsRemaining = totalSeconds
        } else {
            totalSecondsElasped = execs.prefix(index).reduce(0) {$0 + $1.durationInSeconds}
            currExecElaspedSeconds = totalSecondsElasped
            totalSecondsRemaining = max(totalSeconds - totalSecondsElasped, 0)
        }
        
        secondsRemaining = execs[index].durationInSeconds
        deltaSeconds = 0
        startDate = Date()
    }
    
    nonisolated private func ready() {
        Task { @MainActor in
            guard let startDate, !timerStopped else { return }
            let secondsElapsed = Int(
                Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            self.secondsRemaining = currentExecDuration - secondsElapsed // count down
            
            if self.secondsRemaining <= 0 {
                isReady = true
                startExercise()
            }
        }
    }

    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate, !timerStopped else { return }
            let secondsElapsed = Int(
                Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            self.secondsRemaining = currentExecDuration - secondsElapsed - deltaSeconds // count down
            self.totalSecondsElasped = currExecElaspedSeconds + secondsElapsed + deltaSeconds // count up
            self.totalSecondsRemaining = max(self.totalSeconds - self.totalSecondsElasped, 0)
            
            if self.secondsRemaining <= 0 && execIndex != execs.count - 1 {
                execIndex = execIndex + 1
                changeToExec(at: execIndex)
                execChangedAction?()
            }
            
            if execIndex >= execs.count - 1 {
                stopExercise()
            }
        }
    }
}
