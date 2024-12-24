import SwiftUI

struct candyMonster1: View {
    // State to track the number of taps
    @State private var tapCount = 0
    // State to hold the index of the image
    @State private var imageIndex = 0
    // Array to hold the image names
    let images = ["m1", "m2", "m3", "m4", "m5", "m6"]
    
    // State to hold candy positions
    @State private var fallingCandies: [Candy] = []
    
    // List of candy names (added special candies)
    let candies = ["PUR1", "PUR2", "pink", "blue", "yellow", "candy22", "candy33", "candy44", "candy55", "candy66", "candy77", "candy88", "candy99", "candy100", "candy101", "candy102", "candy103", "candy104"]
    
    // State to track the position of the m6 image
    @State private var m6Position: CGPoint = .zero
    
    // To get the screen height for bottom reference
    @State private var screenHeight: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        ZStack {
            // Background image (BackgroundMon)
            Image("BackgroundMon")  // Make sure the image is in your assets
                .resizable()
                .scaledToFill()  // Fill the screen and crop to cover it
                .edgesIgnoringSafeArea(.all)  // Ensures the background image fills the entire screen
            
            VStack {
                // Text on the second page
                Text("اكسر الوحش وحرر الحلويات هيا!")
                    .font(.system(size: 50, weight: .bold)) // Adjust the font size as needed
                    .multilineTextAlignment(.center) // Center-align the text
                    .foregroundColor(.brown)
                    .padding()

                Spacer() // Pushes the text and image down to the middle

                // Image that changes after every two taps
                Image(images[imageIndex]) // Display the image based on the image index
                    .resizable()
                    .scaledToFit() // Ensures aspect ratio is maintained while scaling
                    .frame(width: 800, height: 800) // Increased image size for m6
                    .onTapGesture {
                        // Increment the tap count
                        tapCount += 1
                        print("Tap Count: \(tapCount)")  // Debugging statement

                        // After 2 taps, change the image
                        if tapCount % 2 == 0 {
                            withAnimation(.easeInOut(duration: 0.5)) { // Apply animation with duration
                                // Increment the image index to change the image
                                imageIndex = (imageIndex + 1) % images.count
                                print("Image Index: \(imageIndex)")  // Debugging statement
                                
                                // If the "m6" image appears, trigger candy fall animation
                                if imageIndex == 5 {
                                    triggerCandyFall()
                                }
                            }
                        }
                    }
                    .padding()
                    .offset(y: -100)  // Adjust this offset to raise the image above the floor
                    // Capture the position of the m6 image for candy fall
                    .background(GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                // Capture the position of the "m6" image
                                m6Position = geometry.frame(in: .global).origin
                            }
                    })

                Spacer() // Pushes everything to the center vertically
            }
            .padding()
            
            // Add falling candies animation if m6 is the current image
            if imageIndex == 5 {
                ForEach(fallingCandies) { candy in
                    CandyView(candy: candy)
                        .position(candy.position)
                        .animation(.linear(duration: candy.duration).repeatForever(autoreverses: false), value: candy.position)
                }
            }
        }
        .navigationBarHidden(true)  // Hides the navigation bar on this page
        .navigationBarBackButtonHidden(true) // Hides the back button
    }
    
    // Function to trigger candy fall animation
    func triggerCandyFall() {
        // Create new falling candy objects with positions relative to the "m6" image
        var newCandies: [Candy] = []
        
        // The width of the "m6" image
        let imageWidth: CGFloat = 800  // Increased width for larger m6 image
        
        // Allow the candies to spread from the center of the "m6" image
        let spreadRange: CGFloat = 50 // Reduced spread range to bring candies closer together
        let leftOffset: CGFloat = -10   // Adjust this value to move candies slightly to the left
        
        for candyName in candies {
            // Randomize the horizontal position within the spread range, starting from the center of the m6 image
            let randomX = m6Position.x + imageWidth / 2 + CGFloat.random(in: -spreadRange...spreadRange) - leftOffset // Add left offset to shift candies left
            
            // Randomize the vertical start position slightly below the "m6" image
            let randomY = CGFloat.random(in: m6Position.y + 200...m6Position.y + 400)
            
            // Faster fall animation: reduce the duration for quicker animation
            let randomDuration = Double.random(in: 1.5...2.5) // Reduced duration for a faster fall
            
            // Create candy
            let candy = Candy(name: candyName, position: CGPoint(x: randomX, y: randomY), duration: randomDuration)
            newCandies.append(candy)
        }
        
        // Assign the candies to state for animation
        fallingCandies = newCandies
        
        // Start the candy fall animation by updating their positions
        for i in 0..<fallingCandies.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.1) {
                // Ensure the candies fall all the way to the bottom of the screen (screenHeight)
                fallingCandies[i].position = CGPoint(x: fallingCandies[i].position.x, y: screenHeight - 50) // Set bottom position with some padding
            }
        }
    }
}

// Candy data model
struct Candy: Identifiable {
    var id = UUID()
    var name: String
    var position: CGPoint
    var duration: Double
}

// Candy view that represents each candy
struct CandyView: View {
    var candy: Candy
    
    var body: some View {
        // Set the width and height based on candy name
        Image(candy.name)
            .resizable()
            .scaledToFit()
            .frame(
                width: candy.name == "pink" || candy.name == "blue" || candy.name == "yellow" ? 700 :  // Old candies keep their size at 700
                    (candy.name == "candy22" || candy.name == "candy33" || candy.name == "candy44" || candy.name == "candy55" || candy.name == "candy66" || candy.name == "candy77" || candy.name == "candy88" || candy.name == "candy99" || candy.name == "candy100" || candy.name == "candy101" || candy.name == "candy102" || candy.name == "candy103" || candy.name == "candy104" ? 900 : 300),  // New candies get a size of 900
                
                height: candy.name == "pink" || candy.name == "blue" || candy.name == "yellow" ? 700 :  // Old candies keep their size at 700
                    (candy.name == "candy22" || candy.name == "candy33" || candy.name == "candy44" || candy.name == "candy55" || candy.name == "candy66" || candy.name == "candy77" || candy.name == "candy88" || candy.name == "candy99" || candy.name == "candy100" || candy.name == "candy101" || candy.name == "candy102" || candy.name == "candy103" || candy.name == "candy104" ? 900 : 300)  // New candies get a size of 900
            )
    }
}

struct CandyMonster1_Previews: PreviewProvider {
    static var previews: some View {
        candyMonster1()
            .previewDevice("iPad (13th generation)") // Preview for iPad 10
    }
}
