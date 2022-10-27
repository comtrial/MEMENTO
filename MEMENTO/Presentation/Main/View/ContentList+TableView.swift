//
//  ContentList+TableView.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/20.
//

import Foundation
import UIKit


extension UITableView {
    func scrollToBottom(isAnimated:Bool = true){
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1),
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.contentsTableView.tableView.cellForRow(at: indexPath) as? ContentCell else {return}
        guard let index = self.contentsTableView.tableView.indexPath(for: cell) else { return }
        
        viewModel.contentStates[indexPath.row].toggle()
        self.contentsTableView.tableView.reloadRows(at: [indexPath], with: .automatic)
        print(indexPath)
        print(viewModel.contentStates)
        
        //        print("when click cell content \(viewModel.contents[indexPath.row])")
        //        print("when click cell statste \(viewModel.contentStates[indexPath.row])")
        //        let content = answerExpanded
        //        content.expended = !content.expended
        
        //        print("is Cell index: \(indexPath)")
        //        print("is Cell expanded: \(content.expended)")
        
//        let targetIndices = viewModel.contentStates.indices.filter{ viewModel.contentStates[$0] == true }
//        print("fucking new \(targetIndices)")
//
//        if targetIndices != [] {
//            for targetIndex in targetIndices {
//                if targetIndex != indexPath.row {
//                    viewModel.contentStates[targetIndex] = false
//                    let reloadIndexPath = IndexPath(row: targetIndex, section: 0)
//                    self.contentsTableView.tableView.reloadRows(at: [reloadIndexPath], with: .automatic)
//                    print("target index \(targetIndex)")
//                }
//            }
//        }
        
       

        
        


        
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.identifier, for: indexPath) as! ContentCell
        let item = viewModel.contents[indexPath.row]
        
        print("cell redraw index \(indexPath.row)")
        let itemStatus = viewModel.contentStates[indexPath.row]
        cell.configureUI(item: item, isExpanded: answerExpanded, isOpen: itemStatus)
        cell.selectionStyle = .none
        cell.delegate = self
        
        return cell
    }
    
    //TODO: Delete flow definitely need refact
    // MARK: Delete row flows
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            self.viewModel.deleteContent(contentData: self.viewModel.contents[indexPath[1]])
            self.viewModel.contents.remove(at: indexPath[1])
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            completion(true)
        }
        
        action.backgroundColor = .white
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .darkGray
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        
        print(configuration)
        return configuration
    }
}


