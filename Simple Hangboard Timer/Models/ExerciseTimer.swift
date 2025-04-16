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
    @Published var secondsElasped = 0
    @Published var secondsRemaining = 0
    @Published var currentExecIndex = 0
    
    private var execs: [Exec] = []
    private var lengthInSeconds: Int = 0
    
    var execChangedAction: (() -> Void)?
    private weak var timer: Timer?
    
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 } // 60fps
    private var secondsElapsedForExec: Int = 0
    private var execIndex: Int = 0
    private var startDate: Date?
    
    init(execs: [Exec] = []) {
        self.execs = execs
        self.secondsRemaining = self.execs.first?.durationInSeconds ?? 0
    }
    
    func startExercise() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: false)
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
        
        secondsElasped = currentExec.durationInSeconds
        secondsRemaining = lengthInSeconds - secondsElasped
        startDate = Date()
    }
    
    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate, !timerStopped else { return }
            let secondsElapsed = Int(
                Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
//                        secondsElapsedForExec = secondsElapsed
            //            self.secondsElasped =
            //            secondsPerExec * execIndex + secondsElapsedForExec
            //            guard secondsElapsed <= secondsPerExec else {
            //                return
            //            }
            //            secondsRemaining = max(lengthInSeconds - self.secondsElasped, 0)
            //
            //            if secondsElapsedForExec >= secondsPerExec {
            //                changeToExec(at: execIndex + 1)
            //                execChangedAction?()
        }
    }
}
