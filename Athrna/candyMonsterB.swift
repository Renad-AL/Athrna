import SwiftUI

struct candyMonsterB: View {
    var selectedGirl: String // Receive selected girl image to display it
    @State private var navigateToCandyMonster1 = false // Flag to trigger navigation to CandyMonster1

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.0, green: 0.97, blue: 0.90)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("ساعد سعد يهزم وحش الحلويات!")
                        .font(.system(size: 65, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.brown)
                        .lineLimit(1)
                        .padding(.horizontal, 20)

                    Spacer()

                    // Dynamically change the image based on the selected boy
                    Image(getBoyImage(selectedGirl)) // Using the passed selectedGirl (which is a boy image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 800, height: 850) // Set fixed size for all images
                        .clipped() // Prevent image overflow
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            navigateToCandyMonster1 = true // Trigger navigation on tap
                        }

                    // NavigationLink to CandyMonster1, passing "CandyMonsterB" as context
                    NavigationLink(
                        destination: candyMonster1(sourcePage: "CandyMonsterB"), // Pass the source context
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

    // Helper function to get the correct image based on the selected boy
    func getBoyImage(_ selectedBoy: String) -> String {
        switch selectedBoy {
        case "boy":
            return "bbwhite" // Image for boy
        case "boy2":
            return "bbblue" // Image for boy2
        case "boy3":
            return "bbgray" // Image for boy3
        default:
            return "bbwhite" // Default image
        }
    }
}

struct candyMonsterB_Previews: PreviewProvider {
    static var previews: some View {
        candyMonsterB(selectedGirl: "boy") // Example with "boy" as the selected boy image
    }
}
