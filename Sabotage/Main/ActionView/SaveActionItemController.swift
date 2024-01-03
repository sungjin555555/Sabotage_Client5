//
//  SaveActionItemController.swift
//  Sabotage
//
//  Created by 오성진 on 12/27/23.
//

import UIKit
import SnapKit

class SaveActionItemController: UIViewController, UITextFieldDelegate {

    var textField: UITextField = UITextField()
    var selectedButtonName: String = "" // 선택된 버튼의 이름을 저장하는 변수

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // "X" 버튼 추가
        let closeButton = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        
        // "명상" 텍스트를 보여줄 레이블 생성
        let meditationLabel = UILabel()
        meditationLabel.text = "명상"
        meditationLabel.textAlignment = .center
        meditationLabel.font = UIFont.boldSystemFont(ofSize: 24)
        meditationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이블을 뷰에 추가
        view.addSubview(meditationLabel)
        
        // Auto Layout을 사용하여 레이블을 페이지 중앙에 위치시킴
        NSLayoutConstraint.activate([
            meditationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            meditationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
        
        // "알겠습니다" 텍스트를 보여줄 레이블 생성
        let categoryLabel = UILabel()
        categoryLabel.text = "카테고리"
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont.systemFont(ofSize: 18)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이블을 뷰에 추가
        view.addSubview(categoryLabel)
        
        // Auto Layout을 사용하여 레이블을 "명상" 텍스트 아래에 위치시킴
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: meditationLabel.bottomAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
        
        // 사용자가 입력할 수 있는 텍스트 필드 생성
        let textField = UITextField()
        textField.placeholder = "운동"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // 텍스트 필드를 뷰에 추가
        view.addSubview(textField)
        
        // 여기가 중요
        textField.delegate = self
        
        // Auto Layout을 사용하여 텍스트 필드를 "알겠습니다" 텍스트 아래에 위치시킴
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        // "알겠습니다" 텍스트를 보여줄 레이블 생성
        let updateLabel = UILabel()
        updateLabel.text = "액션 아이템"
        updateLabel.textAlignment = .center
        updateLabel.font = UIFont.systemFont(ofSize: 18)
        updateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이블을 뷰에 추가
        view.addSubview(updateLabel)
        
        // Auto Layout을 사용하여 레이블을 "명상" 텍스트 아래에 위치시킴
        NSLayoutConstraint.activate([
            updateLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            updateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
        
        // 사용자가 입력할 수 있는 텍스트 필드 생성
        let textField2 = UITextField()
        textField2.placeholder = "책읽기"
        textField2.borderStyle = .roundedRect
        textField2.translatesAutoresizingMaskIntoConstraints = false
        
        // 텍스트 필드를 뷰에 추가
        view.addSubview(textField2)
        
        // 여기가 중요
        textField2.delegate = self
        
        // Auto Layout을 사용하여 텍스트 필드를 "알겠습니다" 텍스트 아래에 위치시킴
        NSLayoutConstraint.activate([
            textField2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField2.topAnchor.constraint(equalTo: updateLabel.bottomAnchor, constant: 20),
            textField2.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("저장하기", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 15
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            saveButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("삭제하기", for: .normal)
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.backgroundColor = .systemGray6
        deleteButton.layer.cornerRadius = 15
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        // 다른 화면을 탭할 때
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard(sender:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    // UITextFieldDelegate 메서드 구현, textfield에 작성한 내용 콘솔로 가져오기.
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            self.textField.text = text
            print("사용자가 입력한 텍스트: \(text)")
        }
    }
    
    // Delegate를 통해 MainVC로 텍스트 이동되었는지 콘솔에서 확인
    @objc func completeButtonTapped() {
        var selectedCategory:String = ""
        guard let text = self.textField.text else {
            print("입력된 텍스트가 비어 있습니다.")
            return
        }

//        delegate?.didAddActionItemText(text)
        
        print("⚽️ MainVC로 전달된 텍스트: \(text)") // 사용자가 작성한 목표 출력
        print("🫶 final")
        print("🫶 category = \(selectedButtonName)")
        print("🫶 text = \(text)")
//        actionPostRequest(with: selectedCategory, content: text)
        let mainVC = MainVC()
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // "X" 버튼 액션
    @objc func closeButtonTapped() {
        let gotoMainController = MainVC()
        navigationController?.pushViewController(gotoMainController, animated: true)
    }
    
    // 다른 곳을 탭했을 때 키보드 숨기기
    @objc func dismissKeyBoard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func saveButtonTapped() {
        let saveActionItemController = MainVC()
        navigationController?.pushViewController(saveActionItemController, animated: true)
    }
    
    @objc func deleteButtonTapped() {
        let alert = UIAlertController(title: "정말 삭제하시겠어요?", message: "삭제하면 다시 불러올 수 없어요", preferredStyle: .alert)

        // 취소 버튼
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        // 삭제 버튼
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            // 삭제 작업 수행
        }))
        present(alert, animated: true, completion: nil)
    }

}
