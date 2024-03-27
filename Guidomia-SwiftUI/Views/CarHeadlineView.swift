//
//  CarHeadlineView.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

struct CarHeadlineView: View {
    let car: Car
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(carTitle())
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(.systemGray))
            Text(displayPrice())
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundStyle(Color(.systemGray))
        }
    }
    
    private func carTitle() -> String {
        let originalTitle = "\(car.make) \(car.model)"
        if originalTitle.count < 20 {
            return originalTitle
        }
        
        let commonWords = Set(car.make.split(separator:" ")).intersection(car.model.split(separator:" "))
        if commonWords.count > 0 {
            return car.model
        }
        
        return car.make
    }
    
    private func displayPrice() -> String {
        return "Price \(String(format: "%.0f", car.customerPrice/1000))k"
    }
}

#Preview {
    CarHeadlineView(car: Car(consList: [], customerPrice: 50000, make: "Land Rover", marketPrice: 225000, model: "Range Rover", prosList: [], rating: 5, imageName: ""))
}
