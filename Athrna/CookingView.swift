//import SwiftUI
//
//struct CookingView: View {
//    @State private var eggsGroupPosition: CGPoint = CGPoint(x: -50, y: -40)
//    private let eggsGroupOriginalPosition: CGPoint = CGPoint(x: -50, y: -40)
//
//    @State private var datesGroupPosition: CGPoint = CGPoint(x: 30, y: -40)
//    private let datesGroupOriginalPosition: CGPoint = CGPoint(x: 30, y: -40)
//
//    @State private var flourPosition: CGPoint = CGPoint(x: 0, y: 0)
//    @State private var milkPosition: CGPoint = CGPoint(x: -20, y: 0)
//
//    private let flourOriginalPosition: CGPoint = CGPoint(x: 0, y: 0)
//    private let milkOriginalPosition: CGPoint = CGPoint(x: -20, y: 0)
//
//    @State private var bowlImage: String = "group" // الصحن الأساسي
//    @State private var isDatesHidden: Bool = false // حالة إخفاء التمر
//    @State private var isEggsHidden: Bool = false // حالة إخفاء البيض
//    @State private var hasEggsBeenPlaced: Bool = false // هل تم وضع البيض أولًا
//    @State private var hasDatesBeenPlaced: Bool = false // هل تم وضع التمر أولًا
//    @State private var hasMilkBeenPlaced: Bool = false // هل تم وضع الحليب أولًا
//    @State private var hasFlourBeenPlaced: Bool = false // هل تم وضع الدقيق أولًا
//    @State private var showPopUp: Bool = false // لعرض صفحة pop-up
//    @State private var hasStartedWithEggs: Bool = false // هل بدأ المستخدم بالبيض أولًا
//    @State private var navigateToAtharList: Bool = false // Flag for navigation
//
//    var body: some View {
//        NavigationStack { // Wrapping in NavigationStack for navigation functionality
//            ZStack {
//                // الخلفية بلون بيج فاتح
//                Color(red: 1.0, green: 0.97, blue: 0.91)
//                    .edgesIgnoringSafeArea(.all)
//
//                // إضافة صورة الجدار
//                Image("wall")
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//
//                VStack {
//                    // العنوان
//                    Text("ساعد والدتك في إعداد كعكة العيد")
//                        .font(.system(size: 40, weight: .bold))
//                        .foregroundColor(.brown)
//                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 2, y: 2)
//                        .padding(.top, 60)
//
//                    ZStack {
//                        Image("shelf")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 800, height: 180)
//                            .offset(y: 19)
//
//                        HStack(spacing: 15) {
//                            createDraggableItem(imageName: "flour", position: $flourPosition, originalPosition: flourOriginalPosition, size: CGSize(width: 230, height: 270))
//                                .offset(x: -50)
//                                .offset(y: -2)
//                            createDraggableItem(imageName: "milk", position: $milkPosition, originalPosition: milkOriginalPosition, size: CGSize(width: 100, height: 180))
//                                .offset(x: -70)
//                                .offset(y: -10)
//
//                            // ZStack الخاصة بالبيض
//                            createDraggableGroup(imageNames: ["egg1", "egg2", "egg3"], groupPosition: $eggsGroupPosition, originalPosition: eggsGroupOriginalPosition, isHidden: $isEggsHidden, isEggsPlaced: $hasEggsBeenPlaced, isDatesPlaced: $hasDatesBeenPlaced)
//                                .offset(x: 10, y: 20)
//
//                            // ZStack الخاصة بالتمور
//                            if !isDatesHidden {
//                                createDraggableGroup(imageNames: ["date1", "date2", "date3"], groupPosition: $datesGroupPosition, originalPosition: datesGroupOriginalPosition, isHidden: $isDatesHidden, isEggsPlaced: $hasEggsBeenPlaced, isDatesPlaced: $hasDatesBeenPlaced)
//                                    .offset(x: -0, y: 20)
//                            }
//                        }
//                        .offset(y: -70)
//                    }
//                    .padding(.top, 40)
//
//                    Spacer()
//                }
//
//                // صورة الصحن
//                Image(bowlImage)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 900, height: 900)
//                    .offset(x: -50, y: 140)
//
//                // صفحة pop-up لعرض الكعكة بحجم الشاشة بالكامل
//                if showPopUp {
//                    ZStack {
//                        // الخلفية مع لون بيج فاتح وصورة الجدار
//                        Color(red: 1.0, green: 0.97, blue: 0.91)
//                            .edgesIgnoringSafeArea(.all)
//
//                        Image("wall")  // صورة الجدار في الأسفل
//                            .resizable()
//                            .scaledToFill()
//                            .edgesIgnoringSafeArea(.all)
//
//                        VStack {
//                            Spacer()
//                            
//                            // النص في أعلى الصفحة
//                            Text("رائع!")
//                                .font(.system(size: 120, weight: .bold))
//                                .foregroundColor(.brown)
//                                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 2, y: 2)
//                                .padding(.top, -400)
//                            
//
//                            Spacer()
//                        }
//                        
//                        // صورة الكعكة
//                        Image("cake") // الصورة التي تريد عرضها
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7) // تغيير الحجم ليأخذ الشاشة
//                            .shadow(radius: 10)
//                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                            .onAppear {
//                                // Trigger navigation after the pop-up is shown
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                    navigateToAtharList = true
//                                }
//                            }
//                    }
//                }
//
//            }
//
//            // Hidden NavigationLink that will trigger after the pop-up
//            NavigationLink(destination: AtharListView(selectedCharacter: "Some Character"), isActive: $navigateToAtharList) {
//                EmptyView()
//            }
//        }
//    }
//
//    private func isWithinBowl(position: CGPoint) -> Bool {
//        let bowlFrame = CGRect(x: -50, y: 140, width: 900, height: 900)
//        return bowlFrame.contains(position)
//    }
//}
//
