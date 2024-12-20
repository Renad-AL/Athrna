import SwiftUI

struct ContentView: View {
    @AppStorage("selectedCharacter") private var selectedCharacter: String = "None"
    
    var body: some View {
        ZStack {
            // Background color
            Color(red: 1.0, green: 0.97, blue: 0.90)
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Background with lights
                Image("light")
                    .resizable()
                    .scaledToFill() // Use scaled to fill to avoid empty spaces
                    .frame(height: 500) // Larger height for iPad
                    .frame(width: 1500)
                    .clipped() // Clip the overflowing parts to make it fit
                    .padding(.top, -100) // Position lights at the top

                // Title
                Text("أهلًا بمحاربينا")
                    .font(.system(size: 60, weight: .bold)) // Larger font size
                    .foregroundColor(.brown)
                    .padding(.top, 30)

                Spacer()

                // Characters (Boy & Girl) horizontally aligned
                HStack(spacing: 100) { // Increased spacing
                    VStack(spacing: 10) {
                        Button(action: {
                            selectedCharacter = "Girl" // Save selection
                        }) {
                            Image("girl")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350, height: 450) // Larger size for the girl image
                        }
                        // Text Box for Girl Name
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.pink.opacity(0.8)) // Corrected opacity usage
                            .frame(width: 150, height: 60) // Set size for the box
                            .overlay(
                                Text("سارة")
                                    .font(.title)
                                    .foregroundColor(.white)
                            )
                    }

                    VStack(spacing: 10) {
                        Button(action: {
                            selectedCharacter = "Boy" // Save selection
                        }) {
                            Image("boy")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350, height: 450) // Larger size for the boy image
                        }
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.purple.opacity(0.8)) // Corrected opacity usage
                            .frame(width: 150, height: 60) // Set size for the box
                            .overlay(
                                Text("سعد")
                                    .font(.title)
                                    .foregroundColor(.white)
                            )
                    }
                }
                .padding(.bottom, 100) // Increased padding at the bottom

                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
