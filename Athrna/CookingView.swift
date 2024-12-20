import SwiftUI

struct CookingView: View {
    @State private var egg1Position: CGPoint = CGPoint(x: -50, y: -40)
    @State private var egg2Position: CGPoint = CGPoint(x: -50, y: -10)
    @State private var date1Position: CGPoint = CGPoint(x: 30, y: -40)
    @State private var date2Position: CGPoint = CGPoint(x: 30, y: -10)
    @State private var date3Position: CGPoint = CGPoint(x: 30, y: 20)
    @State private var flourPosition: CGPoint = CGPoint(x: 0, y: 0)
    @State private var milkPosition: CGPoint = CGPoint(x: -20, y: 0)

    private let egg1OriginalPosition: CGPoint = CGPoint(x: -50, y: -40)
    private let egg2OriginalPosition: CGPoint = CGPoint(x: -50, y: -10)
    private let date1OriginalPosition: CGPoint = CGPoint(x: 30, y: -40)
    private let date2OriginalPosition: CGPoint = CGPoint(x: 30, y: -10)
    private let date3OriginalPosition: CGPoint = CGPoint(x: 30, y: 20)
    private let flourOriginalPosition: CGPoint = CGPoint(x: 0, y: 0)
    private let milkOriginalPosition: CGPoint = CGPoint(x: -20, y: 0)

    @State private var bowlImage: String = "bowl1"
    
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.97, blue: 0.91)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("ساعد والدتك في إعداد كعكة العيد")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.brown)
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 2, y: 2)
                    .padding(.top, 60)

                ZStack {
                    Image("shelf")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 700, height: 180)

                    HStack(spacing: 45) {
                        ZStack {
                            createDraggableItem(imageName: "egg1", position: $egg1Position, originalPosition: egg1OriginalPosition)
                            createDraggableItem(imageName: "egg2", position: $egg2Position, originalPosition: egg2OriginalPosition)
                        }
                        ZStack {
                            createDraggableItem(imageName: "date1", position: $date1Position, originalPosition: date1OriginalPosition)
                            createDraggableItem(imageName: "date2", position: $date2Position, originalPosition: date2OriginalPosition)
                            createDraggableItem(imageName: "date3", position: $date3Position, originalPosition: date3OriginalPosition)
                        }
                        createDraggableItem(imageName: "flour", position: $flourPosition, originalPosition: flourOriginalPosition, size: CGSize(width: 200, height: 250))
                        createDraggableItem(imageName: "milk", position: $milkPosition, originalPosition: milkOriginalPosition, size: CGSize(width: 80, height: 180))
                    }
                    .offset(y: -70)
                }
                .padding(.top, 40)

                Spacer()
            }

            Image(bowlImage)
                .resizable()
                .scaledToFit()
                .frame(width: 900, height: 900)
                .offset(x: -50, y: 50)
        }
    }

    @ViewBuilder
    private func createDraggableItem(imageName: String, position: Binding<CGPoint>, originalPosition: CGPoint, size: CGSize = CGSize(width: 100, height: 100)) -> some View {
        Image(imageName)
            .resizable()
            .frame(width: size.width, height: size.height)
            .offset(CGSize(width: position.wrappedValue.x, height: position.wrappedValue.y))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        position.wrappedValue = value.location
                    }
                    .onEnded { _ in
                        if isWithinBowl(position: position.wrappedValue) {
                            updateBowlImage(for: imageName)
                        } else {
                            position.wrappedValue = originalPosition
                        }
                    }
            )
    }

    private func isWithinBowl(position: CGPoint) -> Bool {
        let bowlCenter = CGPoint(x: 0, y: 0) // تعديل لتناسب موقع الصحن في الشاشة
        let threshold: CGFloat = 150
        let distance = sqrt(pow(position.x - bowlCenter.x, 2) + pow(position.y - bowlCenter.y, 2))
        return distance < threshold
    }

    private func updateBowlImage(for item: String) {
        switch item {
        case "milk":
            bowlImage = "bowl2"
        case "flour":
            bowlImage = "bowl3"
        case "date1", "date2", "date3":
            bowlImage = "bowl4"
        case "egg1", "egg2":
            bowlImage = "bowl5"
        default:
            bowlImage = "bowl1"
        }
    }
}

#Preview {
    CookingView()
}
