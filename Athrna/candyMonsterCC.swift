import SwiftUI
import UIKit  // Import UIKit for using CAEmitterLayer

// ConfettiView: A SwiftUI wrapper for UIKit's CAEmitterLayer to show confetti
struct ConfettiView: UIViewControllerRepresentable {
    class ConfettiViewController: UIViewController {
        private var emitterLayer: CAEmitterLayer!

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .clear // Make background clear to focus on confetti
            setupEmitterLayer()
        }

        private func setupEmitterLayer() {
            emitterLayer = CAEmitterLayer()
            // Position the emitter at the top center of the screen
            emitterLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: 0)  // Position at the top-center
            emitterLayer.emitterSize = CGSize(width: view.bounds.size.width, height: 1) // Full width emitter
            emitterLayer.emitterShape = .line
            emitterLayer.renderMode = .additive

            let colors: [UIColor] = [.red, .green, .blue, .yellow, .orange, .purple]
            var cells: [CAEmitterCell] = []

            for color in colors {
                let cell = createConfettiCell(color: color)
                cells.append(cell)
            }

            emitterLayer.emitterCells = cells
            view.layer.addSublayer(emitterLayer)
        }

        private func createConfettiCell(color: UIColor) -> CAEmitterCell {
            let cell = CAEmitterCell()
            cell.birthRate = 250  // Increased for more confetti
            cell.lifetime = 10.0  // Shorter lifetime for faster confetti
            cell.velocity = 300  // Increased for faster falling confetti
            cell.velocityRange = 100  // Allow random variation
            cell.emissionRange = .pi // Emit in a full circle (360 degrees)

            // Smaller, faster confetti
            cell.contents = createConfettiLayer(color: color)
            cell.scale = 0.2  // Smaller confetti size
            cell.scaleRange = 0.1 // Variability in scale
            cell.yAcceleration = 250 // Increased gravity for faster fall
            cell.alphaSpeed = -0.3  // Confetti fades out quickly

            return cell
        }

        private func createConfettiLayer(color: UIColor) -> CGImage? {
            let size = CGSize(width: 25, height: 25) // Smaller confetti size
            UIGraphicsBeginImageContext(size)
            color.setFill()
            let rect = CGRect(origin: .zero, size: size)
            UIRectFill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image?.cgImage
        }

        func startConfetti() {
            emitterLayer.birthRate = 1 // Start emitting confetti
        }

        func stopConfetti() {
            emitterLayer.birthRate = 0 // Stop emitting confetti
        }
    }

    func makeUIViewController(context: Context) -> ConfettiViewController {
        return ConfettiViewController()
    }

    func updateUIViewController(_ uiViewController: ConfettiViewController, context: Context) {
        // Update the view controller if needed
    }
}

// Your main SwiftUI view that uses ConfettiView
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
    @State private var showConfetti: Bool = false // New state variable for confetti
    
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
            
            // ConfettiView (Display the confetti only after game over)
            if showConfetti {
                ConfettiView()
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(2)  // Make sure confetti is above background but below "eidyG"
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
        let basketXRange = basketPosition.x - 750...basketPosition.x + 750
        let basketYRange = basketPosition.y - 750...basketPosition.y + 750
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
