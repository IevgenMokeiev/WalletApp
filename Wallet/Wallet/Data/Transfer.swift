//
//  Transfer.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 24.02.2023.
//

import Foundation
import UIKit

enum TransferStatus: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

struct Transfer: Identifiable, Comparable {
    let id = UUID()
    let date: Date
    let amount: Double
    let locale: Locale
    let destination: String
    let icon: UIImage
    let status: TransferStatus

    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short

        return formatter
    }()

    private static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        return formatter
    }()

    var formattedDate: String {
        return Self.dateFormatter.string(from: date)
    }

    var formattedAmount: String {
        let formatter = Self.currencyFormatter
        formatter.locale = locale

        return formatter.string(from: amount as NSNumber) ?? ""
    }

    static func < (lhs: Transfer, rhs: Transfer) -> Bool {
        return lhs.date < rhs.date
    }
}
