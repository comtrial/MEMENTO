////
////  MainViewController+OptButton.swift
////  MEMENTO
////
////  Created by 최승원 on 2022/10/23.
////
//
//import UIKit
//
//extension MainViewController: OptButtonDelegate {
//    func didTapNotiButton(item: ContentData) {
//        let alert = UIAlertController()
//        alert.title = "알림 강도 설정"
//        
//        // MARK: need refact to Enum type
//        let alertDict: [String: Double] = [
//            "알림 끄기": 0,
//            "잊혀질 때": 1,
//            "희미할 때 (기본)": 2,
//            "선명할 때": 3
//        ]
//        
//        let notiAlertHandler = { (action: UIAlertAction) -> () in
//            self.viewModel.updateContentNoti(contentData: item, notiDuration: alertDict[action.title!] ?? 2)
//        }
//        
//        let none = UIAlertAction(title: "알림 끄기", style: .default, handler: notiAlertHandler)
//        let weak = UIAlertAction(title: "잊혀질 때", style: .default, handler: notiAlertHandler)
//        let medium = UIAlertAction(title: "희미할 때 (기본)", style: .default, handler: notiAlertHandler)
//        let strong = UIAlertAction(title: "선명할 때", style: .default, handler: notiAlertHandler)
//        
//        alert.addAction(none)
//        alert.addAction(strong)
//        alert.addAction(medium)
//        alert.addAction(weak)
//        
//        alert.view.tintColor = .darkGray
//        
//        present(alert, animated: true, completion: nil)
//    }
//    
//    func didTapTagButton(item: ContentData) {
//        viewModel.contentDataFocused = item
//        viewModel.tagEditStatus.toggle()
//        print("tag")
//    }
//}
