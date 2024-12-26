import SwiftUI

class AtharListViewModel: ObservableObject {
    @Published var selectedDressColor: String = "#732A48" // Default color
    @Published var availableDressColors: [String] = ["#732A48", "#EED595", "#B4D7F5"]
    @Published var selectedGirlImage: String = "girl" // Default image
    @Published var navigateToCookingView: Bool = false // Flag for navigation

    func selectDressColor(color: String) {
        selectedDressColor = color
        switch color {
        case "#732A48":
            selectedGirlImage = "girl" // First girl image
        case "#EED595":
            selectedGirlImage = "girl2" // Second girl image
        case "#B4D7F5":
            selectedGirlImage = "girl3" // Third girl image
        default:
            selectedGirlImage = "girl" // Default to first girl if color not found
        }
    }
}
