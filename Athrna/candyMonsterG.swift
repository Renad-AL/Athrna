import SwiftUI

struct CandyMonsterG: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.0, green: 0.97, blue: 0.90)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("ساعد سارة تهزم وحش الحلويات!")
                        .font(.system(size: 65, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.brown)
                        .lineLimit(1)
                        .padding(.horizontal, 20)

                    Spacer()

                    NavigationLink(destination: candyMonster1()) {
                        Image("sarabat")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 800, height: 850)
                            .padding(.horizontal, 20)
                    }
                    .buttonStyle(PlainButtonStyle())

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
        CandyMonsterG()
    }
}
