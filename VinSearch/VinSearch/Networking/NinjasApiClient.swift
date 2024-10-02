//
//  ApiClient.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation
import Combine

class NinjasApiClient: VinApiClientProtocol {
    private let baseURL = URL(string: "https://api.api-ninjas.com/")!

    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func vinLookup(vin: String) -> AnyPublisher<VinDetailsDto, Error> {
        let request = VinLookupRequest(vin: vin, apiKey: apiKey)
        return send(apiRequest: request)
    }

    private func send<T: Codable>(apiRequest: ApiRequestProtocol) -> AnyPublisher<T, Error> {
        let request = apiRequest.request(with: baseURL)
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .mapError({ error in
                return ApiError.transportError(error.localizedDescription)
            })
            .tryMap { [unowned self] data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw ApiError.invalidResponse
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    if (500...599) ~= httpResponse.statusCode {
                        throw ApiError.serverError(httpResponse.statusCode)
                    }

                    if let error = self.decodeError(data: data) {
                        throw ApiError.invalidRequestError(error.error)
                    }

                    throw ApiError.unknownError
                }

                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    private func decodeError(data: Data) -> ErrorDto? {
        do {
            let error = try JSONDecoder().decode(ErrorDto.self, from: data)
            return error
        } catch {
            return nil
        }
    }
}
