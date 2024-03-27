//
//  CompactCarView.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

struct CompactCarView: View {
    let car: Car
    
    var body: some View {
        HStack(alignment: .center, spacing: Layout.mediumStandard) {
            Image(car.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120)
                .padding(.leading, Layout.standard)
            VStack(alignment: .leading, spacing: 6) {
                CarHeadlineView(car: car)
                Rating(car: car)
            }
            Spacer()
        }
        .listRowInsets(EdgeInsets())
        .padding(.vertical, Layout.standard)
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray5))
    }
}

#Preview {
    CompactCarView(car: Car(consList: [], customerPrice: 50000, make: "Land Rover", marketPrice: 225000, model: "Range Rover", prosList: [], rating: 5, imageName: "", isFeatured: false))
}
