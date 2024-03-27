//
//  ViewExtension.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

extension View {
    func navigationBarBackground(_ background: Color = Color.GOrange) -> some View {
        return self
            .modifier(ColoredNavigationBar(background: background))
    }
}

struct ColoredNavigationBar: ViewModifier {
    var background: Color
    
    func body(content: Content) -> some View {
        content
            .toolbarBackground(
                background,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
