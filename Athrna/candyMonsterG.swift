import SwiftUI

struct CandyMonsterG: View {
    var selectedGirl: String // Receive selected girl to display image
    @State private var navigateToCandyMonster1 = false // Flag to trigger navigation to CandyMonster1

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.0, green: 0.97, blue: 0.90)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("ساعد سارة تهزم وحش الحلويات!")
                        .font(.system(size: 65, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.brown)
                        .lineLimit(1)
                        .padding(.horizontal, 20)

                    Spacer()

                    // Dynamically change the image based on the selected girl
                    Image(getGirlImage(selectedGirl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 800, height: 850) // Set fixed size for all images
                        .clipped() // Prevent image overflow
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            navigateToCandyMonster1 = true // Trigger navigation on tap
                        }

                    // NavigationLink to CandyMonster1
                    NavigationLink(
                        destination: candyMonster1(),
                        isActive: $navigateToCandyMonster1,
                        label: { EmptyView() }
                    )

                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }

    // Helper function to get the correct image based on the selected girl
    func getGirlImage(_ selectedGirl: String) -> String {
        switch selectedGirl {
        case "girl":
            return "gbr" // For girl, show gbr image
        case "girl2":
            return "gby" // For girl2, show gby image
        case "girl3":
            return "gbb" // For girl3, show gbb image
        default:
            return "gbr" // Default image is gbr
        }
    }
}

struct CandyMonsterG_Previews: PreviewProvider {
    static var previews: some View {
        CandyMonsterG(selectedGirl: "girl") // Example with "girl" as the selected girl
    }
}
