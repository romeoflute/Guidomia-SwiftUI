//
//  ContentView.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

struct ContentView: View {
    @State var cars: [Car] = []
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
            let cars = try await OrchestrateDataService().loadCars()
            print("cars in view: \(cars)")
        } catch {
            print("error in view: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
