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
        NavigationView{
            List{
                HStack{
                    Text("VIN")
                    Spacer()
                    Text(viewModel.vinDetails.vin)
                }
                HStack{
                    Text("Country")
                    Spacer()
                    Text(viewModel.vinDetails.country)
                }
                HStack{
                    Text("Region")
                    Spacer()
                    Text(viewModel.vinDetails.region)
                }
                HStack{
                    Text("WMI")
                    Spacer()
                    Text(viewModel.vinDetails.wmi)
                }
                HStack{
                    Text("VDS")
                    Spacer()
                    Text(viewModel.vinDetails.vds)
                }
                HStack{
                    Text("VIS")
                    Spacer()
                    Text(viewModel.vinDetails.vis)
                }
                HStack{
                    Text("Year")
                    Spacer()
                    Text(String(viewModel.vinDetails.year))
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
