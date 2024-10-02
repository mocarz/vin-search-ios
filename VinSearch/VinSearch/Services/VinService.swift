//
//  VinService.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation
import Combine

class VinService {
    let apiClient: VinApiClientProtocol

    init(apiClient: VinApiClientProtocol = NinjasApiClient(apiKey: NINJAS_API_KEY)) {
        self.apiClient = apiClient
    }

    func searchVin(vin: String) -> AnyPublisher<VinDetailsDto, Error> {
        return apiClient.vinLookup(vin: vin)
    }
}
