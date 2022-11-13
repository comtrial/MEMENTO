////
////  MainViewController+Button.swift
////  MEMENTO
////
////  Created by 최승원 on 2022/11/02.
////
//
//import UIKit
//
//extension MainViewController {
//    @objc func NavButtonClicked() {
//        print("nav btn clicked")
////        contentsTableView.tableView.scrollToBottom()
////        contentsTableView.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
//    }
//    @objc func SendTextButtonClicked() {
//        let newText = sendTextView.textView.text
//        viewModel.createContents(content: newText ?? "")
//        self.contentsTableView.tableView.reloadData()
////        self.contentsTableView.tableView.scrollToBottom()
//    }
//    
//    @objc func SendTagButtonClicked() {
//        let newText = sendTagView.textView.text
//        print(newText)
//        viewModel.updateContentTag(tag: newText ?? "")
//        self.contentsTableView.tableView.reloadData()
//    }
//    
//}
//
//extension MainViewController: ToolButtonDelegate {
//    func didTapPhotoButton() {
//        print("ddd")
//        presentPickerView()
//    }
//    
//    func didTapCameraButton() {
//        //MARK: https://apcheon.tistory.com/139
//    }
//    
//    func didTapClipBoardButton() {
//        print("clipboard logic")
//        inspectPasteboard()
//    }
//    func inspectPasteboard() {
//            // We are only interested in strings
//            if !UIPasteboard.general.hasStrings {
//                print("noting to copy")
//                return
//            }
//            
//            UIPasteboard.general.detectPatterns(for: [UIPasteboard.DetectionPattern.probableWebURL, UIPasteboard.DetectionPattern.number, UIPasteboard.DetectionPattern.probableWebSearch], completionHandler: {result in
//                
//                switch result {
//                case .success(let detectedPatterns):
//                    print(UIPasteboard.general.string!)
////                    // A pattern detection is completed,
////                    // regardless of whether the pasteboard has patterns we care about.
////                    // So we have to check if the detected patterns contains our patterns.
////
//                    if detectedPatterns.contains(UIPasteboard.DetectionPattern.probableWebURL) {
//                        // Will match if the pasteboard string has a URL within it
//                        print("URL: \( UIPasteboard.general.string!)")
//                        self.viewModel.createURLContent(url: UIPasteboard.general.string!)
//                    }
////                    else if detectedPatterns.contains(UIPasteboard.DetectionPattern.number) {
////                        // Can include currency symbols, decimal places and formulas
////                        // Also true if a string starts with a number, but not if number is in the string
////                        print("Number: \(UIPasteboard.general.string!)")
////                    }
////                    else if detectedPatterns.contains(UIPasteboard.DetectionPattern.probableWebSearch) {
////                        // Very broad, seems to be if the pasteboard contains strings.
////                        // Check any other patterns before this
////                        print("Search: \(UIPasteboard.general.string!)")
////                    }
////                    else {
////                        // We won't be retrieving the value, so we won't get a notification banner
////                        self.pasteboardContents = "Not something we want to deal with"
////                    }
//                    else {
//                        print("text: \( UIPasteboard.general.string!)")
//                    }
//                case .failure(let error):
//                    // This never gets called
//                    print("clipboard err")
//                    print(error.localizedDescription)
//                }
//                
//            })
//        }
//}
//
//// MARK: Content Option Button
//extension MainViewController: NewOptButtonDelegate {
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
//
//// MARK: Content Tag Button
//extension MainViewController: TagButtonDelegate {
//    func didTapTagButton(newTag: String) {
//        viewModel.updateContentTag(tag: newTag ?? "")
//    }
//}
