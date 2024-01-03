//
//  ScheduleView.swift
//  Sabotage
//
//  Created by 김하람 on 12/31/23.
//

import SwiftUI
import FamilyControls
/**
 
 1. 권한 설정 확인할 수 있어야함
 2. 스케쥴 설정(시간 설정)
 3. 앱 설정
 4. 설정한 스케쥴 및 앱 설정을 바탕으로 모니터링 스케쥴 만들기
 
 */

struct ScheduleView: View {
    @EnvironmentObject var scheduleVM: ScheduleVM
    @State var tempSelection = FamilyActivitySelection()
    
    @State private var selectedGoalTime = Date()
    @State private var selectedNudgeTime = Date()
    @State private var isGoalPickerPresented = false
    @State private var isGoalTimePickerShown = false
    @State private var isNudgePickerPresented = false
    @State private var isNudgeTimePickerShown = false
    
    
    @State private var selectedGoalHours = 0
    @State private var selectedGoalMinutes = 0
    @State private var selectedNudgeHours = 0
    @State private var selectedNudgeMinutes = 0
    @State var groupName = ""
    
    @State private var selectedMinute: Int = 0
    let minutes = Array(0...59)
    let hours = Array(0...23)
    var body: some View {
        NavigationView {
            VStack {
                setupListView().background(Color.base50)
//                setButtons()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar { savePlanButtonView() }
            .navigationTitle("제한 습관")
            .navigationBarTitleDisplayMode(.inline)
            .familyActivityPicker(
                isPresented: $scheduleVM.isFamilyActivitySectionActive,
                selection: $tempSelection
            )
            .alert("저장 되었습니다.", isPresented: $scheduleVM.isSaveAlertActive) {
                Button("OK", role: .cancel) {}
            }
        }
        .onAppear {
            tempSelection = scheduleVM.selection
        }
    }
}

// MARK: - Views
extension ScheduleView {
    private func savePlanButtonView() -> ToolbarItemGroup<some View> {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            let BUTTON_LABEL = "저장"
            
            Button(action: {
                scheduleVM.saveSchedule(selectedApps: tempSelection)
            }) {
                Text(BUTTON_LABEL).foregroundColor(isInputValid ? Color.primary700 : Color.base200).font(.headline)
            }
            .padding(.trailing, 8) // 오른쪽에 패딩 추가
        }
    }
    
    private func setupListView() -> some View {
        List {
            setUpGroupTextField()
            setUPAppSectionView()
            setUpGoalTimeView(selectedTime: $selectedGoalTime, isPickerPresented: $isGoalPickerPresented)
            setUpNudgeTimeView(selectedTime: $selectedNudgeTime, isPickerPresented: $isNudgePickerPresented)
            setButtons().listRowInsets(EdgeInsets()).padding(0).listRowBackground(Color.clear)
        }.background(Color.base50)
            .scrollContentBackground(.hidden)
        .listStyle(.insetGrouped)
        .padding(.horizontal, 5).fullScreenCover(isPresented: $isGoalPickerPresented) {
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
                TextField("그룹 1", text: $groupName)
                    .font(.system(size: 18))
                    .foregroundColor(Color.base400)
                    .padding()
                    .padding(.leading, -20)
                    .background(Color.base100)
                    .frame(height: 40)
                
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
            formatter.dateFormat = "HH 'Hours' mm 'min'" // 24시간 형식에 "Hours", "min"을 추가합니다.
            return formatter
        }()
        
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
                        //                        Text(timeFormatter.string(from: selectedTime.wrappedValue))
                        Text("\(selectedGoalHours) hours \(selectedGoalMinutes) min")
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical)
                
                if isGoalTimePickerShown {
                    ZStack {
                        // 카운트다운 타이머
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
//                        Image("GreenFrame") .resizable()
//                            .scaledToFit()
                    }
                }
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
    private func setButtons() -> some View{
        return VStack{
            Button("저장하기") {
                if isInputValid {
                    let finalTotal = selectedGoalHours * 60 * 60 + selectedGoalMinutes * 60
//                    scheduleVM.saveSchedule(selectedApps: tempSelection, totalLimitTime: finalTotal)
                    let nudgeTotal = selectedNudgeHours * 60 * 60 + selectedNudgeMinutes
                    
//                    scheduleVM.finalGoalTime = finalTotal
//                    print("goalTime = \(scheduleVM.finalGoalTime)")
                    scheduleVM.saveSchedule(selectedApps: tempSelection)
                    print("finalTotal = \(finalTotal)")
                    print("tempSelection = \(tempSelection)")
                    print("selectedNudge = \(selectedNudgeHours):\(selectedNudgeMinutes)")
                    print("selectedGoalHours = \(selectedGoalHours):\(selectedGoalMinutes)")
                    print("🔥 appList = \(tempSelection)")
                    // Assuming 'ApplicationToken' conforms to 'CustomStringConvertible' or has a method to return a string
                    let appNames = tempSelection.applicationTokens.map { token in
                        
                        // Replace 'tokenDescription' with the actual property or method that provides a string representation
                        return String(token.hashValue)
                    }
                    print("🔥 🔥 🔥  \(appNames) 🔥 🔥 🔥 ")
                    // Now, 'appNames' is an array of strings that you can send to your server
//                    goalPostRequest(title: groupName, apps: appNames, timeBudget: finalTotal)

//                    let appNames = tempSelection.applicationTokens.map { $0. }
//                    print("🙌🏻 appNames = \(appNames)")
//                    goalPostRequest(title: groupName, apps: <#T##[String]#>, timeBudget: finalTotal, nudgeInterval: nudgeTotal)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(isInputValid ? Color.primary300 : Color.base200)
            .font(.headline)
            .foregroundColor(isInputValid ? Color.black : Color.baseWhite)
            .cornerRadius(20)
            .padding(.vertical, 0)
            // 두 번째 버튼
            Button("삭제하기") {
                //함수
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .foregroundColor(Color.func500)
            .cornerRadius(20)
            .font(.headline)
            .padding(.horizontal, 20)
            
        }
        .padding(.vertical, 10)
    }
    private func setDeleteButton() -> some View{
        return VStack {
            Button("삭제하기") {
                // '삭제하기' 버튼의 액션을 여기에 작성
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.func500)
            .font(.headline)
            .padding(.bottom, 25)
            .frame(height: 40)
        }
        .listRowBackground(Color.clear)
    }
}


// MARK: - Methods
extension ScheduleView {
    
    private func isSelectionEmpty() -> Bool {
        tempSelection.applicationTokens.isEmpty &&
        tempSelection.categoryTokens.isEmpty &&
        tempSelection.webDomainTokens.isEmpty
    }
    
}

// MARK: - 기존 시간 설정 코드
//private func setUpTimeSectionView() -> some View {
//        let TIME_LABEL_LIST = ["시작 시간", "종료 시간"]
//        let times = [$scheduleVM.scheduleStartTime, $scheduleVM.scheduleEndTime]
//
//        return Section(
//            header: Text(ScheduleSectionInfo.time.header),
//            footer: Text(ScheduleSectionInfo.time.footer)) {
//                ForEach(0..<TIME_LABEL_LIST.count, id: \.self) { index in
//                    DatePicker(selection: times[index], displayedComponents: .hourAndMinute) {
//                        Text(TIME_LABEL_LIST[index])
//                    }
//                }
//            }
//    }

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
            .environmentObject(ScheduleVM())
    }
}

