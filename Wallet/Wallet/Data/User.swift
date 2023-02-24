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
            .sink { transferDTOs in
                self.transfers = transferDTOs.map{ dto in
                    Transfer(
                        date: Date(),
                        amount: Double(dto.price) ?? 0.0,
                        locale: .current,
                        destination: dto.destination,
                        icon: UIImage(systemName: "bag")!
                    )
                }
            }
            .store(in: &cancellables)
    }
}
