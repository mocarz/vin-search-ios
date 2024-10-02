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
                    Row(label: "VIN", value: vinDetails.vin)
                    Row(label: "Country", value: vinDetails.country)
                    Row(label: "Region", value: vinDetails.region)
                    Row(label: "WMI", value: vinDetails.wmi)
                    Row(label: "VDS", value: vinDetails.vds)
                    Row(label: "VIS", value: vinDetails.vis)
                    Row(label: "Year", value: String(vinDetails.year))
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
            .errorAlert(error: $viewModel.error)
        }
    }
}

private struct Row: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
    }
}

#Preview {
    let vinDetails = VinDetailsDto(vin: "JT3HP10VXW7092383", country: "Poland", region: "Europe", wmi: "ABCDEF", vds: "GHJI", vis: "PdO123", year: 2014)
    let viewModel = VinDetailsViewModel(vinDetails: vinDetails)
    return VinDetailsView(viewModel: viewModel)
}
