//
//  VinDetailsDto.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation

struct VinDetailsDto: Codable {
    var vin: String
    var country: String
    var region: String
    var wmi: String
    var vds: String
    var vis: String
    var year: Int
}
