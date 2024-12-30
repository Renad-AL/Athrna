import SwiftUI

struct AtharListView: View {
    @ObservedObject var viewModel: AtharListViewModel // استخدم الـ ViewModel هنا

    @State private var navigateToCandyMonster = false // Track navigation state

    var body: some View {
        NavigationStack {
            VStack {
                Text("اختاري لون فستان العيد")
                    .font(.title)
                    .padding()

                // هنا يمكنك عرض صورة الشخصية بناءً على الـ ViewModel
                Image(viewModel.selectedCharacterImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                Button(action: {
                    navigateToCandyMonster = true
                }) {
                    Text("انتقل إلى الوحش")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: CandyMonsterG(selectedGirl: viewModel.selectedCharacter), isActive: $navigateToCandyMonster) {
                    EmptyView()
                }
                .hidden()
            }
        }
    }
}

struct AtharListView_Previews: PreviewProvider {
    static var previews: some View {
        AtharListView(viewModel: AtharListViewModel(selectedCharacter: "Girl"))
    }
}

