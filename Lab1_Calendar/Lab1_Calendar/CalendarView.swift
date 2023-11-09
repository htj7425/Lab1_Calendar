import SwiftUI

struct CalendarView: View {
    let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
    @State private var selectedMonth: Date = Date()
    let year: Int
    let month: Int
    let day: Int
    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(selectedMonth, formatter: monthFormatter)")
                .font(.title)
                .foregroundStyle(Color.white)
                .padding()
            
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 7), spacing: 10) {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
            }
            
            let daysInMonth = numberOfDaysInMonth(for: selectedMonth)
            let firstDayOfMonth = firstDayOfMonth(for: selectedMonth)
            
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 7), spacing: 10) {
                ForEach(0..<firstWeekdayOfMonth(for: firstDayOfMonth), id: \.hashValue) { _ in
                    Text(" ")
                        .frame(maxWidth: .infinity)
                }
                
                ForEach(1...daysInMonth, id: \.self) { day in
                    Text("\(day)")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(isToday(day: day) ? .red : .cyan)
                }
            }.id(UUID()) // Grid는 셀을 매번 새로 생성하지 않고 재사용하기 때문에 강제로 뷰를 새로 그리도록 하기 위해 Id를 할당하여 view를 새로 그리게 함
                .frame(minHeight: 200)
            
            HStack {
                Button("Before Month") {
                    selectedMonth = Calendar.current.date(byAdding: .month, value: -1, to: selectedMonth) ?? Date()
                }
                .frame(minWidth: 110)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.grayViewColor)
                .cornerRadius(20)
                Button("Next Month") {
                    selectedMonth = Calendar.current.date(byAdding: .month, value: 1, to: selectedMonth) ?? Date()
                    
                }
                .frame(minWidth: 110)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.grayViewColor)
                .cornerRadius(20)            }
            Spacer()
        } // VStack
        .padding()
        .background(.black)
        .onAppear() {
            let components = DateComponents(year: year, month: month, day: day)
            self.selectedMonth = Calendar.current.date(from: components)!
        }
        
    }
    
    func numberOfDaysInMonth(for date: Date) -> Int {
        let range = Calendar.current.range(of: .day, in: .month, for: date)!
        return range.count
    } // 총 일수 계산
    
    func firstWeekdayOfMonth(for date: Date) -> Int {
        let firstDay = firstDayOfMonth(for: date) // 첫번째 날짜를 가지고옴
        let weekday = Calendar.current.component(.weekday, from: firstDay)
        return (weekday + 6) % 7 // Sunday is 0, Monday is 1, ..., Saturday is 6
    } // 특정 월 의 첫번째 요일 계산
    
    
    
    func firstDayOfMonth(for date: Date) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        components.day = 1
        return Calendar.current.date(from: components) ?? date
    } // 첫번째 날짜를 반환
    
    func isToday(day: Int) -> Bool {
        let calendar = Calendar.current
        let today = calendar.dateComponents([.year, .month, .day], from: Date())
        let currentDay = calendar.dateComponents([.year, .month, .day], from: selectedMonth)
        
        return today.year == currentDay.year && today.month == currentDay.month && today.day == day
    }
    
    
    var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MMMM"
        return formatter
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(year: 2023, month: 4, day: 1)
    }
}
