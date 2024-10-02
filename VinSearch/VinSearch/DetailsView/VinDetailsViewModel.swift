//
//  VinDetailsViewModel.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation
import Combine

class VinDetailsViewModel: ObservableObject {
    @Published private(set) var vinDetails: VinDetailsDto?
    @Published var error: Error?

    private let vinService: VinService
    private var cancellables = Set<AnyCancellable>()

    init(vin: String, vinService: VinService = VinService()) {
        self.vinService = vinService
        search(vin: vin)
    }

    init(vinDetails: VinDetailsDto, vinService: VinService = VinService()) {
        self.vinDetails = vinDetails
        self.vinService = vinService
    }

    private func search(vin: String) {
        vinService.searchVin(vin: vin)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .failure(let error):
                    if let error = error as? ApiError {
                        self.error = error
                    } else {
                        self.error = ApiError.unknownError
                    }
                    print("Error \(error)")
                case .finished: print("Publisher is finished")
                }
            }, receiveValue: { [unowned self] data in
                self.vinDetails = data
            }).store(in: &cancellables)
    }
}
