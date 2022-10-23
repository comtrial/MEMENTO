//
//  MainViewController+OptButton.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/23.
//

import UIKit

extension MainViewController: OptButtonDelegate {
    func didTapNotiButton() {
        let alert = UIAlertController()
        alert.title = "알림 강도 설정"
        
        let none = UIAlertAction(title: "알림 끄기", style: .default, handler: nil)
        let weak = UIAlertAction(title: "잊혀질 때", style: .default, handler: nil)
        let medium = UIAlertAction(title: "희미할 때 (기본)", style: .default, handler: nil)
        let strong = UIAlertAction(title: "선명할 때", style: .default, handler: nil)
        
        alert.addAction(none)
        alert.addAction(strong)
        alert.addAction(medium)
        alert.addAction(weak)
        
        alert.view.tintColor = .darkGray
        
        present(alert, animated: true, completion: nil)
        print("Noti")
    }
    
    func didTapTagButton() {
        print("tag")
    }
}
