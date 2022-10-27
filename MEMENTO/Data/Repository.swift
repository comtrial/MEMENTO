//
//  Repository.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/21.
//

import UIKit
import CoreData
import Combine

final class ContentRepository {
    
    static let shared = ContentRepository()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    let modelName: String = "ContentData"
    
    
    // MARK: - Read
    func fetchContentDataPublisher() -> AnyPublisher<[ContentData], Error> {
        Deferred { [context] in
            Future { promise in
                context?.perform {
                    let request = NSFetchRequest<NSManagedObject> (entityName:self.modelName)
                    let dataOrder = NSSortDescriptor(key: "date", ascending: true)
                    request.sortDescriptors = [dataOrder]
                    
                    do {
                        let results = try context?.fetch(request) as! [ContentData]
                        promise(.success(results))
                    } catch {
                        promise(.failure(error))
                    }
                    
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    
    // MARK: - [Create]
    func createContentData(content: String?) -> AnyPublisher<ContentData, Error> {
        Deferred { [context] in
            Future  { promise in
                context?.perform {
                    if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context!) {
                        if let contentData = NSManagedObject(entity: entity, insertInto: context) as? ContentData {
                            contentData.content = content
                            contentData.date = Date()
                            
                            if context!.hasChanges {
                                do {
                                    try context!.save()
                                    promise(.success(contentData))
                                } catch {
                                    promise(.failure(error))
                                }
                            }
                        }
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func deleteContentData(id: NSManagedObjectID) -> AnyPublisher<ContentData, Error> {
        Deferred { [context] in
            Future { promise in
                context?.perform {
                    
                    do {
                        if let targetContent = try context?.existingObject(with: id) as? ContentData {
                            context?.delete(targetContent)
                            try context?.save()
                            print(targetContent)
                            print("조회 성공")
                            promise(.success(targetContent))
                        }

                    } catch {
                        print("실패")
                        promise(.failure(error))
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func updateContentNoti(id: NSManagedObjectID, notiDuration: String) -> AnyPublisher<ContentData, Error>{
        Deferred { [context] in
            Future { promise in
                context?.perform {
                    do {
                        if let targetContent = try context?.existingObject(with: id) as? ContentData {
                            targetContent.notiTime = Date.now
                            try context?.save()
                            print(targetContent)
                            print("업데이트 성공")
                            print("업데이트 noti duration \(notiDuration)")
                            promise(.success(targetContent))
                        }

                    } catch {
                        print("실패")
                        promise(.failure(error))
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func updateContentTag(id: NSManagedObjectID, tag: String) -> AnyPublisher<ContentData, Error>{
        Deferred { [context] in
            Future { promise in
                context?.perform {
                    do {
                        if let targetContent = try context?.existingObject(with: id) as? ContentData {
                            targetContent.tag = tag
                            try context?.save()
                            print(targetContent)
                            print("Tag 업데이트 성공")
                            promise(.success(targetContent))
                        }
                    } catch {
                        print("실패")
                        promise(.failure(error))
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    
}
