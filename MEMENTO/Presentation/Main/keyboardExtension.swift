//
//  keyboardExtension.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/20.
//

import UIKit

// MARK: sendTextView Placeholder
extension MainViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == sendTextView.typingPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = sendTextView.typingPlaceholder
            textView.textColor = .gray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let currentText: String = textView.text else { return }
        
        if currentText != sendTextView.typingPlaceholder && !currentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            sendTextView.button.backgroundColor = .black
        } else {
            sendTextView.button.backgroundColor = .lightGray
        }
    }
}

// MARK: slide up SendTextView when keyboard show
extension MainViewController {
    @objc func keyboardWillHide(notification: NSNotification) {
        let sendTextViewHeight = self.sendTextView.frame.height
        self.sendTextView.frame.origin.y = view.frame.height - sendTextViewHeight
        
//        self.contentsTableView.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextView else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        if textFieldBottomY > keyboardTopY {
            let sendTextViewHeight = self.sendTextView.frame.height
            let newFrameY = (keyboardTopY - sendTextViewHeight + 36)
            self.sendTextView.frame.origin.y = newFrameY
    
        }
    }
    
    func setupKeyboardHiding() {
        print("keyboard setup done")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
