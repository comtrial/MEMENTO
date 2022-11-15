//
//  TypingView.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/11/10.
//

import SwiftUI


//struct TypingView: View {
extension MainView {
    var typingView: some View {
        VStack(alignment: .leading) {
            if viewModel.tagEditStatus {
                typingTagView
            } else {
                typingContentView
            }
        }
    }
}

extension MainView {
    var typingTagView: some View {
        VStack {
            ScrollView( .horizontal) {
                HStack {
                    ForEach(viewModel.contentTags, id: \.self) { tag in
                        Button(action: {
                            tagItemButtonClicked(tag: tag)
                            print("dd")
                        }){
                            Text(tag)
                                .font(.system(size: 12))
                        }
                        .padding(4)
                        .background(Color.gray)
                        .foregroundColor(Color.black)
                        .cornerRadius(4)
                        
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
            }
            HStack {
                TextField("태그를 입력하세요", text: $viewModel.completedTyping)
                    .font(.system(size: 15))
                    .padding()
            
                Button(action: { doneTagButtonClicked()}) {
                        Text("태그입력")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color.black)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
            }
            .background(Color(uiColor: .secondarySystemBackground))
            .frame(height: 50)
            .cornerRadius(10)
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
        }
       
    }
}


extension MainView {
    var typingContentView: some View {
        HStack {
            TextField("어떤 기록을 남기시나요?", text: $viewModel.completedTyping)
                .font(.system(size: 15))
                .padding()
            
            if viewModel.completedTyping == "" {
                HStack {
                    Button(action: {
                        self.openPhotoPicker = true
                    }){
                        Image(systemName: "photo")
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $openPhotoPicker) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image, viewModel: viewModel)
                    }
                    .padding(4)
                    
                    Button(action: {}){
                        Image(systemName: "camera")
                            .foregroundColor(.black)
                    }
                    .padding(4)
                    
                    Button(action: {
                        didTapClipBoardButton()
                    }){
                        Image(systemName: "doc.on.doc")
                            .foregroundColor(.black)
                    }
                    .padding(4)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
                
            } else {
                Button(action: { doneContentButtonClicked()}) {
                    Text("기록하기")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color.black)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
            }
            
            
        }
        .background(Color(uiColor: .secondarySystemBackground))
        .frame(height: 50)
        .cornerRadius(10)
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }
    
    func didTapClipBoardButton() {
        print("clipboard logic")
        inspectPasteboard()
    }
    func inspectPasteboard() {
            // We are only interested in strings
            if !UIPasteboard.general.hasStrings {
                print("noting to copy")
                return
            }
            
            UIPasteboard.general.detectPatterns(for: [UIPasteboard.DetectionPattern.probableWebURL, UIPasteboard.DetectionPattern.number, UIPasteboard.DetectionPattern.probableWebSearch], completionHandler: {result in
                
                switch result {
                case .success(let detectedPatterns):
                    print(UIPasteboard.general.string!)
//                    // A pattern detection is completed,
//                    // regardless of whether the pasteboard has patterns we care about.
//                    // So we have to check if the detected patterns contains our patterns.
//
                    if detectedPatterns.contains(UIPasteboard.DetectionPattern.probableWebURL) {
                        // Will match if the pasteboard string has a URL within it
                        print("URL: \( UIPasteboard.general.string!)")
                        viewModel.completedTyping = UIPasteboard.general.string!
                        
                        self.viewModel.createURLContent(url: UIPasteboard.general.string!)
                    }
//                    else if detectedPatterns.contains(UIPasteboard.DetectionPattern.number) {
//                        // Can include currency symbols, decimal places and formulas
//                        // Also true if a string starts with a number, but not if number is in the string
//                        print("Number: \(UIPasteboard.general.string!)")
//                    }
//                    else if detectedPatterns.contains(UIPasteboard.DetectionPattern.probableWebSearch) {
//                        // Very broad, seems to be if the pasteboard contains strings.
//                        // Check any other patterns before this
//                        print("Search: \(UIPasteboard.general.string!)")
//                    }
//                    else {
//                        // We won't be retrieving the value, so we won't get a notification banner
//                        self.pasteboardContents = "Not something we want to deal with"
//                    }
                    else {
//                        $viewModel.completedTyping = UIPasteboard.general.string!
                        print("Ho")
                        print("text: \( UIPasteboard.general.string!)")
                    }
                case .failure(let error):
                    // This never gets called
                    print("clipboard err")
                    print(error.localizedDescription)
                }
                
            })
        }
}
