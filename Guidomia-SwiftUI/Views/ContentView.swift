//
//  ContentView.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BrowseCarsViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        do {
            await viewModel.fetchData()
            print("cars in view: \(viewModel.cars.count)")
        }
    }
}

#Preview {
    ContentView()
}
