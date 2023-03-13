//
//  TransferGroup.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 10.03.2023.
//

import Foundation

struct TransferGroup: Comparable {
    let transfers: [Transfer]

    var date: Date {
        return transfers.first?.date ?? Date()
    }

    var formattedDate: String {
        return Self.dateFormatter.string(from: date)
    }

    static func < (lhs: TransferGroup, rhs: TransferGroup) -> Bool {
        return lhs.date < rhs.date
    }

    // MARK: - Private

    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none

        return formatter
    }()
}
