//
//  VinSearchApp.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import SwiftUI
import SwiftData

@main
struct VinSearchApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            VinDetails.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            VinMainView(detailViewForVin: { vin in
                let viewModel = VinDetailsViewModel(vin: vin)
                return VinDetailsView(viewModel: viewModel)
            }, detailViewForVinDetails: { vinDetails in
                let viewModel = VinDetailsViewModel(vinDetails: vinDetails)
                return VinDetailsView(viewModel: viewModel)
            })
        }
        .modelContainer(sharedModelContainer)
    }
}
