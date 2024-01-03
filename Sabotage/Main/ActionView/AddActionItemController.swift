//  AddActionItemController.swift
//  Sabotage
//
//  Created by 오성진 on 12/27/23.
//

import UIKit
import SnapKit

class AddActionItemController: UIViewController, UITextFieldDelegate {
    
    var selectedCard: Int = 0
    
    // MARK: 변수
//    let backButton = UIButton(type: .system)
    let Title = UIImageView(image: UIImage(named: "action_title.png"))
    let tracker2 = UIImageView(image: UIImage(named: "action_tracker2.png"))
    let subtitle = UIImageView(image: UIImage(named: "addaction_subtitle.png"))
    let category1 = UIImageView(image: UIImage(named: "addaction_category1.png"))
    let inputItem = UIImageView(image: UIImage(named: "addaction_inputitem.png"))

    let inputField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "예) 자리에 앉기"
        textField.backgroundColor = .clear // Set the background color to clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let backButton: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "addaction_backbutton.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let completeButton = UIImageView(image: UIImage(named: "addaction_completebuttonUntapped.png"))

    
    // MARK: UI
    func setUI() {
        Title.contentMode = .center
        Title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(Title)
        
        tracker2.contentMode = .scaleAspectFit
        tracker2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tracker2)
        
        subtitle.contentMode = .scaleAspectFit
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitle)
        
        category1.contentMode = .scaleAspectFit
        category1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(category1)
        
        inputItem.contentMode = .scaleAspectFit
        inputItem.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputItem)
        
        view.addSubview(inputField)
        view.addSubview(backButton)
        
        completeButton.contentMode = .scaleAspectFit
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(completeButton)

        
    }
    
    // MARK: constraint
    func setConstraint() {
        NSLayoutConstraint.activate([
    
            Title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            Title.widthAnchor.constraint(equalToConstant: 80),
            Title.heightAnchor.constraint(equalToConstant: 25),
            
            tracker2.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            tracker2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tracker2.widthAnchor.constraint(equalToConstant: 415),
            tracker2.heightAnchor.constraint(equalToConstant: 50),
            
            subtitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            subtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            subtitle.widthAnchor.constraint(equalToConstant: 280),
            subtitle.heightAnchor.constraint(equalToConstant: 120),
            
            category1.topAnchor.constraint(equalTo: view.topAnchor, constant: 288),
            category1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            category1.widthAnchor.constraint(equalToConstant: 370),
            category1.heightAnchor.constraint(equalToConstant: 90),
            
            inputItem.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            inputItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputItem.widthAnchor.constraint(equalToConstant: 370),
            inputItem.heightAnchor.constraint(equalToConstant: 120),
            
            inputField.topAnchor.constraint(equalTo: inputItem.topAnchor, constant: 10),
            inputField.leadingAnchor.constraint(equalTo: inputItem.leadingAnchor, constant: 10),
            inputField.trailingAnchor.constraint(equalTo: inputItem.trailingAnchor, constant: -10),
            inputField.bottomAnchor.constraint(equalTo: inputItem.bottomAnchor, constant: -10),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -215),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 70),
            
            
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 215),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            completeButton.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        setConstraint()
        
        print("Selected card: \(selectedCard)")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButton.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture1.cancelsTouchesInView = false // Allow touch events to pass through the view hierarchy
        view.addGestureRecognizer(tapGesture1)
       
        let completeTapGesture = UITapGestureRecognizer(target: self, action: #selector(completeButtonTapped))
        completeButton.isUserInteractionEnabled = true
        completeButton.addGestureRecognizer(completeTapGesture)
        
        inputField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // Dismiss the keyboard
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func completeButtonTapped() {
        guard let buttonImage = completeButton.image,
              buttonImage == UIImage(named: "addaction_completebutton.png") else {
            // If the image is not "addaction_completebutton.png", do nothing
            return
        }

        // Navigate back to MainVC
        if let navigationController = navigationController {
            for controller in navigationController.viewControllers {
                if controller is MainVC {
                    navigationController.popToViewController(controller, animated: true)
                    return
                }
            }
        }

        // If MainVC is not found in the navigation stack, you can create and present a new instance
        let mainVC = MainVC() // Create a new instance of MainVC
        navigationController?.pushViewController(mainVC, animated: true) // Present MainVC
    }

    
    @objc func textFieldDidChange(_ textField: UITextField) {
            if let text = textField.text, !text.isEmpty {
                completeButton.image = UIImage(named: "addaction_completebutton.png")
            } else {
                completeButton.image = UIImage(named: "addaction_completebuttonUntapped.png")
            }
        }
    
}
