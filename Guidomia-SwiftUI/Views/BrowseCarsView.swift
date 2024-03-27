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
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: Layout.standard) {
                    Text("Filters")
                        .foregroundStyle(Color.white)
                    TextField("Any make", text: $viewModel.makeFilter)
                        .autocorrectionDisabled()
                        .font(.footnote)
                        .frame(maxWidth: .infinity)
                        .textFieldStyle(.roundedBorder)
                    TextField("Any model", text: $viewModel.modelFilter)
                        .autocorrectionDisabled()
                        .font(.footnote)
                        .frame(maxWidth: .infinity)
                        .textFieldStyle(.roundedBorder)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.all, Layout.standard)
                .background(Color.GDarkGray)
            }
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .background(.white)
            
            ForEach(viewModel.filterListedCars(), id: \.id) { car in
                CarView(viewModel: viewModel, car: car)
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
