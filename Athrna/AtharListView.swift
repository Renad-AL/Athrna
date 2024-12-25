import SwiftUI

struct AtharListView: View {
    @ObservedObject var viewModel: AtharListViewModel

    var body: some View {
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
    }

    // عنصر النص
    private var titleText: some View {
        Text("اختاري لون فستان العيد")
            .font(.custom("DG Enab", size: 50))
            .foregroundColor(Color(hex: "#732A48"))
            .bold()
            .padding()
    }

    // صورة الفتاة
    private var girlImage: some View {
        Image(viewModel.selectedGirlImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 480)
    }

    // خيارات الألوان
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

