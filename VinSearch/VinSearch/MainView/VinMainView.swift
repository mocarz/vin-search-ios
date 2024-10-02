//
//  ContentView.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import SwiftUI
import SwiftData

struct VinMainView: View {
    @State private var searchText = "JT3HP10VXW7092383"
    @State private var isVinValid = false
    @State private var showingSheet = false
    @StateObject private var viewModel: VinMainViewModel
    @State private var vinToShow: Identify<VinDetails>?

    @FocusState private var focusedField: Field?
    private enum Field: Int, CaseIterable {
        case vin
    }

    var detailViewForVin: ((_ vin: String) -> VinDetailsView)
    var detailViewForVinDetails: ((_ vinDetails: VinDetails) -> VinDetailsView)

    init(
        detailViewForVin: @escaping ((_ vin: String) -> VinDetailsView),
        detailViewForVinDetails: @escaping ((_ vinDetails: VinDetails) -> VinDetailsView),
        viewModel: VinMainViewModel = VinMainViewModel())
    {
        self.detailViewForVin = detailViewForVin
        self.detailViewForVinDetails = detailViewForVinDetails
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            List {
                HStack {
                    VinTextField("Enter VIN", field: $searchText, isValid: $isVinValid)
                        .focused($focusedField, equals: .vin)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button("Done") {
                                    focusedField = nil
                                }
                            }
                        }
                    Button("Search") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet, onDismiss: {
                        viewModel.fetchItems()
                    }, content: {
                        self.detailViewForVin(searchText)
                    })
                    .disabled(!isVinValid)
                }

                if !viewModel.items.isEmpty {
                    Section(header: Text("Recent")) {
                        ForEach(Array(viewModel.items.enumerated()), id: \.element) { index, item in
                            Button(item.vin) {
                                vinToShow = Identify(id: index, item: item)
                            }
                            .foregroundStyle(.primary)

                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .sheet(item: $vinToShow, content: { identify in
                self.detailViewForVinDetails(identify.item)
            })
            .navigationBarTitle(Text("VIN Search"))
        }

    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                viewModel.removeItem(index)
            }
        }
    }
}

#Preview {
    VinMainView(detailViewForVin: { vin in
        let viewModel = VinDetailsViewModel(vin: vin)
        return VinDetailsView(viewModel: viewModel)
    }, detailViewForVinDetails: { vinDetails in
        let viewModel = VinDetailsViewModel(vinDetails: vinDetails)
        return VinDetailsView(viewModel: viewModel)
    })
    
}
