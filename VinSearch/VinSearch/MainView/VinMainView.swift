//
//  ContentView.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var searchText = ""
    @State private var showingSheet = false
    
    var detailViewForVin: ((_ vin: String) -> VinDetailsView)
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    TextField("Enter VIN", text: $searchText)
                    Button("Search") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet, content: {
                        self.detailViewForVin(searchText)
                    })
                }
            }
            .navigationBarTitle(Text("VIN Search"))
        }
        
    }
}

#Preview {
    ContentView(detailViewForVin: { vin in
        let vinDetails = VinDetailsDto(vin: "JT3HP10VXW7092383", country: "Poland", region: "Europe", wmi: "ABCDEF", vds: "GHJI", vis: "PdO123", year: 2014)
        let viewModel = VinDetailsViewModel(vinDetails: vinDetails)
        return VinDetailsView(viewModel: viewModel)
    })
}
