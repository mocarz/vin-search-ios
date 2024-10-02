//
//  VinLookupRequest.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation

class VinLookupRequest: ApiRequestProtocol {
    let method = RequestMethodType.GET
    var path = "v1/vinlookup"
    var parameters = [String: String]()

    init(vin: String, apiKey: String) {
        parameters["vin"] = vin
        parameters["X-Api-Key"] = apiKey
    }
}
