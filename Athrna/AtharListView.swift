import SwiftUI

// Define the ViewModel class
class AtharListViewModel: ObservableObject {
    // Example data properties
    @Published var selectedDressColor: String = "Red"
    @Published var availableDressColors: [String] = ["Red", "Blue", "Green"]
    
    // Example method to change selected color
    func selectDressColor(color: String) {
        selectedDressColor = color
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

struct AtharListView: View {
    @ObservedObject var viewModel: AtharListViewModel
    
    var body: some View {
        VStack {
            Color(red: 1.0, green: 0.97, blue: 0.90)
                .ignoresSafeArea()
                .overlay(
                    VStack(spacing: 20) {
                        Text("اختاري لون فستان العيد")
                            .font(.custom("DG Enab", size: 24))
                            .foregroundColor(Color(hex: "#732A48"))  // Example color
                            .bold()
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(hex: "#EED595"), lineWidth: 2)
                                    .shadow(color: Color(hex: "#B4D7F5"), radius: 5, x: 0, y: 3)
                            )
                        
                        HStack(spacing: 20) {
                            Image("girl")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 550)
                                .padding(.trailing, 30)
                            
                            Image("PinkDress")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 300)
                                .background(Color(red: 1.0, green: 0.949, blue: 0.847))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth: 3)
                                )
                                .padding(.leading, 30)
                        }
                        
                        VStack(spacing: 10) {
                            ZStack {
                                Color(red: 1.0, green: 0.949, blue: 0.847)
                                    .frame(width: 290, height: 110)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 3)
                                    )
                                
                                HStack(spacing: 10) {
                                    Rectangle()
                                        .fill(Color(hex: "#732A48"))
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                    
                                    Rectangle()
                                        .fill(Color(hex: "#EED595"))
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                    
                                    Rectangle()
                                        .fill(Color(hex: "#B4D7F5"))
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                }
                            }
                            .padding(.leading, 400)
                        }
                        .padding(.top, -140)
                    }
                    .padding()
                )
        }
    }
}

struct AtharListView_Previews: PreviewProvider {
    static var previews: some View {
        AtharListView(viewModel: AtharListViewModel())  // Create a preview with the ViewModel
    }
}
