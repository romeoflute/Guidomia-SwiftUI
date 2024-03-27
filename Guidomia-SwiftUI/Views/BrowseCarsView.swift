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
            HStack(alignment: .center, spacing: 16) {
                Image(car.imageName)
            }
        }
    }
}

#Preview {
    BrowseCarsView()
}
