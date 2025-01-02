import SwiftUI
import AVFoundation

struct CandyMonsterCC: View {
    let allCandies = [
        "bluey", "blueyish", "circle11", "circle12", "graytri", "gummy",
        "orangey", "pinkey", "pinkyish", "pinktri", "rainbowtri", "swirl",
        "yellowish"
    ]
    
    @State private var basketPosition: CGPoint = .zero
    @State private var activeCandies: [CCCandy] = [] // Store all active candies
    @State private var totalCandiesCollected: Int = 0
    @State private var remainingCandies: Int = 5
    @State private var gameOver: Bool = false
    @State private var eidyGScale: CGFloat = 0.1
    @State private var eidyGOpacity: Double = 0.0
    @State private var showConfetti: Bool = false
    @State private var candiesSpawned: Bool = false // Track if candies have been spawned
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height

            ZStack {
                // Background Image (on the bottom layer)
                Image("BackgroundMon")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Display the countdown label at the top
                    Text("هيا اجمعي عيديتك: \(remainingCandies)")
                        .font(.system(size: 50, weight: .bold))
                        .padding()
                        .foregroundColor(.brown)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(GeometryReader { geo in
                            Color.clear.onAppear {
                                // Capture the position of the text label
                                let textHeight = geo.size.height
                                spawnCandiesBelowText(screenWidth: screenWidth, screenHeight: screenHeight, textHeight: textHeight)
                            }
                        })
                    
                    Spacer()
                }

                // Loop through all active candies and display them
                if !gameOver { // Only show candies if the game is not over
                    ForEach(activeCandies) { candy in
                        CCCandyView(candyName: candy.name)
                            .aspectRatio(contentMode: .fit)  // Let the candy use its original size
                            .frame(width: 120, height: 120)  // Reasonably larger candy size (120x120)
                            .position(candy.position)
                            .zIndex(2)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        updateCandyPosition(candy: candy, newPosition: value.location)
                                    }
                                    .onEnded { value in
                                        if isCandyInBasket(dropLocation: value.location) {
                                            addCandyToBasket(candy: candy)
                                        } else {
                                            // If candy is not in the basket, move it back to its original position
                                            updateCandyPosition(candy: candy, newPosition: candy.position)
                                        }
                                    }
                            )
                    }
                }

                // Basket Image (with the new image name "Baskett")
                Image("Baskett") // Change from "BasketB" to "Baskett"
                    .resizable()
                    .scaledToFit()
                    .frame(width: 1200, height: 1200)  // Adjust size as needed
                    .position(x: screenWidth / 2, y: screenHeight - 250)  // Adjust position to fit better
                
                // Show "eidyGG" image with animation when the game is over
                if gameOver {
                    ZStack {
                        // Dark overlay to cover everything
                        Color.black.opacity(0.6)
                            .edgesIgnoringSafeArea(.all)
                        
                        // Full basket or "eidyGG" image
                        Image("eidyGG")  // The final image that should show when the game is over
                            .resizable()
                            .scaledToFit()
                            .frame(width: 2500, height: 2500)
                            .scaleEffect(eidyGScale)
                            .opacity(eidyGOpacity)
                            .onAppear {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    eidyGScale = 1.0
                                    eidyGOpacity = 1.0
                                }
                            }
                            .position(x: screenWidth / 2, y: screenHeight / 2)
                            .zIndex(1)
                    }
                }

                // Show the confetti when the game is over
                if showConfetti {
                    GameConfettiView()
                        .edgesIgnoringSafeArea(.all)
                        .zIndex(2)
                }
            }
            .onAppear {
                basketPosition = CGPoint(x: screenWidth / 2, y: screenHeight - 250)  // Adjust basket's position
                playCollectGirlSound()  // Play the sound when the view appears
            }
            .onChange(of: remainingCandies) { newValue in
                if newValue == 0 {
                    gameOver = true
                    withAnimation(.easeOut(duration: 0.5)) {
                        showConfetti = true  // Trigger confetti when the game is over
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .disabled(gameOver) // Disable interactions when game is over
        }
    }
    
    // Function to generate exactly two candies at a time, right below the text
    func spawnCandiesBelowText(screenWidth: CGFloat, screenHeight: CGFloat, textHeight: CGFloat) {
        // Only spawn if there are candies left to spawn
        if totalCandiesCollected < 5 {
            let numberOfCandies = 2  // Spawn exactly two candies
            
            for _ in 0..<numberOfCandies {
                if totalCandiesCollected < 5 {
                    let randomCandy = allCandies.randomElement() ?? "pinkey"
                    
                    // Spawn candies right below the countdown text
                    var candyX = CGFloat.random(in: 100...screenWidth - 100) // Random X position within the screen
                    var candyY = textHeight + 30 + CGFloat.random(in: 0...100) // Random Y position right below the text
                    
                    // Ensure the candy is within screen bounds
                    candyX = max(min(candyX, screenWidth - 100), 100)
                    candyY = max(min(candyY, screenHeight - 500), textHeight + 30)

                    let newCandy = CCCandy(name: randomCandy, position: CGPoint(x: candyX, y: candyY))
                    activeCandies.append(newCandy) // Add the new candy to the active candies array
                    print("Candy spawned at: \(newCandy.position)") // Debugging candy position
                }
            }
        }
    }
    
    func updateCandyPosition(candy: CCCandy, newPosition: CGPoint) {
        guard let index = activeCandies.firstIndex(where: { $0.id == candy.id }) else { return }
        let updatedX = max(min(newPosition.x, UIScreen.main.bounds.width - 50), 50)  // Bound the movement
        let updatedY = max(min(newPosition.y, UIScreen.main.bounds.height - 50), 50)  // Bound the movement
        activeCandies[index].position = CGPoint(x: updatedX, y: updatedY)
    }

    func isCandyInBasket(dropLocation: CGPoint) -> Bool {
        let basketXRange = basketPosition.x - 500...basketPosition.x + 500
        let basketYRange = basketPosition.y - 400...basketPosition.y + 400
        return basketXRange.contains(dropLocation.x) && basketYRange.contains(dropLocation.y)
    }

    func addCandyToBasket(candy: CCCandy) {
        // Add the candy to the basket (activeCandies -> basket)
        if let index = activeCandies.firstIndex(where: { $0.id == candy.id }) {
            activeCandies.remove(at: index)
            totalCandiesCollected += 1
            remainingCandies -= 1
            if remainingCandies > 0 {
                spawnCandiesBelowText(screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height, textHeight: 100) // Start new candies after one is collected
            }
        }
    }

    // Function to play the collectGirl sound when the view appears
    func playCollectGirlSound() {
        guard let url = Bundle.main.url(forResource: "collectGirl", withExtension: "mp3") else {
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
}

// Data model for candies
struct CCCandy: Identifiable {
    var id = UUID()
    var name: String
    var position: CGPoint
}

// View for each candy
struct CCCandyView: View {
    var candyName: String
    var body: some View {
        Image(candyName)
            .resizable()
            .aspectRatio(contentMode: .fit)  // Let the candy use its original size
    }
}

// Preview
struct CandyMonsterCC_Previews: PreviewProvider {
    static var previews: some View {
        CandyMonsterCC()
            .previewDevice("iPad (13th generation)")
    }
}
