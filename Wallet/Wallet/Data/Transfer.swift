//
//  Transfer.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 24.02.2023.
//

import Foundation
import UIKit

struct Transfer: Identifiable {

    let id = UUID()
    let date: Date
    let amount: Double
    let locale: Locale
    let destination: String
    let icon: UIImage

    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY/MM/dd"

        return formatter
    }()

    var formattedDate: String {
        return Self.dateFormatter.string(from: date)
    }
}
