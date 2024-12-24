import SwiftUI

struct CandyMonsterCC: View {
    // List of candies
    let candies = [
        "PUR1", "PUR2", "pink", "blue", "yellow", "candy22", "candy33", "candy44",
        "candy55", "candy66", "candy77", "candy88", "candy99", "candy100", "candy101",
        "candy102", "candy103", "candy104"
    ]
    
    // State variables
    @State private var basketPosition: CGPoint = .zero
    @State private var candyPositions: [CCCandy] = []
    @State private var candiesInBasket: [CCCandy] = []
    @State private var countdown: Int = 5  // Starting countdown value
    @State private var screenHeight: CGFloat = UIScreen.main.bounds.height
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    // Track if the candy is being dragged
    @State private var draggedCandy: CCCandy? = nil
    
    var body: some View {
        ZStack {
            // Background Image
            Image("BackgroundMon")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Countdown label at the top
                Text("Candies Left: \(countdown)")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(.brown)
                
                Spacer()
                
                // Basket Image
                Image("BasketB")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .position(basketPosition)
                    .onAppear {
                        // Set basket position to the center of the screen
                        basketPosition = CGPoint(x: screenWidth / 2, y: screenHeight / 2 + 200)
                    }

                Spacer()

                // Candy Grid (5 candies per row)
                VStack {
                    // Iterate through the list of candies, displaying them in rows
                    let rows = candies.chunked(into: 5)
                    ForEach(rows, id: \.self) { row in
                        HStack(spacing: 20) {  // Add spacing between candies
                            ForEach(row, id: \.self) { candyName in
                                CCCandyView(candyName: candyName)
                                    .frame(width: 120, height: 120)  // Increased size of candies
                                    .onTapGesture {
                                        if candiesInBasket.count < 5 {  // Allow only 5 candies to be picked
                                            addCandyToBasket(candyName: candyName)
                                        }
                                    }
                            }
                        }
                        .padding(.vertical, 10)  // Add vertical padding between rows
                    }
                }
                .padding()
                
                Spacer()
            }
            
            // Display candies in the basket (inside basket area)
            ForEach(candiesInBasket) { candy in
                CCCandyView(candyName: candy.name)
                    .position(basketPosition)
            }
        }
        .onAppear {
            placeCandiesOnFloor()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    // Function to place candies randomly on the floor
    func placeCandiesOnFloor() {
        var newCandyPositions: [CCCandy] = []

        // Randomize the horizontal positions for each candy
        for candyName in candies {
            let randomX = CGFloat.random(in: 50...(screenWidth - 120))
            let randomY = screenHeight - 150  // Place candies near the bottom
            
            let candy = CCCandy(name: candyName, position: CGPoint(x: randomX, y: randomY))
            newCandyPositions.append(candy)
        }
        
        // Set the positions of candies on the floor
        candyPositions = newCandyPositions
    }

    // Function to add candy to the basket
    func addCandyToBasket(candyName: String) {
        // Find the candy in the available positions
        if let index = candyPositions.firstIndex(where: { $0.name == candyName }) {
            // Add to the basket and remove from the floor
            let candy = candyPositions.remove(at: index)
            candiesInBasket.append(candy)
            
            // Decrease the countdown
            countdown = max(0, countdown - 1)
            
            // Update candy positions
            if countdown == 0 {
                // Handle case when countdown finishes (e.g., stop adding candies)
                print("Game over, all candies collected!")
            }
        }
    }
}

// CCCandy data model
struct CCCandy: Identifiable {
    var id = UUID()
    var name: String
    var position: CGPoint
}

// View to represent each candy
struct CCCandyView: View {
    var candyName: String
    
    var body: some View {
        Image(candyName)
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 120)  // Increased candy size
    }
}

extension Array {
    // Utility to chunk an array into smaller arrays of a specified size
    func chunked(into size: Int) -> [[Element]] {
        var chunks: [[Element]] = []
        for i in 0..<count / size {
            chunks.append(Array(self[i*size..<Swift.min((i+1)*size, count)]))
        }
        return chunks
    }
}

struct CandyMonsterCC_Previews: PreviewProvider {
    static var previews: some View {
        CandyMonsterCC()
            .previewDevice("iPhone 12")
    }
}
