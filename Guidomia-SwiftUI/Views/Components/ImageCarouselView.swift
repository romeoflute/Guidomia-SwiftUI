//
//  ImageCarouselView.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

struct ImageCarouselView: View {
    var featuredCars: [Car]
    
    var body: some View {
        
        TabView {
            ForEach(featuredCars, id: \.id) { car in
                ZStack(alignment: .bottomLeading) {
                    Image(car.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    VStack(alignment: .leading) {
                        Text(car.model)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                        Text("Get yours now!")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.leading, Layout.highStandard)
                    .padding(.bottom, Layout.highStandard)
                }
            }
            .edgesIgnoringSafeArea(.horizontal)
            .frame(maxWidth: .infinity)
            .background(.blue)
        }
        .frame(height: 280)
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.horizontal)
    }
}

#Preview {
    ImageCarouselView(featuredCars: [Car(consList: [], customerPrice: 50000, make: "Land Rover", marketPrice: 225000, model: "Range Rover", prosList: [], rating: 5, imageName: "RangeRover", isFeatured: false)])
}
