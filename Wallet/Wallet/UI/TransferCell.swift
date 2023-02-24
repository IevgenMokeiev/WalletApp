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
                .resizable()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(transfer.destination)
                Text(transfer.formattedAmount)
            }
            .multilineTextAlignment(.leading)
            Spacer()
            Text("- \(transfer.formattedAmount)")
                .foregroundColor(.red)
                .multilineTextAlignment(.trailing)
        }
    }
}
