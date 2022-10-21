//
//  MainViewModel.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/20.
//

import Foundation
import Combine

class MainViewModel {
    let repository = ContentRepository.shared
    var subscriber: Set<AnyCancellable> = .init()
    
    @Published var loading: Bool = true
    @Published var contentMocks: [Content] = []
    @Published var contents: [ContentData] = []
    
    func fetchMockContents() {
        let contents = ContentMockData.mockData
        print(contents)
        self.contentMocks = contents
        return
    }
    
    func fetchContents() {
        repository.fetchContentDataPublisher().sink { completion in
            switch completion  {
            case .failure(let error):
                print("err: \(error)")
            case .finished:
                break
            }
        } receiveValue: { contents in
            self.contents = contents
            self.loading = false
            print(contents)
        }.store(in: &subscriber)
    }
    
    //TODO: 데이터 생성 후 flow 다듬어야해
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
            self.contents.append(contentData)
            self.loading = false
        }.store(in: &subscriber)
    }
    
    func createMockContents(text: String) {
        let newContent = Content(text: text)
        contentMocks.append(newContent)
    }
}
