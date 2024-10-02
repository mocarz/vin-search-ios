//
//  VinDetailsViewModel.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation

class VinDetailsViewModel: ObservableObject {
    @Published private(set) var vinDetails: VinDetailsDto
    
    init(vinDetails: VinDetailsDto){
        self.vinDetails = vinDetails
    }
}
