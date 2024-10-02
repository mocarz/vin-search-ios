//
//  Identify.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation

struct Identify<T>: Identifiable {
    var id: Int
    var item: T
}
