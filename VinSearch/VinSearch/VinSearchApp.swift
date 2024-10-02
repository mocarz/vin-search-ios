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
            Item.self,
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
            ContentView(detailViewForVin: { vin in
                let vinDetails = VinDetailsDto(vin: "JT3HP10VXW7092383", country: "Poland", region: "Europe", wmi: "ABCDEF", vds: "GHJI", vis: "PdO123", year: 2014)
                let viewModel = VinDetailsViewModel(vinDetails: vinDetails)
                return VinDetailsView(viewModel: viewModel)
            })
        }
        .modelContainer(sharedModelContainer)
    }
}
