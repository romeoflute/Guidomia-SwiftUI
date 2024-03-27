//
//  Rating.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

struct Rating: View {
    let car: Car
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...car.rating, id: \.self) { rate in
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundStyle(Color.GOrange)
            }
        }
    }
}

#Preview {
    Rating(car: Car(consList: [], customerPrice: 50000, make: "Land Rover", marketPrice: 225000, model: "Range Rover", prosList: [], rating: 5, imageName: "", isFeatured: false))
}
