//
//  FilterTextFieldStyle.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/29/24.
//

import SwiftUI

struct FilterTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(.light)
            .autocorrectionDisabled()
            .font(.footnote)
            .frame(maxWidth: .infinity)
            .textFieldStyle(.roundedBorder)
    }
}

extension View {
    func filterTextFieldStyle() -> some View {
        modifier(FilterTextFieldStyle())
    }
}
