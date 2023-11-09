import SwiftUI

struct ContentView: View {
    @State private var selectedDate: Date = Date() // 처음에는 오늘 날짜로 설정

    var body: some View {
        VStack {
            MonthSelectGridView()
        }
    }
}

#Preview {
    ContentView()
}
