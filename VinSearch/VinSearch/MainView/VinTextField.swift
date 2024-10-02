//
//  VinTextField.swift
//  VinSearch
//
//  Created by Michal Mocarski on 02/10/2024.
//

import Foundation
import SwiftUI
import Combine

struct VinTextField: View {

    private let label: String
    @Binding private var field: String
    @Binding private var isValid: Bool

    init(_ label: String, field: Binding<String>, isValid: Binding<Bool>) {
        self.label = label
        self._field = field
        self._isValid = isValid
    }

    var body: some View {
        TextField(label, text: $field)
            .keyboardType(.asciiCapable)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.characters)
            .onReceive(Just(field)) { newValue in
                let corrected = autoCorrect(text: newValue)
                if corrected != newValue {
                    self.field = corrected

                }

                self.isValid = isValidVinLength(text: corrected)
            }
    }

    private func autoCorrect(text: String) -> String {
        let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        return text.filter { allowedCharacters.contains($0) }
    }

    private func isValidVinLength(text: String) -> Bool {
        return text.count == 17
    }
}
