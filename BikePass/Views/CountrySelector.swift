//
//  CountrySelector.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 24/03/2024.
//

import SwiftUI

struct CountrySelectorView: View {
    @Binding var selectedCountry: String
    @Environment(\.dismiss) var dismiss

    private var recommendedCountry: String? {
        let locale = Locale.current
        guard let countryCode = locale.regionCode,
              let countryName = locale.localizedString(forRegionCode: countryCode) else {
            return nil
        }
        return "\(flag(country: countryCode)) \(countryName)"
    }

    var countries: [String] {
        Locale.isoRegionCodes.compactMap { code -> String? in
            let name = Locale.current.localizedString(forRegionCode: code) ?? "Unknown"
            return "\(flag(country: code)) \(name)"
        }.sorted()
    }


    @State private var searchText = ""

    var filteredCountries: [String] {
        searchText.isEmpty ? countries : countries.filter { $0.lowercased().contains(searchText.lowercased()) }
    }

    var body: some View {
        NavigationView {
            List {
                if let recommended = recommendedCountry {
                    Section(header: Text("Suggested")) {
                        Button(action: {
                            self.selectedCountry = recommended
                            dismiss()
                        }) {
                            Text(recommended)
                        }
                    }
                }

                Section(header: Text("All Countries")) {
                    ForEach(filteredCountries, id: \.self) { country in
                        Button(action: {
                            self.selectedCountry = country
                            dismiss()
                        }) {
                            Text(country)
                        }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Select Country")
        }
    }

    func flag(country: String) -> String {
        let base: UInt32 = 127397
        var s = ""
        for v in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
    }
}

// Preview Provider
struct CountrySelectorView_Previews: PreviewProvider {
    @State static var selectedCountry = "🇺🇸 United States"

    static var previews: some View {
        CountrySelectorView(selectedCountry: $selectedCountry)
    }
}


