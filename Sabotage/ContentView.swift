////
//  ContentView.swift
//  Sabotage
//
//  Created by 박서윤 on 2024/01/04.
//


import UIKit
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var selectedTab = 0 // 선택된 탭을 저장하는 상태 변수
}

struct ContentView: View {
    @ObservedObject var viewModel = MainViewModel() // MainViewModel 인스턴스 생성

    var body: some View {
        NavigationView {
            MainVCRepresentable(viewModel: viewModel, selectedTab: $viewModel.selectedTab)
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
        }
    }
}

public struct MainVCRepresentable: UIViewControllerRepresentable {
    @ObservedObject var viewModel: MainViewModel
    @Binding var selectedTab: Int // SwiftUI로부터 가져온 selectedTab

    class CustomTabBar: UITabBar {
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 100 // 탭 바의 높이 조절
            return sizeThatFits
        }
    }

    public func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()

        let mainVC = MainVC()
        let analysisVC = AnalysisVC()
        let profileVC = ProfileVC()
        
        let mainTag = 0
        let analysisTag = 1
        let profileTag = 2

        // 이미지 설정 부분 변경
        mainVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: viewModel.selectedTab == 0 ? "mainicon" : "mainlogo")?.withRenderingMode(.alwaysOriginal), tag: mainTag)
        analysisVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: viewModel.selectedTab == 1 ? "analysisicon" : "analysislogo")?.withRenderingMode(.alwaysOriginal), tag: analysisTag)
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: viewModel.selectedTab == 1 ? "profileicon" : "profilelogo")?.withRenderingMode(.alwaysOriginal), tag: profileTag)

        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.tabBar.tintColor = .label

        tabBarController.viewControllers = [mainVC, analysisVC, profileVC]

        tabBarController.selectedIndex = viewModel.selectedTab

        let customTabBar = CustomTabBar()
        tabBarController.setValue(customTabBar, forKey: "tabBar")
        
        return tabBarController
    }

    public func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        uiViewController.selectedIndex = viewModel.selectedTab
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, UITabBarControllerDelegate {
        var parent: MainVCRepresentable

        init(_ parent: MainVCRepresentable) {
            self.parent = parent
        }

        public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
                parent.selectedTab = index
                updateTabBarItems(tabBarController: tabBarController) // 탭이 선택될 때마다 이미지 업데이트
            }
            return true
        }

        func updateTabBarItems(tabBarController: UITabBarController) {
            if let viewControllers = tabBarController.viewControllers {
                for (index, viewController) in viewControllers.enumerated() {
                    var imageName = ""
                    switch parent.selectedTab {
                        case 0: // MainVC
                            switch index {
                                case 0:
                                    imageName = "main1"
                                case 1:
                                    imageName = "analysis2"
                                case 2:
                                    imageName = "profile2"
                                default:
                                    break
                            }
                        case 1: // AnalysisVC
                            switch index {
                                case 0:
                                    imageName = "main2"
                                case 1:
                                    imageName = "analysis1"
                                case 2:
                                    imageName = "profile1"
                                default:
                                    break
                            }
                        case 2: // ProfileVC
                            switch index {
                                case 0:
                                    imageName = "main2"
                                case 1:
                                    imageName = "analysis2"
                                case 2:
                                    imageName = "profile1"
                                default:
                                    break
                            }
                        default:
                            break
                    }
                    viewController.tabBarItem.image = UIImage(named: "\(imageName).png")?.withRenderingMode(.alwaysOriginal)
                }
            }
        }

    }
}
