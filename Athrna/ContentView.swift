import SwiftUI

struct ContentView: View {
    @AppStorage("selectedCharacter") private var selectedCharacter: String = "None"
    
    // Track navigation state
    @State private var navigateToCooking = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.0, green: 0.97, blue: 0.90)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Image("light")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 500)
                        .frame(width: 1500)
                        .clipped()
                        .padding(.top, -100)

                    Text("أهلًا بمحاربينا")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.brown)
                        .padding(.top, 30)

                    Spacer()

                    HStack(spacing: 100) {
                        VStack(spacing: 10) {
                            Button(action: {
                                selectedCharacter = "Girl"
                                navigateToCooking = true // Trigger navigation to CookingView
                            }) {
                                Image("saraleft")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 350, height: 450)
                            }
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.pink.opacity(0.8))
                                .frame(width: 150, height: 60)
                                .overlay(Text("سارة").font(.title).foregroundColor(.white))
                        }

                        VStack(spacing: 10) {
                            Button(action: {
                                selectedCharacter = "Boy"
                                navigateToCooking = true // Trigger navigation to CookingView
                            }) {
                                Image("Boyy")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 350, height: 450)
                            }
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.purple.opacity(0.8))
                                .frame(width: 150, height: 60)
                                .overlay(Text("سعد").font(.title).foregroundColor(.white))
                        }
                    }
                    .padding(.bottom, 100)

                    Spacer()

                    // Navigation Link to CookingView
                    NavigationLink(destination: CookingView(), isActive: $navigateToCooking) {
                        EmptyView() // Invisible navigation trigger
                    }
                    .hidden()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
