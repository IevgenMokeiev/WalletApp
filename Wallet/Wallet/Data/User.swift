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
    private var cancellables = Set<AnyCancellable>()

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

    var groupedTransfers: [TransferGroup] {
        let duplicatesMap = Dictionary(grouping: transfers, by: { $0.date.get(.day) } )
        return duplicatesMap.map {
            TransferGroup(transfers: $1)
        }
    }

    // MARK: - Private

    private func mapTransferTDO(_ dto: TransferDTO) -> Transfer {
        return Transfer(
            date: Date.randomDate(dayRange: 22..<25),
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
