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
            .navigationTitle("Guidomia")
            .task {
                await fetchData()
            }
        }
    }
    
    func fetchData() async {
        do {
            await viewModel.fetchData()
        }
    }
    
    func list(of cars: [Car]) -> some View {
        List(cars) { car in
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
                        .frame(height: 2)
                        .background(Color(.systemOrange))
                        .padding(.bottom, Layout.standard)
                        .padding(.horizontal, Layout.standard)
                }
                .frame(maxWidth: .infinity)
            }
            .edgesIgnoringSafeArea(.horizontal)
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea(.horizontal)
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .frame( maxWidth: .infinity)
        .edgesIgnoringSafeArea(.horizontal)
    }
}

#Preview {
    BrowseCarsView()
}
