//
//  User.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 24.02.2023.
//

import Foundation
import UIKit

class User {

    var transfers: [Transfer] = [
        Transfer(date: Date(), amount: 0.56, locale: .current, destination: "Amazon", icon: UIImage(systemName: "bag")!),
        Transfer(date: Date(), amount: 3.52, locale: .current, destination: "Public Transport", icon: UIImage(systemName: "train.side.front.car")!)
    ]

    static let shared = User()
}
