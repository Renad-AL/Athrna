import SwiftUI

struct candyMonster1: View {
    // State to track the number of taps
    @State private var tapCount = 0
    // State to hold the index of the image
    @State private var imageIndex = 0
    // State to show candies after the last image is shown
    @State private var showCandies = false
    // Array to hold the image names
    let images = ["m1", "m2", "m3", "m4", "m5", "m6"]
    // Array to hold the candy image names
    let candies = ["PUR1", "BALL7", "PUR2", "BALL3", "BALL4", "BALL2", "BALL1"]
    
    // Function to generate random positions for candies
    func getRandomOffset() -> (x: CGFloat, y: CGFloat) {
        let randomX = CGFloat.random(in: -120...120) // Random horizontal offset
        let randomY = CGFloat.random(in: CGFloat(-150)...CGFloat(-50)) // Limited vertical range with explicit type casting
        return (randomX, randomY)
    }

    var body: some View {
        ZStack {
            // Full-screen background color #FFF7E7
            Color(red: 1.0, green: 0.97, blue: 0.90)
                .edgesIgnoringSafeArea(.all)  // Ensures the background color fills the entire screen

            VStack {
                // Text on the second page
                Text("اكسر الوحش وحرر الحلويات هيا!")
                    .font(.system(size: 50, weight: .bold)) // Adjust the font size as needed
                    .multilineTextAlignment(.center) // Center-align the text
                    .foregroundColor(.brown)
                    .padding()

                Spacer() // Pushes the text and image down to the middle

                // Image that changes after every 2 taps
                Image(images[imageIndex]) // Display the main image based on the image index
                    .resizable() // Make the image resizable
                    .scaledToFit() // Ensures aspect ratio is maintained while scaling
                    .frame(width: 700, height: 700) // Increased image size to make it larger
                    .onTapGesture {
                        // Increment the tap count
                        tapCount += 1
                        
                        // After every 2 taps, change the image
                        if tapCount % 2 == 0 {
                            withAnimation(.easeInOut(duration: 0.5)) { // Apply animation with duration
                                // Increment the image index to change the image
                                imageIndex = (imageIndex + 1) % images.count
                            }
                        }
                        
                        // Once the last image appears (m6), show the candies
                        if imageIndex == images.count - 1 { // Check if last image (m6) is shown
                            withAnimation(.easeIn(duration: 1)) {
                                showCandies = true
                            }
                        }
                    }
                    .padding()

                // Add a Spacer here to push the candies just above the last image
                Spacer(minLength: 10) // Reduced space to make candies appear close to the last image

                // Display candies after the last image
                if showCandies {
                    // Use a ZStack to allow overlapping random positioning of candies
                    ZStack {
                        ForEach(0..<candies.count, id: \.self) { index in
                            // Generate random offset values for a scattered position
                            let randomOffset = getRandomOffset()
                            Image(candies[index]) // Show each candy image
                                .resizable() // Make the candy image resizable
                                .scaledToFit() // Ensure it maintains aspect ratio
                                .frame(width: 150, height: 150) // Increased size for candies
                                .offset(x: randomOffset.x, y: randomOffset.y) // Randomly offset the candy position
                        }
                    }
                    .padding(.top, 10) // Small space above the candies
                }
            }
            .padding()
        }
        .navigationBarHidden(true)  // Hides the navigation bar on this page
        .navigationBarBackButtonHidden(true) // Hides the back button
    }
}

struct candyMonster1_Previews: PreviewProvider {
    static var previews: some View {
        candyMonster1()
            .previewDevice("iPad (13th generation)") // Preview for iPad 10
    }
}
