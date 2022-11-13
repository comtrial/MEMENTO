//
//  ContentView.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/11/10.
//

import SwiftUI
import UIKit
import LinkPresentation

struct ContentView: View {
    @StateObject var viewModel = MainViewModel()
    @State var openAlarmPicker = false
    @State private var selection = "None"

    var content: ContentData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(DateStringFormatter(date: content.date!).getContentTimeComment())
                .font(.system(size: 12, weight: .regular))
            
            Spacer()
                .frame(height: 4)
            
            // MARK: ContentView
            if content.type == "image" {
                let uiImage = UIImage(data: content.image!)
                Image(uiImage: uiImage!)
                    .resizable()
                    .frame(width: 150, height: 150)
            } else if content.type == "url" {
                MetadataView(vm: LinkViewModel(link: content.content!))
            }
            else {
                Text(content.content!)
                    .font(.system(size: 14, weight: .regular))
            }
            
            // MARK: OptionView
            
            HStack {
                Button(action: {
                    openAlarmPicker = true
                    alarmButtonTapped(item: content)
                    
                }){
                    Image(systemName: "alarm")
                        .foregroundColor(.black)
                }
                .padding(4)
                .background(Color.gray)
                .cornerRadius(8)
                .actionSheet(isPresented: $openAlarmPicker, content: getAlarmActionSheet)
                
                if content.tag != nil {
                    Button(action: {tagButtonTapped(item: content)}){
                        HStack {
                            Image(systemName: "tag")
                                .foregroundColor(.black)
                            Text(content.tag!)
                                .foregroundColor(Color.black)
                                .font(.system(size: 12, weight: .light))
                        }
                        
                    }
                    .padding(4)
                    .background(Color.gray)
                    .cornerRadius(8)
                } else {
                    Button(action: {tagButtonTapped(item: content)}){
                        Image(systemName: "tag")
                            .foregroundColor(.black)
                    }
                    .padding(4)
                    .background(Color.gray)
                    .cornerRadius(8)
                }

            }
        }
    }
    
    func getAlarmActionSheet() -> ActionSheet {
        let alertDict: [String: Double] = [
                    "알림 끄기": 0,
                    "잊혀질 때": 1,
                    "희미할 때 (기본)": 2,
                    "선명할 때": 3
                ]
        // MARK: need refact to Enum type
       
        
        let button1: ActionSheet.Button = .default(Text("알림 끄기").foregroundColor(Color.black).font(.system(size: 5))){
            viewModel.updateContentNoti(contentData: content, notiDuration: nil)
            print("알림 끄기")
        }
        
        let button2: ActionSheet.Button = .default(Text("잊혀질 때")){
            print("알림 끄기")
            viewModel.updateContentNoti(contentData: content, notiDuration: 1)
        }
        
        let button3: ActionSheet.Button = .default(Text("희미할 때 (기본)")){
            print("알림 끄기")
            viewModel.updateContentNoti(contentData: content, notiDuration: 2)
        }
        
        let button4: ActionSheet.Button = .default(Text("선명할 때")){
            print("알림 끄기")
            viewModel.updateContentNoti(contentData: content, notiDuration: 3)
        }
        
        
        let button5: ActionSheet.Button = .cancel(Text("취소"))
        
        let title = Text("action Sheet")
        
        return ActionSheet(title: title,
                           message: nil,
                           buttons: [button1, button2, button3, button4, button5])
    }
    
}

class LinkViewModel : ObservableObject {
    let metadataProvider = LPMetadataProvider()
    @Published var linkString: String?
    @Published var metadata: LPLinkMetadata?
    @Published var image: UIImage?
    
    init(link : String) {
        self.linkString = link
        guard let url = URL(string: link) else {
            return
        }
        
        LPMetadataProvider().startFetchingMetadata(for: url) { (linkMetadata, error) in
            guard let linkMetadata = linkMetadata, let imageProvider = linkMetadata.iconProvider else { return }

            print(linkMetadata.title ?? "Untitled")

            imageProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                guard error == nil else {
                    // handle error
                    return
                }

                if let image = image as? UIImage {
                    // do something with image
                    DispatchQueue.main.async {
                        self.image = image
                    }
                } else {
                    print("no image available")
                }
            }
        }
    }
}

struct MetadataView : View {
    @StateObject var vm : LinkViewModel
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 10)
                .background(Color.black)
            HStack(alignment: .top) {
                HStack {
                    Text(vm.linkString!)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color.blue)
                    
                    if let metadata = vm.metadata {
                        let _ = print(metadata.title!)
                        let _ = print("++++++++++++++++++++")
                        Text(metadata.title!)
                    }
                }

                Spacer()
                
                if let uiImage = vm.image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 60, height: 60)
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 0).fill(Color.gray).mask(    // << here !!
              HStack {
                  Rectangle().frame(width: 2)
                  Spacer()
              }
          )
        )

       
    }
}
