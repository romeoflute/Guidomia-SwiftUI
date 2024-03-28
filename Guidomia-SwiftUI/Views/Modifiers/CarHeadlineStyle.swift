//
//  CarHeadlineStyle.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/29/24.
//

import SwiftUI

struct CarHeadlineStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .foregroundStyle(Color.GTextColor)
    }
}

extension View {
    func carHeadlineStyle() -> some View {
        modifier(CarHeadlineStyle())
    }
}
