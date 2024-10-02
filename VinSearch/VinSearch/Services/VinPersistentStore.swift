//
//  VinPersistentStore.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation

import SwiftData

final class VinPersistentStore {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = VinPersistentStore()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: VinDetails.self)
        self.modelContext = modelContainer.mainContext
    }

    func appendItem(item: VinDetails) {
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchItems() -> [VinDetails] {
        do {
            return try modelContext.fetch(FetchDescriptor<VinDetails>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeItem(_ item: VinDetails) {
        modelContext.delete(item)
        try? modelContext.save()
    }
}
