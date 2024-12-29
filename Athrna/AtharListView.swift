import SwiftUI

struct AtharListView: View {
    @ObservedObject var viewModel: AtharListViewModel
    @State private var navigateToCandyMonsterG = false // Track navigation programmatically
    @State private var lastTappedColor: String? // Track the last tapped color

    var body: some View {
        NavigationStack {
            VStack {
                Color(red: 1.0, green: 0.97, blue: 0.90)
                    .ignoresSafeArea()
                    .overlay(
                        VStack(spacing: 20) {
                            titleText
                            girlImage
                            colorOptions
                        }
                        .padding()
                    )
            }
            .navigationBarHidden(true) // Hide the top navigation bar
            
            // Navigation programmatically without showing the blue box
            .background(
                NavigationLink(
                    destination: CandyMonsterG(selectedGirl: viewModel.selectedGirlImage),
                    isActive: $navigateToCandyMonsterG,
                    label: { EmptyView() } // No visual button
                )
                .hidden() // Make the NavigationLink hidden so no blue box appears
            )
        }
    }

    // Title text
    private var titleText: some View {
        Text("اختاري لون فستان العيد")
            .font(.custom("DG Enab", size: 50))
            .foregroundColor(Color(hex: "#732A48"))
            .bold()
            .padding()
    }

    // Girl's image, which will trigger navigation when tapped
    private var girlImage: some View {
        Image(viewModel.selectedGirlImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 480)
            .onTapGesture {
                // Programmatically navigate when image is tapped
                navigateToCandyMonsterG = true
            }
    }

    // Color options for dress selection
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
                                // Double-tap detected: Confirm color selection and trigger navigation
                                viewModel.selectDressColor(color: color)
                                navigateToCandyMonsterG = true
                            } else {
                                // Single-tap: Change the dress color
                                viewModel.selectDressColor(color: color)
                                lastTappedColor = color
                            }
                        }
                }
            }
        }
    }
}

struct AtharListView_Previews: PreviewProvider {
    static var previews: some View {
        AtharListView(viewModel: AtharListViewModel())
    }
}
