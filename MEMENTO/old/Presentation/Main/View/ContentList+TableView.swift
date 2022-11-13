//
//  ContentList+TableView.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/20.
//

import Foundation
import UIKit
//
//extension MainViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
//}
//
//extension MainViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.contents.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewContentCell.identifier, for: indexPath) as! NewContentCell
//        let item = viewModel.contents[indexPath.row]
//        
//        print("cell redraw index \(indexPath.row)")
//        
//        // Date divider status
//        var dateDividerStatus: Bool = false
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let dateNow = dateFormatter.string(from: item.date!)
//        
//        if viewModel.dateTime != dateNow {
//            dateDividerStatus = true
//            viewModel.dateTime = dateNow
////            let dividerCell = tableView.dequeueReusableCell(withIdentifier: ContentDividerCell.identifier) as! ContentDividerCell
////            dividerCell.configureUI(divideDate: item.date!)
//        }
//        
//        cell.configureUI(item: item, dateDivider: dateDividerStatus)
//        
//        
//        cell.selectionStyle = .none
//        cell.delegate = self
//        
//        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
//        return cell
//    }
//    
//    //TODO: Delete flow definitely need refact
//    //MARK: Delete row flows
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
//            self.viewModel.deleteContent(contentData: self.viewModel.contents[indexPath[1]])
//            self.viewModel.contents.remove(at: indexPath[1])
//            tableView.beginUpdates()
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.endUpdates()
//            completion(true)
//        }
//        
//        action.image = UIImage(systemName: "trash")?.withTintColor(.white).rotate(degrees: 180)
//        action.backgroundColor = UIColor(red: 0.884, green: 0.888, blue: 0.9, alpha: 1)
//        
//        let configuration = UISwipeActionsConfiguration(actions: [action])
//        configuration.performsFirstActionWithFullSwipe = false
//        
//        print(configuration)
//        return configuration
//    }
//}


