//
//  MainViewModel.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/11/10.

import UIKit
import SwiftUI
import Combine
import UserNotifications

class MainViewModel: ObservableObject {
    //TODO: Definitely need to divide Notification flow
    let userNotiCenter = UNUserNotificationCenter.current()
    let repository = ContentRepository.shared
    var subscriber: Set<AnyCancellable> = .init()
    
    // MARK: SwiftUI migration
    @Published var contents: [ContentData] = []
    var contentDataFocused: ContentData?
    var dateTime: Date?
    
    // Typing View Property
    @Published var completedTyping: String = ""
    let tagPlaceHolder = ""
    
    
  

    
    @Published var loading: Bool = true
    @Published var tagEditStatus: Bool = false
//    @Published var contentMocks: [Content] = []
    @Published var contentStates: [Bool] = []
    @Published var contentTags: [String] = []
    
    init() {
        self.fetchContents()
        print("개씨발")
        print(contents)
    }
    
    func toggleTagStatus() {
        self.tagEditStatus = !self.tagEditStatus
        print(self.tagEditStatus)
    }
    
    func fetchContents() {
        print("fetch called")
        repository.fetchContentDataPublisher().sink { completion in
            switch completion  {
            case .failure(let error):
                print("err: \(error)")
            case .finished:
                break
            }
        } receiveValue: { contents in
            print("개씨발  receive 까지도 된건데")
            print(contents)
            self.contents = contents
            self.dateTime = contents.first?.date
            
            self.setContentStates()
            self.getTags(contents: contents)
            self.loading = false
        }.store(in: &subscriber)
    }
    
    //TODO: 데이터 생성 후 flows 다듬어야해
    func createContents(content: String) {
        repository.createContentData(content: content).sink{ completion in
            switch completion {
            case .failure(let error):
                print("err \(error)")
                debugPrint("an error occurred \(error.localizedDescription)")
            case .finished:
                break
            }
        } receiveValue: { contentData in
            print(contentData)
            self.contents.insert(contentData, at: 0)
//            self.contentStates.append(true)
            self.loading = false
        }.store(in: &subscriber)
    }
    
    func createImageContent(imageContent: UIImage) {
        repository.createImageContentData(imageContent: imageContent).sink{ completion in
            switch completion {
            case .failure(let error):
                print("err \(error)")
                debugPrint("an error occurred \(error.localizedDescription)")
            case .finished:
                break
            }
        } receiveValue: { contentData in
            print(contentData)
            self.contents.insert(contentData, at: 0)
//            self.contentStates.append(false)
            self.loading = false
        }.store(in: &subscriber)
    }
    
    func createURLContent(url: String) {
        repository.createURLContentData(url: url).sink{ completion in
            switch completion {
            case .failure(let error):
                print("err \(error)")
                debugPrint("an error occurred \(error.localizedDescription)")
            case .finished:
                break
            }
        } receiveValue: { contentData in
            print(contentData)
            self.contents.insert(contentData, at: 0)
//            self.contentStates.append(true)
            self.loading = false
        }.store(in: &subscriber)
    }
    
    func deleteContent(contentData: ContentData) {
        repository.deleteContentData(id: contentData.objectID).sink{ completion in
            switch completion {
            case .failure(let error):
                print("err \(error)")
                debugPrint("an error occurred \(error.localizedDescription)")
            case .finished:
                break
            }

        } receiveValue: { contentData in
            print(contentData)
            self.loading = false
        }.store(in: &subscriber)
    }
    
    func updateContentNoti(contentData: ContentData, notiDuration: Double?) {
        repository.updateContentNoti(id: contentData.objectID, notiDuration: "noti duration test").sink{ completion in
            switch completion {
            case .failure(let error):
                print("err \(error)")
                debugPrint("an error occurred \(error.localizedDescription)")
            case .finished:
                break
            }
        } receiveValue: { contentData in
            print(contentData)
            self.registerContentNoti(item: contentData, notiDuration: notiDuration)
            self.loading = false
        }.store(in: &subscriber)
    }
    
    func updateContentTag(tag: String) {
        print(contentDataFocused)
        print(tag)
        repository.updateContentTag(id: contentDataFocused!.objectID, tag: tag).sink{ completion in
            switch completion {
            case .failure(let error):
                print("err \(error)")
                debugPrint("an error occurred \(error.localizedDescription)")
            case .finished:
                break
            }

        } receiveValue: { contentData in
            self.loading = false
        }.store(in: &subscriber)
    }
}

extension MainViewModel {
    func registerContentNoti(item: ContentData, notiDuration: Double?) {
        //TODO: add noti cancel process
        let notiContent = UNMutableNotificationContent()

        notiContent.title = "메멘토 알림"
        notiContent.body = item.content! + "\(notiDuration) 을 곁들인.."
        notiContent.userInfo = ["targetScene": "splash"] // 푸시 받을때 오는 데이터
        print(notiDuration)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notiDuration!, repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notiContent,
            trigger: trigger
        )

        userNotiCenter.add(request) { (err) in
            print("noti 등록 err 발생")
            print(#function, err)
        }
    }
    
    func getTags(contents: [ContentData]) {
        self.contentTags = contents
            .filter{ $0.tag != nil}
            .map({$0.tag!})
            .unique()
    }
    
    func setContentStates() {
        for _ in 0..<self.contents.count {
            contentStates.append(false)
        }
    }
}
