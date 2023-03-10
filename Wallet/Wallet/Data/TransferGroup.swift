//
//  TransferGroup.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 10.03.2023.
//

import Foundation

struct TransferGroup: Comparable {
    let date: Date
    let transfers: [Transfer]

    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY/MM/dd"

        return formatter
    }()

    var formattedDate: String {
        return Self.dateFormatter.string(from: date)
    }

    static func < (lhs: TransferGroup, rhs: TransferGroup) -> Bool {
        return lhs.date < rhs.date
    }
}
