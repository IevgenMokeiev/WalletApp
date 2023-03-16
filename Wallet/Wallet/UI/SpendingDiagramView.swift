//
//  SpendingDiagramView.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 16.03.2023.
//

import SwiftUI

struct SpendingDiagramView: View {

    @ObservedObject var user: User

    init(user: User) {
        self.user = user
    }

    var body: some View {
        HStack {
            ForEach(user.categoryGroups.sorted(by: { $0.totalAmount > $1.totalAmount }), id: \.date) { group in
                Rectangle()
                    .fill(Color(hue: .random(in: 0...1), saturation: .random(in: 0...1), brightness: .random(in: 0...1)))
                    .frame(width: group.totalAmount, height: 40)
            }
        }
    }
}
