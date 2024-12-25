//
//   AtharListViewModel.swift
//  Athrna
//
//  Created by Linah on 23/06/1446 AH.
//
import SwiftUI

class AtharListViewModel: ObservableObject {
    @Published var selectedDressColor: String = "#732A48" // اللون الأول
    @Published var availableDressColors: [String] = ["#732A48", "#EED595", "#B4D7F5"] // قائمة الألوان
    @Published var selectedGirlImage: String = "girl" // الصورة الافتراضية

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
