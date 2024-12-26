import SwiftUI
import UIKit

struct CandyMonsterCC: View {
    let allCandies = [
        "pink", "blue", "yellow", "candy22", "candy33", "candy44",
        "candy55", "candy66", "candy77", "candy88", "candy99", "candy100", "candy101",
        "candy102", "candy103", "candy104"
    ]
    
    @State private var basketPosition: CGPoint = .zero
    @State private var currentCandy: CCCandy? = nil
    @State private var candiesInBasket: [CCCandy] = []
    @State private var remainingCandies: Int = 5
    @State private var screenHeight: CGFloat = UIScreen.main.bounds.height
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var gameOver: Bool = false
    @State private var eidyGScale: CGFloat = 0.1
    @State private var eidyGOpacity: Double = 0.0
    @State private var showConfetti: Bool = false // Trigger confetti when game over
    
    var body: some View {
        ZStack {
            // Background Image (on the bottom layer)
            Image("BackgroundMon")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Display the countdown label at the top
                Text("هيا جمعي عيديتك: \(remainingCandies)")
                    .font(.system(size: 50, weight: .bold))
                    .padding()
                    .foregroundColor(.brown)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                if let currentCandy = currentCandy {
                    CCCandyView(candyName: currentCandy.name)
                        .frame(width: 700, height: 700)
                        .aspectRatio(contentMode: .fit)
                        .position(currentCandy.position)
                        .zIndex(2)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    updateCandyPosition(newPosition: value.location)
                                }
                                .onEnded { value in
                                    if isCandyInBasket(dropLocation: value.location) {
                                        addCandyToBasket(dropLocation: value.location)
                                    } else {
                                        updateCandyPosition(newPosition: value.location)
                                    }
                                }
                        )
                }
                
                Spacer(minLength: 50)
            }

            // Display candies in basket
            ForEach(candiesInBasket) { candy in
                CCCandyView(candyName: candy.name)
                    .frame(width: 1300, height: 1300)
                    .aspectRatio(contentMode: .fit)
                    .position(candy.position)
            }

            // Basket Image
            Image("BasketB")
                .resizable()
                .scaledToFit()
                .frame(width: 800, height: 800)
                .position(basketPosition)
                .onAppear {
                    basketPosition = CGPoint(x: screenWidth / 2, y: screenHeight - 200)
                }

            // Show "eidyGG" image with animation when the game is over
            if gameOver {
                ZStack {
                    Color.black.opacity(0.6)
                        .edgesIgnoringSafeArea(.all)
                    
                    Image("eidyGG")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 2500, height: 2500)  // Adjust size as needed
                        .scaleEffect(eidyGScale)
                        .opacity(eidyGOpacity)
                        .onAppear {
                            withAnimation(.easeOut(duration: 0.5)) {
                                eidyGScale = 1.0
                                eidyGOpacity = 1.0
                            }
                        }
                        .position(x: screenWidth / 2 - 100, y: screenHeight / 2)  // Shifted a bit to the left
                        .zIndex(1)
                }
            }
            
            // Show the confetti when game is over
            if showConfetti {
                GameConfettiView()
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(2)  // Ensure the confetti is above everything
            }
        }
        .onAppear {
            startNewCandy()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .disabled(gameOver)
        .onChange(of: remainingCandies) { newValue in
            if newValue == 0 {
                gameOver = true
                withAnimation(.easeOut(duration: 0.5)) {
                    showConfetti = true  // Trigger confetti only when the game is over
                }
            }
        }
    }
    
    // Candy logic goes here
    func startNewCandy() {
        if remainingCandies > 0 {
            let randomCandy = allCandies.randomElement() ?? "pink"
            remainingCandies -= 1
            let candyX = screenWidth / 2
            let candyY = screenHeight - 1300 / 2 - 300
            currentCandy = CCCandy(name: randomCandy, position: CGPoint(x: candyX, y: candyY))
        }
    }

    func updateCandyPosition(newPosition: CGPoint) {
        guard var currentCandy = currentCandy else { return }
        let updatedX = max(min(newPosition.x, screenWidth - 650), 650)
        let updatedY = max(min(newPosition.y, screenHeight - 650), 650)
        self.currentCandy?.position = CGPoint(x: updatedX, y: updatedY)
    }

    func isCandyInBasket(dropLocation: CGPoint) -> Bool {
        let basketXRange = basketPosition.x - 500...basketPosition.x + 500
        let basketYRange = basketPosition.y - 400...basketPosition.y + 400
        return basketXRange.contains(dropLocation.x) && basketYRange.contains(dropLocation.y)
    }

    func addCandyToBasket(dropLocation: CGPoint) {
        guard let currentCandy = currentCandy else { return }
        let candyPosition = CGPoint(x: basketPosition.x - 650, y: basketPosition.y - 650 - 150)
        candiesInBasket.append(CCCandy(name: currentCandy.name, position: candyPosition))
        if remainingCandies > 0 {
            startNewCandy() // Start a new candy after one is added to the basket
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
            .aspectRatio(contentMode: .fit)
    }
}

// Preview
struct CandyMonsterCC_Previews: PreviewProvider {
    static var previews: some View {
        CandyMonsterCC()
            .previewDevice("iPad (13th generation)")
    }
}
