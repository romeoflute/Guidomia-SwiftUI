//
//  CarFilterView.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/29/24.
//

import SwiftUI

struct CarFilterView: View {
    @ObservedObject var viewModel: BrowseCarsViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: Layout.standard) {
                Text("Filters")
                    .foregroundStyle(Color.white)
                TextField("Any make", text: $viewModel.makeFilter)
                    .preferredColorScheme(.light)
                    .autocorrectionDisabled()
                    .font(.footnote)
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(.roundedBorder)
                TextField("Any model", text: $viewModel.modelFilter)
                    .preferredColorScheme(.light)
                    .autocorrectionDisabled()
                    .font(.footnote)
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(.roundedBorder)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.all, Layout.standard)
            .background(Color.GDarkGray)
        }
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .background(.white)
    }
}

#Preview {
    CarFilterView(viewModel: BrowseCarsViewModel())
}
