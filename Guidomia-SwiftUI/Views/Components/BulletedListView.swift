//
//  BulletedListView.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

struct BulletedListView: View {
    let title: String
    let strings: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color(.systemGray))
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(strings, id: \.self) { string in
                if string.count > 0 {
                    HStack(spacing: 0) {
                        Text("\u{2022} ")
                            .font(.title)
                            .foregroundStyle(Color.GOrange)
                        Text(string)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray5))
    }
}

#Preview {
    BulletedListView(title: "Pros", strings: ["You can climb the Himalayas"])
}
