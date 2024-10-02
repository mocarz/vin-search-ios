//
//  VinDetailsView.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation
import SwiftUI

struct VinDetailsView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: VinDetailsViewModel

    init(viewModel: VinDetailsViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                if let vinDetails = viewModel.vinDetails {
                    HStack {
                        Text("VIN")
                        Spacer()
                        Text(vinDetails.vin)
                    }
                    HStack {
                        Text("Country")
                        Spacer()
                        Text(vinDetails.country)
                    }
                    HStack {
                        Text("Region")
                        Spacer()
                        Text(vinDetails.region)
                    }
                    HStack {
                        Text("WMI")
                        Spacer()
                        Text(vinDetails.wmi)
                    }
                    HStack {
                        Text("VDS")
                        Spacer()
                        Text(vinDetails.vds)
                    }
                    HStack {
                        Text("VIS")
                        Spacer()
                        Text(vinDetails.vis)
                    }
                    HStack {
                        Text("Year")
                        Spacer()
                        Text(String(vinDetails.year))
                    }
                } else {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
            .navigationBarTitle("VIN Details")
        }
    }
}

#Preview {
    let vinDetails = VinDetailsDto(vin: "JT3HP10VXW7092383", country: "Poland", region: "Europe", wmi: "ABCDEF", vds: "GHJI", vis: "PdO123", year: 2014)
    let viewModel = VinDetailsViewModel(vinDetails: vinDetails)
    return VinDetailsView(viewModel: viewModel)
}
