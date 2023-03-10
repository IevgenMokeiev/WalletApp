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
                self.transfers = transferDTOs.map{ dto in
                    Transfer(
                        date: self.randomDate(dayRange: 22..<25),
                        amount: Double(dto.price) ?? 0.0,
                        locale: .current,
                        destination: dto.destination,
                        icon: UIImage(systemName: "bag")!
                    )
                }
            }
            .store(in: &cancellables)
    }

    func groupTransfers() -> [TransferGroup] {
        var groups = [TransferGroup]()
        let dates = transfers.map { $0.date }

        var uniqueDates = [Date]()
        for date in dates {
            if !uniqueDates.contains(where: { Calendar.current.isDate($0, equalTo: date, toGranularity: .day) }) {
                uniqueDates.append(date)
            }
        }

        uniqueDates.forEach { date in
            let transfers = transfers.filter { Calendar.current.isDate($0.date, equalTo: date, toGranularity: .day)  }
            let group = TransferGroup(date: date, transfers: transfers)
            groups.append(group)
        }
        return groups
    }

    private func randomDate(dayRange: Range<Int>) -> Date {
        let gregorian = Calendar(identifier: .gregorian)
        let now = Date()
        var components = gregorian.dateComponents([.day, .hour, .minute], from: now)

        components.day = Int.random(in: dayRange)
        components.hour = Int.random(in: 0..<24)
        components.minute = Int.random(in: 0..<60)

        return gregorian.date(from: components) ?? Date()
    }
}
