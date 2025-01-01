//
//  ViewModelboy.swift
//  Athrna
//
//  Created by Linah on 30/06/1446 AH.
//
import SwiftUI

class ViewModelboy: ObservableObject {
    @Published var selectedDressColor: String = "#DEE9F0"
    @Published var availableDressColors: [String] = ["#DEE9F0", "#0C1455", "#383839"]
    @Published var selectedBoyImage: String = "boy"

    func selectDressColor(color: String) {
        selectedDressColor = color
        switch color {
        case "#DEE9F0":
            selectedBoyImage = "boy"
        case "#0C1455":
            selectedBoyImage = "boy2"
        case "#383839":
            selectedBoyImage = "boy3"
        default:
            selectedBoyImage = "boy"
        }
    }
}

