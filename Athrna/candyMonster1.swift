import SwiftUI
import AVFoundation

struct candyMonster1: View {
    var sourcePage: String // This will hold either "CandyMonsterB" or "CandyMonsterG"
    @State private var navigateToNextPage = false // Flag to trigger navigation
    @State private var tapCount = 0
    @State private var imageIndex = 0
    @State private var fallingCandies: [Candy] = []
    @State private var m6Position: CGPoint = .zero
    @State private var screenHeight: CGFloat = UIScreen.main.bounds.height
    @State private var showCandies = false // Flag to show candies
    @State private var animationFinished = false // Flag to detect when the candy animation finishes
    @State private var audioPlayer: AVAudioPlayer? // Audio player for playing sound
    
    let images = ["m1", "m2", "m3", "m4", "m5", "m6"]
    let candies = ["PUR1", "PUR2", "pink", "blue", "yellow", "candy22", "candy33", "candy44", "candy55", "candy66", "candy77", "candy88", "candy99", "candy100", "candy101", "candy102", "candy103", "candy104"]

    var body: some View {
        NavigationStack {
            ZStack {
                // Background image for the page
                Image("BackgroundMon")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("هيا لنحطم وحش الحلوى")
                        .font(.system(size: 50, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.brown)
                        .padding()

                    Spacer()

                    // Display image that changes based on tap count
                    Image(images[imageIndex])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 800, height: 800)
                        .onTapGesture {
                            tapCount += 1

                            // Change image after every two taps
                            if tapCount % 2 == 0 {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    imageIndex = (imageIndex + 1) % images.count
                                    
                                    // Trigger candy fall animation when imageIndex is 5 (m6)
                                    if imageIndex == 5 {
                                        triggerCandyFall()
                                    }
                                }
                            }
                        }
                        .padding()
                        .offset(y: -100)

                    Spacer()
                }
                .padding()

                // Add falling candies if the imageIndex is 5 (m6 image)
                if imageIndex == 5 && showCandies {
                    ForEach(fallingCandies) { candy in
                        CandyView(candy: candy)
                            .position(candy.position)
                            .animation(.linear(duration: candy.duration).repeatForever(autoreverses: false), value: candy.position)
                    }
                }

                // NavigationLink for transition to the next page (CandyMonsterGG or CandyMonsterCC)
                NavigationLink(
                    destination: destinationView(),
                    isActive: $navigateToNextPage,
                    label: { EmptyView() }
                )
            }
            .navigationBarHidden(true) // Hide navigation bar
            .onAppear {
                playLetsBreakSound() // Play the sound when the view appears
            }
        }
    }
    
    // Function to decide which view to navigate to based on the sourcePage
    func destinationView() -> some View {
        if sourcePage == "CandyMonsterB" {
            return AnyView(candyMonsterGG()) // Navigate to CandyMonsterGG
        } else {
            return AnyView(CandyMonsterCC()) // Navigate to CandyMonsterCC
        }
    }

    // Function to play the letsBreak sound when the view appears
    func playLetsBreakSound() {
        guard let url = Bundle.main.url(forResource: "letsBreak", withExtension: "mp3") else {
            print("Failed to find the sound file.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }

    // Trigger candy fall animation
    func triggerCandyFall() {
        var newCandies: [Candy] = []
        let imageWidth: CGFloat = 800
        let spreadRange: CGFloat = 50
        let leftOffset: CGFloat = -10
        
        // Create falling candies
        for candyName in candies {
            let randomX = m6Position.x + imageWidth / 2 + CGFloat.random(in: -spreadRange...spreadRange) - leftOffset
            let randomY = CGFloat.random(in: m6Position.y + 200...m6Position.y + 400)
            let randomDuration = Double.random(in: 1.5...2.5)

            let candy = Candy(name: candyName, position: CGPoint(x: randomX, y: randomY), duration: randomDuration)
            newCandies.append(candy)
        }
        
        fallingCandies = newCandies
        showCandies = true // Show candies after triggering

        // Start the candy fall animation
        for i in 0..<fallingCandies.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.1) {
                fallingCandies[i].position = CGPoint(x: fallingCandies[i].position.x, y: screenHeight - 50)
            }
        }
        
        // Set a delay that matches the animation to navigate after it ends
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.animationFinished = true
            if self.animationFinished {
                navigateToNextPage = true // Trigger navigation to next view after the animation ends
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

// Candy view to represent each candy
struct CandyView: View {
    var candy: Candy
    
    var body: some View {
        Image(candy.name)
            .resizable()
            .scaledToFit()
            .frame(width: 700, height: 700)
    }
}

// Preview for candyMonster1
struct candyMonster1_Previews: PreviewProvider {
    static var previews: some View {
        candyMonster1(sourcePage: "CandyMonsterB") // Pass the sourcePage in the preview
            .previewDevice("iPad (13th generation)") // Preview for iPad
    }
}
