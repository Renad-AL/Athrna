import SwiftUI

struct CookingView: View {
    @State private var eggsGroupPosition: CGPoint = CGPoint(x: -50, y: -40)
    private let eggsGroupOriginalPosition: CGPoint = CGPoint(x: -50, y: -40)

    @State private var datesGroupPosition: CGPoint = CGPoint(x: 30, y: -40)
    private let datesGroupOriginalPosition: CGPoint = CGPoint(x: 30, y: -40)

    @State private var flourPosition: CGPoint = CGPoint(x: 0, y: 0)
    @State private var milkPosition: CGPoint = CGPoint(x: -20, y: 0)

    private let flourOriginalPosition: CGPoint = CGPoint(x: 0, y: 0)
    private let milkOriginalPosition: CGPoint = CGPoint(x: -20, y: 0)

    @State private var bowlImage: String = "group" // الصحن الأساسي
    @State private var isDatesHidden: Bool = false // حالة إخفاء التمر
    @State private var isEggsHidden: Bool = false // حالة إخفاء البيض
    @State private var hasEggsBeenPlaced: Bool = false // هل تم وضع البيض أولًا
    @State private var hasDatesBeenPlaced: Bool = false // هل تم وضع التمر أولًا
    @State private var hasMilkBeenPlaced: Bool = false // هل تم وضع الحليب أولًا
    @State private var hasFlourBeenPlaced: Bool = false // هل تم وضع الدقيق أولًا

    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.97, blue: 0.91)
                .edgesIgnoringSafeArea(.all)

            Image("wall")
                .resizable()
                .scaledToFill()
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
                        .frame(width: 800, height: 180)
                        .offset(y: 19)

                    HStack(spacing: 15) {
                        createDraggableItem(imageName: "flour", position: $flourPosition, originalPosition: flourOriginalPosition, size: CGSize(width: 230, height: 270))
                            .offset(x: -50)
                            .offset(y: -2)
                        
                        createDraggableItem(imageName: "milk", position: $milkPosition, originalPosition: milkOriginalPosition, size: CGSize(width: 100, height: 180))
                            .offset(x: -70)
                            .offset(y: -10)

                        // ZStack الخاصة بالبيض
                        createDraggableGroup(imageNames: ["egg1", "egg2", "egg3"], groupPosition: $eggsGroupPosition, originalPosition: eggsGroupOriginalPosition, isHidden: $isEggsHidden, isEggsPlaced: $hasEggsBeenPlaced, isDatesPlaced: $hasDatesBeenPlaced, isMilkPlaced: $hasMilkBeenPlaced)
                            .offset(x: 10, y: 20)

                        // ZStack الخاصة بالتمور
                        if !isDatesHidden {
                            createDraggableGroup(imageNames: ["date1", "date2", "date3"], groupPosition: $datesGroupPosition, originalPosition: datesGroupOriginalPosition, isHidden: $isDatesHidden, isEggsPlaced: $hasEggsBeenPlaced, isDatesPlaced: $hasDatesBeenPlaced, isMilkPlaced: $hasMilkBeenPlaced) // إضافة isMilkPlaced هنا
                                .offset(x: -0, y: 20)
                        }
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
                .offset(x: -50, y: 140)
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
                            position.wrappedValue = CGPoint(x: -9999, y: -9999) // إخراج العنصر من الشاشة
                        } else {
                            position.wrappedValue = originalPosition // إرجاع العنصر لمكانه الأصلي
                        }
                    }
            )
    }

    @ViewBuilder
    private func createDraggableGroup(imageNames: [String], groupPosition: Binding<CGPoint>, originalPosition: CGPoint, isHidden: Binding<Bool>, isEggsPlaced: Binding<Bool>, isDatesPlaced: Binding<Bool>, isMilkPlaced: Binding<Bool>) -> some View {
        ZStack {
            ForEach(0..<imageNames.count, id: \.self) { index in
                Image(imageNames[index])
                    .resizable()
                    .frame(width: 100, height: 100)
                    .offset(CGSize(width: groupPosition.wrappedValue.x + CGFloat(index * 20), height: groupPosition.wrappedValue.y + CGFloat(index * 20)))
                    .opacity(isHidden.wrappedValue ? 0 : 1) // إخفاء البيض أو التمر عندما يدخل الصحن
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    groupPosition.wrappedValue = value.location
                }
                .onEnded { _ in
                    if isWithinBowl(position: groupPosition.wrappedValue) {
                        // تحديد صورة الصحن بناءً على ترتيب العناصر
                        if !hasDatesBeenPlaced {
                            bowlImage = "group1" // إذا تم وضع التمر أولًا
                            hasDatesBeenPlaced = true // تم وضع التمر
                        } else if hasDatesBeenPlaced && !hasEggsBeenPlaced {
                            bowlImage = "group3" // إذا تم وضع التمر أولًا ثم البيض
                            hasEggsBeenPlaced = true // تم وضع البيض
                        } else if hasEggsBeenPlaced && hasDatesBeenPlaced && !hasMilkBeenPlaced {
                            bowlImage = "group4" // إذا تم وضع البيض والتمر أولًا ثم الحليب
                            hasMilkBeenPlaced = true // تم وضع الحليب
                        } else if hasMilkBeenPlaced && hasEggsBeenPlaced && hasDatesBeenPlaced && !hasFlourBeenPlaced {
                            bowlImage = "group5" // إذا تم وضع البيض والتمر والحليب ثم الدقيق
                            hasFlourBeenPlaced = true // تم وضع الدقيق
                        }
                        
                        if imageNames.first == "egg1" { // إذا كان العنصر هو البيض
                            isHidden.wrappedValue = true
                        } else if imageNames.first == "date1" {
                            isDatesHidden = true
                        } else if imageNames.first == "milk" {
                            isMilkPlaced.wrappedValue = true
                        }
                    } else {
                        groupPosition.wrappedValue = originalPosition
                    }
                }
        )
    }



    private func isWithinBowl(position: CGPoint) -> Bool {
        let bowlCenter = CGPoint(x: -50, y: 140) // موقع الصحن
        let threshold: CGFloat = 300  // المسافة المطلوبة لتغيير صورة الصحن
        let distance = sqrt(pow(position.x - bowlCenter.x, 2) + pow(position.y - bowlCenter.y, 2))
        return distance > threshold
    }
}

#Preview {
    CookingView()
}
