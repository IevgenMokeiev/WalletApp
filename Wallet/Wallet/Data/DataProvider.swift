//
//  DataProvider.swift
//  Wallet
//
//  Created by Yevhen Mokeiev on 24.02.2023.
//

import Foundation
import Combine

class DataProvider {

    var transfersPublisher: AnyPublisher<[TransferDTO], Error> {
        let url = URL(string: "https://random-data-api.com/api/commerce/random_commerce?size=30")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [TransferDTO].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
