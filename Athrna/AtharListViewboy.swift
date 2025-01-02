import SwiftUI
import AVFoundation

struct AtharListViewBoy: View {
    @ObservedObject var viewModel: ViewModelboy
    @State private var navigateToCandyMonsterB = false
    @State private var lastTappedColor: String?
    @State private var audioPlayer: AVAudioPlayer? // Audio player for background music

    var body: some View {
        NavigationStack {
            VStack {
                Color(red: 1.0, green: 0.97, blue: 0.90)
                    .ignoresSafeArea()
                    .overlay(
                        VStack(spacing: 20) {
                            titleText
                            boyImage
                            colorOptions
                        }
                        .padding()
                    )
            }
            .navigationBarHidden(true)
            .background(
                NavigationLink(
                    destination: candyMonsterB(selectedGirl: viewModel.selectedBoyImage),
                    isActive: $navigateToCandyMonsterB,
                    label: { EmptyView() }
                )
                .hidden()
            )
        }
        .onAppear {
            // Play "CcolorBoy.mp3" when the view appears
            playSound(named: "CcolorBoy")
        }
    }

    private var titleText: some View {
        Text("اختاري لون ثوب العيد")
            .font(.custom("DG Enab", size: 50))
            .foregroundColor(Color(hex: "#732A48"))
            .bold()
            .padding()
    }

    private var boyImage: some View {
        Image(viewModel.selectedBoyImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 480)
            .onTapGesture {
                navigateToCandyMonsterB = true
            }
    }

    private var colorOptions: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 1.0, green: 0.949, blue: 0.847))
                .frame(width: 290, height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 3)
                )

            HStack(spacing: 15) {
                ForEach(viewModel.availableDressColors, id: \.self) { color in
                    Rectangle()
                        .fill(Color(hex: color))
                        .frame(width: 70, height: 70)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    color == viewModel.selectedDressColor ?
                                    Color(hex: "#007AFF") : Color.white,
                                    lineWidth: 3
                                )
                        )
                        .onTapGesture {
                            if lastTappedColor == color {
                                viewModel.selectDressColor(color: color)
                                navigateToCandyMonsterB = true
                            } else {
                                viewModel.selectDressColor(color: color)
                                lastTappedColor = color
                            }
                        }
                }
            }
        }
    }

    private func playSound(named soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error)")
            }
        }
    }
}

struct AtharListViewBoy_Previews: PreviewProvider {
    static var previews: some View {
        AtharListViewBoy(viewModel: ViewModelboy())
    }
}
