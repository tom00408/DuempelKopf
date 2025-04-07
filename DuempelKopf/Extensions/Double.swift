//
//  Double.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 05.03.25.
//

import Foundation

extension Double{
    func asEuroString() -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "de_DE") // Deutsches Format (€)
            return formatter.string(from: NSNumber(value: self)) ?? "\(self) €"
        }
}
