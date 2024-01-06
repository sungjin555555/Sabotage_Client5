import SwiftUI

struct SaveItemVC: View {
    @State var item: LimitDummyDataType

    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $item.title)
                    .padding()
                TextField("Time Budget", value: $item.timeBudget, formatter: NumberFormatter())
                    .padding()
                TextField("Nudge Interval", value: $item.nudgeInterval, formatter: NumberFormatter())
                    .padding()
                
                // 추가적인 수정을 위한 UI 요소나 로직을 여기에 추가할 수 있습니다.
            }
            .navigationTitle("Edit Item") // 뷰 타이틀 설정
        }
    }
}

struct SaveItemVC_Previews: PreviewProvider {
    static var previews: some View {
        SaveItemVC(item: LimitDummyDataType(id: 1, title: "Sample", timeBudget: 60, nudgeInterval: 10))
    }
}
