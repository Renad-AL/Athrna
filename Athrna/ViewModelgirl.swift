//
//  ViewModelgirl.swift
//  Athrna
//
//  Created by Linah on 30/06/1446 AH.
//

import SwiftUI

class ViewModelgirl: ObservableObject {
    @Published var selectedGirlImage: String = "girl"
    @Published var availableDressColors: [String] = ["#732A48", "#EED595", "#B4D7F5"]
    @Published var selectedDressColor: String = ""

    func selectDressColor(color: String) {
        selectedDressColor = color
        switch color {
        case "#732A48":
            selectedGirlImage = "girl"
        case "#EED595":
            selectedGirlImage = "girl2"
        case "#B4D7F5":
            selectedGirlImage = "girl3"
        default:
            selectedGirlImage = "girl"
        }
    }
}
