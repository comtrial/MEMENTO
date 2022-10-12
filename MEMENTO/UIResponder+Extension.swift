//
//  UIResponder+Extension.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/10.
//

import UIKit

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
