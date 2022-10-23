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
                    let dataOrder = NSSortDescriptor(key: "date", ascending: false)
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
    
    func deleteContentData(contentIdx: Int) -> AnyPublisher<[ContentData], Error> {
        Deferred { [context] in
            Future { promise in
                context?.perform {
                    
//                    
//                    let request = NSFetchRequest<NSManagedObject> (entityName:self.modelName)
//                    let dataOrder = NSSortDescriptor(key: "date", ascending: false)
//                    request.sortDescriptors = [dataOrder]
//                    
//                    do {
//                        if let fetchedContents = try context?.fetch(request) as! [ContentData] {
//                            if let targetContentData = fetchedContents.first {
//                                context?.delete(targetContentData)
//                            }
//                        }
//                        context?.save()
//                        promise(.success(fetchedContents))
//                    } catch {
//                        promise(.failure(error))
//                    }
//                    
                    
                    
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
