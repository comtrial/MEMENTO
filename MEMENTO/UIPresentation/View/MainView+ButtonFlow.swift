//
//  MainView+ButtonFlow.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/11/10.
//

import SwiftUI

extension MainView {
    func doneContentButtonClicked() {
        viewModel.createContents(content: viewModel.completedTyping)
        
        viewModel.tagEditStatus = false
        print(viewModel.tagEditStatus)
        print("send")
        print("send")
    }
    
    func doneTagButtonClicked() {
        viewModel.updateContentTag(tag: viewModel.completedTyping)
        viewModel.completedTyping = ""
        viewModel.tagEditStatus = false
        print(viewModel.tagEditStatus)
        print("send")
    }
    
    func tagItemButtonClicked(tag: String) {
        viewModel.updateContentTag(tag: tag)
        viewModel.completedTyping = ""
        viewModel.tagEditStatus = false
        print(viewModel.tagEditStatus)
        print("send")
    }
}
extension ContentView {

    func alarmButtonTapped(item: ContentData) -> ActionSheet {
        viewModel.contentDataFocused = item
        let button1: ActionSheet.Button = .default(Text("default".uppercased()))
                let button2: ActionSheet.Button = .destructive(Text("destructive".uppercased()))
                let button3: ActionSheet.Button = .cancel()
                
                let title = Text("action Sheet")
                
                return ActionSheet(title: title,
                                   message: nil,
                                   buttons: [button1, button2, button3])
    }
    
    func tagButtonTapped(item: ContentData) {
        viewModel.contentDataFocused = item
        viewModel.tagEditStatus = true
    }
}
