//
//  AtharListViewgirl.swift
//  Athrna
//
//  Created by Linah on 30/06/1446 AH.
//
import SwiftUI

struct AtharListViewgirl: View {
    @ObservedObject var viewModel: ViewModelgirl
    @State private var navigateToCandyMonsterG = false

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
            .navigationBarHidden(true)
            .background(
                NavigationLink(destination: CandyMonsterG(selectedGirl: viewModel.selectedGirlImage), isActive: $navigateToCandyMonsterG) {
                    EmptyView()
                }
            )
        }
    }

    private var titleText: some View {
        Text("اختاري لون فستان العيد للبنت")
            .font(.custom("DG Enab", size: 50))
            .foregroundColor(Color(hex: "#732A48"))
            .bold()
            .padding()
    }

    private var girlImage: some View {
        Image(viewModel.selectedGirlImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 480)
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
                            viewModel.selectDressColor(color: color)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // تأخير لمدة ثانية
                                navigateToCandyMonsterG = true
                            }
                        }
                }
            }
        }
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

struct AtharListViewgirl_Previews: PreviewProvider {
    static var previews: some View {
        AtharListViewgirl(viewModel: ViewModelgirl())
    }
}
