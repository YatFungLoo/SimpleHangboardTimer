//
//  ExerciseControlButtonStyle.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 28/5/2025.
//

import SwiftUI

struct ExerciseControlButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
            .frame(maxWidth: .infinity, maxHeight: 50)
            .bold()
            .foregroundStyle(.white)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == ExerciseControlButtonStyle {
    static var controlButton: Self { Self() }
}
