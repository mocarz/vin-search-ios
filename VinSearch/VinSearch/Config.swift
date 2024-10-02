//
//  Config.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation

let NINJAS_API_KEY = ""

let THROUGHPUT_STRATEGY = QueueThroughputStrategy(
    rate: UInt(10),
    interval: .seconds(60),
    scheduler: DispatchQueue(label: "com.vinsearch.network1")
)
