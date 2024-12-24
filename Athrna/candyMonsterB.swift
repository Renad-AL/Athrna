import SwiftUI

struct candyMonsterB: View {
    var body: some View {
        NavigationView {  // Wrap the whole view in a NavigationView
            ZStack {
                Color(red: 1.0, green: 0.97, blue: 0.90) // Background color
                    .edgesIgnoringSafeArea(.all)  // Ensures the background fills the screen

                VStack(spacing: 20) {
                    // Title for Boy's page
                    Text("ساعد سعد يهزم وحش الحلويات!")
                        .font(.system(size: 65, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.brown)
                        .lineLimit(1)
                        .padding(.horizontal, 20)

                    Spacer()

                    // NavigationLink wrapped around the Image to navigate to candyMonster1
                    NavigationLink(destination: candyMonster1()) {
                        Image("boyBAT") // Ensure "boyBAT" is in your assets
                            .resizable()
                            .scaledToFit()
                            .frame(width: 800, height: 850)
                            .clipShape(Rectangle())
                            .padding(.horizontal, 20)
                            .shadow(radius: 10) // Optional: Add a shadow for better visual appeal
                    }
                    .buttonStyle(PlainButtonStyle()) // Removes default button styling on image

                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)  // Hide the navigation bar to avoid blue box or bar
            .navigationBarBackButtonHidden(true) // Hide the back button to avoid the blue box
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Ensures no navigation bar on smaller devices like iPhones
    }
}

struct candyMonsterB_Previews: PreviewProvider {
    static var previews: some View {
        candyMonsterB()
    }
}
