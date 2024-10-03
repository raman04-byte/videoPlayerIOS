//
//  QueryTag.swift
//  VideoPlayer
//
//  Created by Raman Tank on 03/10/24.
//

import SwiftUI

struct QueryTag: View {
    var query: Query
    var isSelected: Bool
    var body: some View {
        Text(query.rawValue)
            .bold()
            .font(.caption)
            .foregroundColor(isSelected ? .black : .white)
            .padding(10)
            .background(.thinMaterial)
            .cornerRadius(10)
        
    }
}

#Preview {
    QueryTag(
        query: Query.food, isSelected: true
    )
}
