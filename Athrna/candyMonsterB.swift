import SwiftUI

struct candyMonsterB: View {
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.97, blue: 0.90)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Title for Boy's page
                Text("ساعد سعد يهزم وحش الحلويات!")
                    .font(.system(size: 65, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.brown)
                    .lineLimit(1)
                    .padding(.horizontal, 20)

                Spacer()

                // Boy's image (updated to use boys.png)
                Image("boyBAT")  // Make sure "boys.png" is in your assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 800, height: 850)
                    .clipShape(Rectangle())
                    .padding(.horizontal, 20)

                Spacer()
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct candyMonsterB_Previews: PreviewProvider {
    static var previews: some View {
        candyMonsterB()
    }
}

