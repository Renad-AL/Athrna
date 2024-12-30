import SwiftUI

struct CandyMonsterG: View {
    var selectedGirl: String // Receive selected character to display image
    @State private var navigateToCandyMonster1 = false // Flag to trigger navigation

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.0, green: 0.97, blue: 0.90)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("ساعد سارة تهزم وحش الحلويات!")
                        .font(.system(size: 65, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.brown)
                        .lineLimit(1)
                        .padding(.horizontal, 20)

                    Spacer()

                    Image(selectedGirl) // Dynamically change image based on selected character
                        .resizable()
                        .scaledToFit()
                        .frame(width: 800, height: 850)
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            navigateToCandyMonster1 = true
                        }

                    NavigationLink(destination: candyMonster1(), isActive: $navigateToCandyMonster1) {
                        EmptyView()
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct CandyMonsterG_Previews: PreviewProvider {
    static var previews: some View {
        CandyMonsterG(selectedGirl: "girl")
    }
}

