//
//  ThemeView.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 26/5/2025.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    
    var body: some View {
        Text(theme.name)
            .padding(4)
            .foregroundColor(theme.accentColor)
            .background(theme.mainColor)
            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
    }
}

#Preview {
    ThemeView(theme: .indigo)
}
