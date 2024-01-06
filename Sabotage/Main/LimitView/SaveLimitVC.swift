import SwiftUI
import FamilyControls
import ManagedSettingsUI

//struct LimitDummyDataType {
//    var categories: [String]
//    var title: String
//    var timeBudgets: [Int]
//
//    // 더 많은 데이터 필드 추가 가능
//}

struct SaveLimitVC: View {
    @EnvironmentObject var scheduleVM: ScheduleVM
    @State var tempSelection = FamilyActivitySelection()
    
    @State private var selectedGoalTime = Date()
    @State private var selectedNudgeTime = Date()
    @State private var isGoalPickerPresented = false
    @State private var isGoalTimePickerShown = false
    @State private var isNudgePickerPresented = false
    @State private var isNudgeTimePickerShown = false
    
    @State private var isAlertPresented = false

    
    
    @State private var selectedGoalHours = 0
    @State private var selectedGoalMinutes = 0
    @State private var selectedNudgeHours = 0
    @State private var selectedNudgeMinutes = 0
    @State var groupName: String = ""
    @State var finalTotal = ""
    @State var nudgeTotal = ""
    
    var selectedLimitItem: LimitDummyDataType
    
    init(selectedLimitItem: LimitDummyDataType) {
        self.selectedLimitItem = selectedLimitItem
        self._groupName = State(initialValue: selectedLimitItem.title)
        self._selectedGoalHours = State(initialValue: selectedLimitItem.timeBudget / 3600)
        self._selectedGoalMinutes = State(initialValue: (selectedLimitItem.timeBudget % 3600) / 60)
        self._selectedNudgeHours = State(initialValue: selectedLimitItem.nudgeInterval / 3600)
        self._selectedNudgeMinutes = State(initialValue: (selectedLimitItem.nudgeInterval % 3600) / 60)
    }
    
    @State private var selectedMinute: Int = 0
    let minutes = Array(0...59)
    let hours = Array(0...23)
    
//    @State var limitData: LimitDummyDataType? // LimitDummyDataType를 저장하는 State 추가
    
    
    //    // 서버에서 받아온 데이터를 저장할 변수들
    //        var categories: [String] = []
    //        var title: String = ""
    //        var timeBudgets: [Int] = []
    
    private func updateValues() {
        
            finalTotal = "\(selectedGoalHours * 60 * 60 + selectedGoalMinutes * 60)"
            nudgeTotal = "\(selectedNudgeHours * 60 * 60 + selectedNudgeMinutes * 60)"
        }
    
    
    var body: some View {
            NavigationView {
                VStack {
                    setupListView().background(Color.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar { savePlanButtonView() }
                .navigationTitle("제한 습관 수정하기")
                .navigationBarTitleDisplayMode(.inline)
                .familyActivityPicker(
                    isPresented: $scheduleVM.isFamilyActivitySectionActive,
                    selection: $tempSelection
                )
            }
            .onAppear {
                print("Selected Limit Item Title:", selectedLimitItem.title)
                // 나머지 데이터에 대해서도 동일한 방식으로 확인 가능
            }
        }
}

//// Add necessary extensions and methods from ScheduleView as needed
//
//struct SaveLimitVC_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveLimitVC()
//            .environmentObject(ScheduleVM())
//    }
//}

// MARK: - Views
extension SaveLimitVC {
    private func savePlanButtonView() -> ToolbarItemGroup<some View> {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
//            let BUTTON_LABEL = "수정"
            
            
            Button(action: {
                let finalTotal = "\(selectedGoalHours * 60 * 60 + selectedGoalMinutes * 60)"
                let nudgeTotal = "\(selectedNudgeHours * 60 * 60 + selectedNudgeMinutes * 60)"
                
                scheduleVM.saveSchedule(selectedApps: tempSelection)
                GroupUpdateRequest(id: selectedLimitItem.id, title: groupName, timeBudget: finalTotal, nudgeInterval: nudgeTotal)
            }) {
//                Text(BUTTON_LABEL).foregroundColor(isInputValid ? Color.primary700 : Color.base200).font(.headline)
            }
            .padding(.trailing, 8) // 오른쪽에 패딩 추가
        }
    }
//    private func savePlanButtonView() -> ToolbarItemGroup<some View> {
//        ToolbarItemGroup(placement: .navigationBarTrailing) {
//            let BUTTON_LABEL = "저장"
//
//            Button(action: {
//                let finalTotal = selectedGoalHours * 60 * 60 + selectedGoalMinutes * 60
//                let nudgeTotal = selectedNudgeHours * 60 * 60 + selectedNudgeMinutes
//
//                //                $scheduleVM.isSaveAlertActive
//                scheduleVM.saveSchedule(selectedApps: tempSelection)
//                GroupUpdateRequest(title: groupName, timeBudget: finalTotal, nudgeInterval: nudgeTotal)
//            }) {
//                Text(BUTTON_LABEL).foregroundColor(isInputValid ? Color.primary700 : Color.base200).font(.headline)
//            }
//            .padding(.trailing, 8) // 오른쪽에 패딩 추가
//        }
//    }
    
//    private func setupListView() -> some View {
//        List {
//            setUpGroupTextField()
//            setUPAppSectionView()
//            setUpGoalTimeView(selectedTime: $selectedGoalTime, isPickerPresented: $isGoalPickerPresented)
//            setUpNudgeTimeView(selectedTime: $selectedNudgeTime, isPickerPresented: $isNudgePickerPresented)
//            setSaveButton().listRowInsets(EdgeInsets()).padding(0).listRowBackground(Color.clear)
//            setDeleteButton().listRowInsets(EdgeInsets().padding(0).listRowBackground(Color.clear)
//
////            setButton().listRowInsets(EdgeInsets()).padding(0).listRowBackground(Color.clear)
//        }.background(Color.base50)
//            .scrollContentBackground(.hidden)
//            .listStyle(.insetGrouped)
//            .padding(.horizontal, 5).fullScreenCover(isPresented: $isGoalPickerPresented) {
//                VStack {
//                    DatePicker(
//                        "시간 선택",
//                        selection: $selectedGoalTime,
//                        displayedComponents: [.hourAndMinute]
//                    )
//                    .datePickerStyle(WheelDatePickerStyle())
//                    .labelsHidden()
//
//                    Button("완료") {
//                        isGoalPickerPresented = false
//                    }
//                    .padding()
//                }
//            }
//    }
    private func setupListView() -> some View {
        
        
        List {
            setUpGroupTextField()
            setUPAppSectionView()
            setUpGoalTimeView(selectedTime: $selectedGoalTime, isPickerPresented: $isGoalPickerPresented)
            setUpNudgeTimeView(selectedTime: $selectedNudgeTime, isPickerPresented: $isNudgePickerPresented)
            setSaveButton().listRowInsets(EdgeInsets()).padding(0).listRowBackground(Color.clear)
            setDeleteButton().listRowInsets(EdgeInsets()).padding(0).listRowBackground(Color.clear) // 여기 수정 필요

    //        setButton().listRowInsets(EdgeInsets()).padding(0).listRowBackground(Color.clear)
        }
        .background(Color.base50)
        .scrollContentBackground(.hidden)
        .listStyle(.insetGrouped)
        .padding(.horizontal, 5)
        .fullScreenCover(isPresented: $isGoalPickerPresented) {
            VStack {
                DatePicker(
                    "시간 선택",
                    selection: $selectedGoalTime,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                
                Button("완료") {
                    isGoalPickerPresented = false
                }
                .padding()
            }
        }
    }

    
    
    private func setUpGroupTextField() -> some View {
        return Section(header: Text("그룹 이름").padding(.leading, -13)) {
            VStack {
                TextField(selectedLimitItem.title, text: $groupName)
                    .font(.system(size: 18))
                    .foregroundColor(Color.base400)
                    .padding()
                    .padding(.leading, -20)
                    .background(Color.base100)
                    .frame(height: 40)
                    .onAppear {
                        groupName = selectedLimitItem.title // 초기 값을 selectedLimitItem.title로 설정합니다.
                    }
            }
            .listRowBackground(Color.base100)
        }
    }

    
    
    
    private func setUPAppSectionView() -> some View {
        let BUTTON_LABEL = "Edit"
        let EMPTY_TEXT = "제한 목록"
        
        return Section(
        ) {
            if isSelectionEmpty() {
                HStack {
                    Text(EMPTY_TEXT)
                        .font(.callout)
                        .foregroundColor(.base400)
                    Spacer()
                    Button {
                        scheduleVM.showFamilyActivitySelection()
                    } label: {
                        Text(BUTTON_LABEL).foregroundColor(Color.primary700)
                    }
                }.padding(.vertical, 10)
            } else {
                VStack {
                    HStack {
                        Text(EMPTY_TEXT)
                            .foregroundColor(Color.base400).padding(.top, 10).padding(.bottom, 10)
                            .font(.system(size: 18))
                        Spacer()
                        Button {
                            scheduleVM.showFamilyActivitySelection()
                        } label: {
                            Text(BUTTON_LABEL).foregroundColor(Color.primary700)
                        }
                    }
                    VStack(alignment: .leading) { // VStack의 정렬 방향을 .leading으로 설정
                        ForEach(Array(tempSelection.applicationTokens), id: \.self) { token in
                            HStack {
                                Label(token)
                                Spacer() // 나머지 공간을 채워서 Text를 왼쪽으로 밀어냄
                            }
                        }
                        ForEach(Array(tempSelection.categoryTokens), id: \.self) { token in
                            HStack {
                                Label(token)
                                Spacer()
                            }
                        }
                        ForEach(Array(tempSelection.webDomainTokens), id: \.self) { token in
                            HStack {
                                Label(token)
                                Spacer()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // VStack을 뷰의 왼쪽 가장자리로 정렬
                    
                }
            }
        }
    }
    private func setUpGoalTimeView(selectedTime: Binding<Date>, isPickerPresented: Binding<Bool>) -> some View {
        let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH 'Hours' mm 'min'"
            return formatter
        }()
        
        // Extracting hours and minutes from timeBudget
        let timeBudgetHours = selectedLimitItem.timeBudget / 3600
        let timeBudgetMinutes = (selectedLimitItem.timeBudget % 3600) / 60
        
        return Section(footer: Text("하루에 앱을 얼마나 사용할지 총 목표 시간을 설정해주세요")) {
            VStack(alignment: .leading) {
                Button(action: {
                    isGoalTimePickerShown.toggle()
                }) {
                    HStack {
                        Text("목표 사용시간")
                            .font(.callout)
                            .foregroundColor(.base400)
                        Spacer()
                        Text("\(selectedGoalHours) hours \(selectedGoalMinutes) min")
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical)
                
                if isGoalTimePickerShown {
                    // Your existing time picker code
                    
                    HStack {
                        Picker("Hours", selection: $selectedGoalHours) {
                            ForEach(hours, id: \.self) { hour in
                                Text("\(hour)").tag(hour)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 70)
                        .compositingGroup()
                        
                        Text("hours")
                            .foregroundColor(.secondary)
                        
                        Picker("Minutes", selection: $selectedGoalMinutes) {
                            ForEach(minutes, id: \.self) { minute in
                                Text("\(minute)").tag(minute)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 70)
                        .clipped()
                        .compositingGroup()
                        
                        Text("min")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
            }
            .onAppear {
                // Set the initial values when the view appears
                self.selectedGoalHours = timeBudgetHours
                self.selectedGoalMinutes = timeBudgetMinutes
            }
        }
    }

    private func setUpNudgeTimeView(selectedTime: Binding<Date>, isPickerPresented: Binding<Bool>) -> some View {
        let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "$min 'Hours' mm 'min'" // 24시간 형식에 "Hours", "min"을 추가합니다.
            return formatter
        }()
        
        return Section(footer: Text("무한 스크롤링에서 벗어나 앱을 탈출할 신호를 보내드려요\n알림을 받을 간격을 설정해주세요")) {
            VStack(alignment: .leading) {
                Button(action: {
                    isNudgePickerPresented.toggle()
                }) {
                    HStack {
                        Text("알림 간격")
                            .font(.callout)
                            .foregroundColor(.base400)
                        Spacer()
                        Text("\(selectedNudgeHours) hours \(selectedNudgeMinutes) min")
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical)
                
                if isNudgePickerPresented {
                    ZStack {
                        // 카운트다운 타이머
                        HStack {
                            Picker("Hours", selection: $selectedNudgeHours) {
                                ForEach(hours, id: \.self) { hour in
                                    Text("\(hour)").tag(hour)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 70)
                            .clipped()
                            .compositingGroup()
                            
                            Text("hours")
                                .foregroundColor(.secondary)
                            
                            Picker("Minutes", selection: $selectedNudgeMinutes) {
                                ForEach(minutes, id: \.self) { minute in
                                    Text("\(minute)").tag(minute)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 70)
                            .clipped()
                            .compositingGroup()
                            
                            Text("min")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                }
            }
        }
    }
    
    private var isInputValid: Bool {
        !groupName.isEmpty && // 그룹 이름이 비어있지 않고
        (selectedNudgeHours != 0 || selectedNudgeMinutes != 0) && // Nudge 시간이 0이 아니며
        (selectedGoalHours != 0 || selectedGoalMinutes != 0) // Goal 시간이 0이 아닌지 확인
        // 여기에 추가적인 조건들을 넣을 수 있습니다.
    }
    
    //    private func performGroupUpdateRequest() {
    //        GroupUpdateRequest(title: groupName, timeBudget: finalTotal, nudgeInterval: nudgeTotal)
    //    }
    
    
//    private func performGroupUpdateRequest() {
//        let finalTotal = selectedGoalHours * 60 * 60 + selectedGoalMinutes * 60
//        let nudgeTotal = selectedNudgeHours * 60 * 60 + selectedNudgeMinutes * 60
//        GroupUpdateRequest(title: groupName, timeBudget: finalTotal, nudgeInterval: nudgeTotal)
//    }
//
//    private func performGroupDeleteRequest() {
//        GroupdeleteRequest(title: groupName, timeBudget: finalTotal, nudgeInterval: nudgeTotal)
//    }
    private func performGroupUpdateRequest() {
        let finalTotal = "\(selectedGoalHours * 60 * 60 + selectedGoalMinutes * 60)"
        let nudgeTotal = "\(selectedNudgeHours * 60 * 60 + selectedNudgeMinutes * 60)"
        GroupUpdateRequest(id: selectedLimitItem.id, title: groupName, timeBudget: finalTotal, nudgeInterval: nudgeTotal)
    }

    private func performGroupDeleteRequest() {
        let finalTotal = "\(selectedGoalHours * 60 * 60 + selectedGoalMinutes * 60)"
        let nudgeTotal = "\(selectedNudgeHours * 60 * 60 + selectedNudgeMinutes * 60)"
//        guard let groupId = selectedLimitItem?.id else { return }
        GroupdeleteRequest(id: selectedLimitItem.id, title: groupName, timeBudget: finalTotal, nudgeInterval: nudgeTotal)
    }

    
//    private func setButtons() -> some View{
//        return VStack{
//            Button("수정하기") {
//                performGroupUpdateRequest() // 수정 버튼을 누르면 수정 함수 호출
//
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .frame(height: 56)
//            .background(isInputValid ? Color.primary300 : Color.base200)
//            .font(.headline)
//            .foregroundColor(isInputValid ? Color.black : Color.baseWhite)
//            .cornerRadius(20)
//            .padding(.vertical, 0)
//
//
//            Button("삭제하기") {
//                performGroupDeleteRequest() // 삭제 버튼을 누르면 삭제 함수 호출
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(Color.clear)
//            .foregroundColor(Color.func500)
//            .cornerRadius(20)
//            .font(.headline)
//            .padding(.horizontal, 20)
//
//        }
//        .padding(.vertical, 10)
//    }
    
    private func setSaveButton() -> some View {
        return VStack {
            // '삭제하기' 버튼
            Button("수정하기") {
                performGroupUpdateRequest() // 수정 버튼을 누르면 수정 함수 호출
                isAlertPresented = true // 수정이 완료되면 Alert을 표시하도록 상태를 변경합니다.
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(isInputValid ? Color.primary300 : Color.base200)
            .font(.headline)
            .foregroundColor(isInputValid ? Color.black : Color.baseWhite)
            .cornerRadius(20)
            .padding(.vertical, 0)
            .alert(isPresented: $isAlertPresented) {
                Alert(
                    title: Text("반영 되었습니다."),
                    dismissButton: .default(Text("확인"))
                )
            }
        }
    }

    private func setDeleteButton() -> some View {
        return VStack {
            // '삭제하기' 버튼
            Button("삭제하기") {
                performGroupDeleteRequest() // 삭제 버튼을 누르면 삭제 함수 호출
                isAlertPresented = true
                NavigationView {
                    NavigationLink(destination: MainVCWrapper1()) {
                        Text("MainVC로 이동")
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .foregroundColor(Color.func500)
            .cornerRadius(20)
            .font(.headline)
            .padding(.horizontal, 20)
            .alert(isPresented: $isAlertPresented) {
                Alert(
                    title: Text("삭제 되었습니다."),
                    dismissButton: .default(Text("확인"))
                )
            }
        }
    }

}


// MARK: - Methods
extension SaveLimitVC {
    
    private func isSelectionEmpty() -> Bool {
        tempSelection.applicationTokens.isEmpty &&
        tempSelection.categoryTokens.isEmpty &&
        tempSelection.webDomainTokens.isEmpty
    }
}


//struct ScheduleView_Previews1: PreviewProvider {
//    static var previews: some View {
//        ScheduleView()
//            .environmentObject(ScheduleVM())
//    }
//}


struct MainVCWrapper1: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UINavigationController {
        let mainVC = MainVC() // MainVC 인스턴스 생성
        let navigationController = UINavigationController(rootViewController: mainVC)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // MainVC 업데이트 로직 (필요한 경우)
    }
    
    func popToRootView() {
        presentationMode.wrappedValue.dismiss()
    }
}
