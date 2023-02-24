//
//  TransferDTO.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 24.02.2023.
//

import Foundation

struct TransferDTO: Codable {
    var destination: String
    var price: String

    enum CodingKeys: String, CodingKey {
        case destination = "department"
        case price = "price_string"
    }
}
