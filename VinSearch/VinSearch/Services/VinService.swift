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
    let vinPersistentStore: VinPersistentStore

    init(
        apiClient: VinApiClientProtocol = NinjasApiClient(apiKey: NINJAS_API_KEY, throughputStrategy: THROUGHPUT_STRATEGY),
        vinPersistentStore: VinPersistentStore = VinPersistentStore.shared) {
        self.apiClient = apiClient
        self.vinPersistentStore = vinPersistentStore
    }

    func searchVin(vin: String) -> AnyPublisher<VinDetailsDto, Error> {
        return apiClient.vinLookup(vin: vin)
    }

    func appendVinDetailsToStore(item: VinDetails) {
        vinPersistentStore.appendItem(item: item)
    }

    func fetchVinDetailsFromStore() -> [VinDetails] {
        return vinPersistentStore.fetchItems()
    }
}
