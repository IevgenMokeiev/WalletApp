//
//  User.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 24.02.2023.
//

import Foundation
import UIKit
import Combine

class User: ObservableObject {
    static let shared = User()

    @Published var transfers: [Transfer] = []

    private let dataProvider = DataProvider()
    private var currentMonth = 12
    private var cancellables = Set<AnyCancellable>()

    var formattedCurrentMonth: String {
        let date = Date.dateFromMonth(month: currentMonth)
        return Self.dateFormatter.string(from: date)
    }

    var dateGroups: [TransferGroup] {
        let duplicatesMap = Dictionary(grouping: transfers, by: { $0.date.get(.day) } )
        return duplicatesMap.map {
            TransferGroup(transfers: $1)
        }
    }

    var categoryGroups: [TransferGroup] {
        let duplicatesMap = Dictionary(grouping: transfers, by: { $0.destination } )
        return duplicatesMap.map {
            TransferGroup(transfers: $1)
        }
    }

    var formattedTotalAmount: String {
        let formatter = Self.currencyFormatter
        formatter.locale = Locale.autoupdatingCurrent
        let totalAmount = transfers.reduce(into: 0.0) { $0 = $0 + $1.amount }

        return formatter.string(from: totalAmount as NSNumber) ?? ""
    }

    func populateTransfers() {
        dataProvider
            .transfersPublisher
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink { transferDTOs in
                self.transfers = transferDTOs.map { self.mapTransferTDO($0) }
            }
            .store(in: &cancellables)
    }

    // MARK: - Private

    private static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        return formatter
    }()

    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }()

    private func mapTransferTDO(_ dto: TransferDTO) -> Transfer {
        return Transfer(
            date: Date.randomDate(month: currentMonth, dayRange: 22..<25),
            amount: Double(dto.price) ?? 0.0,
            locale: .current,
            destination: dto.destination,
            icon: [
                UIImage(systemName: "bag")!,
                UIImage(systemName: "transmission")!,
                UIImage(systemName: "house")!,
                UIImage(systemName: "car")!
            ].randomElement()!,
            status: TransferStatus.allCases.randomElement()!
        )
    }
}
