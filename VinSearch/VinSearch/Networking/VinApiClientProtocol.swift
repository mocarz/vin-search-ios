//
//  ApiClientProtocol.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation
import Combine

protocol VinApiClientProtocol {
    func vinLookup(vin: String) -> AnyPublisher<VinDetailsDto, Error>
}
