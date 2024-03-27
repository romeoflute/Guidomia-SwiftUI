//
//  ExpandedCarView.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

struct ExpandedCarView: View {
    let car: Car
    
    var body: some View {
        VStack(alignment: .leading, spacing: Layout.close) {
            
            CompactCarView(car: car)
            
            if car.prosList.count > 0 {
                BulletedListView(title: "Pros :", strings: car.prosList)
                    .padding(.horizontal, Layout.standard)
            }
            
            if car.consList.count > 0 {
                BulletedListView(title: "Cons :", strings: car.consList)
                    .padding(.horizontal, Layout.standard)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, Layout.mediumStandard)
        .background(Color.GLightGray)
        
    }
}

#Preview {
    ExpandedCarView(car: Car(consList: [], customerPrice: 50000, make: "Land Rover", marketPrice: 225000, model: "Range Rover", prosList: [], rating: 5, imageName: "", isFeatured: false))
}
