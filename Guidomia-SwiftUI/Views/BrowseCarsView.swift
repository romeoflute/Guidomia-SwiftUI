//
//  BrowseCarsView.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

struct BrowseCarsView: View {
    @StateObject var viewModel = BrowseCarsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                list(of: viewModel.listCars)
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .task {
                await fetchData()
            }
            .toolbar(.visible)
            .navigationBarItems(
                leading:
                    Text("GUIDOMIA")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                    .accessibilityLabel("appName")
                ,
                trailing:
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .imageScale(.large)
                            .foregroundStyle(.white)
                    }
            )
            .navigationBarBackground()
        }
    }
    
    func fetchData() async {
        do {
            await viewModel.fetchData()
        }
    }
    
    func list(of cars: [Car]) -> some View {
        List {
            ImageCarouselView(featuredCars: viewModel.featuredCars)
                .edgesIgnoringSafeArea(.horizontal)
                .frame(maxWidth: .infinity)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            CarFilterView(viewModel: viewModel)
            
            ForEach(viewModel.filterListedCars(), id: \.id) { car in
                CarView(viewModel: viewModel, car: car)
                    .accessibilityIdentifier("\(car.model)")
            }
        }
        .listStyle(.plain)
        .frame( maxWidth: .infinity)
        .edgesIgnoringSafeArea(.horizontal)
        .background(.white)
    }
}

#Preview {
    BrowseCarsView()
}
