import SwiftUI

class AtharListViewModel: ObservableObject {
    @Published var selectedCharacter: String
    @Published var selectedDressColor: String = "#732A48"
    @Published var availableDressColors: [String] = ["#732A48", "#EED595", "#B4D7F5"]
    @Published var selectedCharacterImage: String = ""

    init(selectedCharacter: String) {
        self.selectedCharacter = selectedCharacter
        // تحديد صورة الشخصية بناءً على الاختيار
        if selectedCharacter == "Girl" {
            selectedCharacterImage = "girl"
        } else if selectedCharacter == "Boy" {
            selectedCharacterImage = "boy"
        }
    }

    func selectDressColor(color: String) {
        selectedDressColor = color
        // هنا يمكنك إضافة منطق لتغيير الصورة حسب اللون المختار
    }
}

