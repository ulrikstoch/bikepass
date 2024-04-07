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

    var countries: [(emoji: String, code: String, name: String)] {
            Locale.isoRegionCodes.compactMap { code -> (String, String, String)? in
                guard let name = Locale.current.localizedString(forRegionCode: code) else {
                    return nil
                }
                let flag = flag(country: code)
                return (flag, code, name)
            }.sorted(by: { $0.name < $1.name })
        }


    @State private var searchText = ""

    var filteredCountries: [(emoji: String, code: String, name: String)] {
        searchText.isEmpty ? countries : countries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
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
                    ForEach(filteredCountries, id: \.code) { country in
                        Button(action: {
                            // Constructing the string in "Emoji CountryCode CountryName" format
                            self.selectedCountry = "\(country.emoji) \(country.code) \(country.name)"
                            dismiss()
                        }) {
                            HStack {
                                Text(country.emoji)
                                Text(country.name)
                            }
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


