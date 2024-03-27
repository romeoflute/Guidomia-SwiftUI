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
                Text("Cars")
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
}

#Preview {
    BrowseCarsView()
}
