//
//  TransferCell.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 24.02.2023.
//

import SwiftUI

struct TransferCell: View {

    let transfer: Transfer

    init(transfer: Transfer) {
        self.transfer = transfer
    }

    var body: some View {
        HStack {
            Image(uiImage: transfer.icon)
                .aspectRatio(1, contentMode: .fit)
            VStack {
                Text(transfer.destination)
                Text(transfer.formattedDate)
            }
            Spacer()
            Text("\(transfer.amount)")
        }
        .padding()
    }
}
