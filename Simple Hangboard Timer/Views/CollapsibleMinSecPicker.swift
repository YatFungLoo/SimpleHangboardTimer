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
            Button(action: { withAnimation() {isPresentingPicker.toggle()} }, label: label)
                .buttonStyle(.plain)
            if isPresentingPicker {
               content()
            }
        }
    }
}

struct CollapsibleMinSecPicker<MinutesValue, SecondsValue, Content, Label>: View where MinutesValue: Hashable, SecondsValue: Hashable, Content: View, Label: View{
    @Binding var minutes: MinutesValue
    @Binding var seconds: SecondsValue
    @ViewBuilder let content: () -> Content
    @ViewBuilder let label: () -> Label

    private let Range = 0..<60
    
    var body: some View {
        CollapsibleView(label: label) {
            HStack {
                Picker(selection: $minutes, content: content) {
                    EmptyView()
                }
                .pickerStyle(.wheel)
                Picker(selection: $seconds, content: content) {
                    EmptyView()
                }
                .pickerStyle(.wheel)
            }
        }
    }
}

struct CollapsibleMinSecPicker_PreviewProvider: PreviewProvider {
    static var previews: some View {
        @State var minutes: Int = 0
        @State var seconds: Int = 0
        
        let Range = 0..<60
        
        Form {
            CollapsibleMinSecPicker(minutes: $minutes, seconds: $seconds) {
                ForEach(Range, id: \.self) {     // TODO: look into this more soon.
                    Text("\($0)")
                }
            } label: {
                Text("Minutes")
                Spacer()
                Text("\(minutes)")
                    .foregroundStyle(.blue.gradient)
            }
            CollapsibleMinSecPicker(minutes: $minutes, seconds: $seconds) {
                ForEach(Range, id: \.self) {     // TODO: look into this more soon.
                    Text("\($0)")
                }
            } label: {
                Text("Minutes")
                Spacer()
                Text("\(minutes)")
            }
        }
    }
}
