//
//  CarView.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

struct CarView: View {
    @ObservedObject var viewModel: BrowseCarsViewModel
    let car: Car
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: Layout.standard) {
                if let selectedCar = viewModel.selectedCar,  selectedCar.id == car.id {
                    ExpandedCarView(car: car)
                } else {
                    CompactCarView(car: car)
                        .onTapGesture {
                            viewModel.selectedCar = car
                        }
                }
                
                Divider()
                    .frame(height: 4)
                    .background(Color.GOrange)
                    .padding(.bottom, Layout.standard)
                    .padding(.horizontal, Layout.standard)
            }
            .frame(maxWidth: .infinity)
        }
        .edgesIgnoringSafeArea(.horizontal)
        .frame(maxWidth: .infinity)
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(.white)
    }
}

#Preview {
    CarView(viewModel: BrowseCarsViewModel(), car: Car(consList: [], customerPrice: 50000, make: "Land Rover", marketPrice: 225000, model: "Range Rover", prosList: [], rating: 5, imageName: "", isFeatured: false))
}
