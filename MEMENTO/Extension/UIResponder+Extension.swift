//
//  UIResponder+Extension.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/10.
//

import UIKit

extension UIViewController {
    // MARK: 다른 곳 터치시 editor 종료 시점 알리기 -> 키보드 내리기 등에서 사용가능 할 듯
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        print("click outside")
    }
}

//extension UIView {
//    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        endEditing(true)
//        
//        print("click outside")
//    }
//}

extension UIResponder {
    private struct Static {
        static weak var responser: UIResponder?
    }
    
    static func currentFirst() -> UIResponder? {
        Static.responser = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        
        return Static.responser
    }
    
    @objc private func _trap() {
        Static.responser = self
    }
}
