//
//  VinMainViewModel.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation
import SwiftData
import SwiftUI

class VinMainViewModel: ObservableObject {
    @Published var items: [VinDetails] = []

    private let vinPersistentStore: VinPersistentStore

    init(vinPersistentStore: VinPersistentStore = VinPersistentStore.shared) {
        self.vinPersistentStore = vinPersistentStore
        fetchItems()
    }

    func removeItem(_ index: Int) {
        vinPersistentStore.removeItem(items[index])
        fetchItems()
    }

    func fetchItems() {
        items = vinPersistentStore.fetchItems()
    }
}
