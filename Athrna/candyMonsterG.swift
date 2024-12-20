import SwiftUI

struct candyMonsterG: View {
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.97, blue: 0.90)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Title for Girl's page
                Text("ساعد سارة تهزم وحش الحلويات!")
                    .font(.system(size: 65, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.brown)
                    .lineLimit(1)
                    .padding(.horizontal, 20)

                Spacer()

                // Girl's image (ensure the image is added correctly to the assets folder)
                Image("girl")  // Image reference without the extension
                    .resizable()
                    .scaledToFit()
                    .frame(width: 800, height: 850) // Adjust the size
                    .padding(.horizontal, 20)

                Spacer()
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct candyMonsterG_Previews: PreviewProvider {
    static var previews: some View {
        candyMonsterG()
    }
}
