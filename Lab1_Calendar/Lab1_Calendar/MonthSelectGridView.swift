import SwiftUI

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}

extension Color {
    static let grayViewColor = Color(hex: "#252528")
}

struct MonthSelectGridView: View {
    private var data: [Int] = Array(1...12)

    private let adaptiveColumns = [ GridItem(.adaptive(minimum: 180)) ]

    private let numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            VStack {
                Text ("2023 Calender")
                    .font(.system(size: 70))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Spacer()
                
                ScrollView {
                    LazyVGrid(columns: numberColumns, spacing: 20 ) {
                        ForEach(data, id: \.self) { number in
                            NavigationLink(destination: CalendarView(year: 2023, month: number, day: 1)) {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(Color.grayViewColor)
                                        .cornerRadius(30)
                                    Text("\(number)")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 50, weight: .medium, design: .rounded))
                                }
                            }
                        }
                    }
                    .padding()
                    
                } // ScrollView
            } // VStack
            .background(.black)
        } // NavigationStack
    } // body
}


#Preview {
    MonthSelectGridView()
}
