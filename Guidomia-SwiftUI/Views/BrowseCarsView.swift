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
                list(of: viewModel.cars)
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
            print("cars in view: \(viewModel.cars)")
        }
    }
    
    func list(of cars: [Car]) -> some View {
        List(cars) { car in
            VStack(spacing: 10) {
                VStack(alignment: .leading, spacing: Layout.standard) {
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
                    Divider()
                        .frame(height: 2)
                        .background(Color(.systemOrange))
                        .padding(.bottom, Layout.standard)
                        .padding(.horizontal, Layout.standard)
                }
                
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
