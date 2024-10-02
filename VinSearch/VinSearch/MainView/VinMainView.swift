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
        let viewModel = VinDetailsViewModel(vin: vin)
        return VinDetailsView(viewModel: viewModel)
    })
}
