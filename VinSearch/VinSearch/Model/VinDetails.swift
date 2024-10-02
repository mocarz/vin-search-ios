//
//  VinDetails.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation
import SwiftData

@Model
class VinDetails {
    @Attribute(.unique)
    var vin: String
    var country: String
    var region: String
    var wmi: String
    var vds: String
    var vis: String
    var year: Int

    init(vin: String, country: String, region: String, wmi: String, vds: String, vis: String, year: Int) {
        self.vin = vin
        self.country = country
        self.region = region
        self.wmi = wmi
        self.vds = vds
        self.vis = vis
        self.year = year
    }
}
