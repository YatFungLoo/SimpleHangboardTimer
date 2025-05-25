//
//  CollapsibleMinSecPicker.swift
//  Simple Hangboard Timer
//
//  Created by YatFungLoo on 22/5/2025.
//
// Extension of https://augmentedcode.io/2023/06/26/collapsible-wheel-picker-for-forms-in-swiftui/
// by Toomas Vahter
//

import SwiftUI

struct CollapsibleView<Label, Content>: View where Label: View, Content: View {
    @State private var isPresentingPicker = false
    @ViewBuilder let label: () -> Label
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        Group {
            Button(action: { withAnimation() {isPresentingPicker.toggle()} }) {
                HStack {
                   label()
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            if isPresentingPicker {
               content()
            }
        }
    }
}

struct CollapsibleMinSecPicker<MinutesValue, SecondsValue, Label>: View where MinutesValue: Hashable, SecondsValue: Hashable, Label: View{
    @Binding var minutes: MinutesValue
    @Binding var seconds: SecondsValue
    @ViewBuilder let label: () -> Label
    
    private let minutesRange = 0..<6
    private let secondsRange = 0..<60
    
    var body: some View {
        CollapsibleView(label: label) {
            HStack {
                Picker("", selection: $minutes) {
                    ForEach(minutesRange, id: \.self) { id in
                        Text("\(id)")
                            .tag(id)
                    }
                }
                .pickerStyle(.wheel)
                Text("minutes")
                Picker("", selection: $seconds) {
                    ForEach(secondsRange, id: \.self) { id in
                        Text("\(id)")
                            .tag(id)
                    }
                }
                .pickerStyle(.wheel)
                Text("seconds")
            }
        }
    }
}

struct CollapsibleMinSecPicker_PreviewProvider: PreviewProvider {
    static func Formatter(_ length: Int) -> String {
        guard length > 0 else { return "00"}
        guard length <= 60 else { return "error"}
        return length < 10 ? "0\(length)" : "\(length)"
    }
    
    static var previews: some View {
        @State var minutes: Int = 0
        @State var seconds: Int = 0
        
        Form {
            CollapsibleMinSecPicker(minutes: $minutes, seconds: $seconds) {
                Text("Timer")
                Spacer()
                Text("\(Formatter(minutes)):\(Formatter(seconds))")
                    .foregroundStyle(.blue.gradient)
            }
        }
    }
}
