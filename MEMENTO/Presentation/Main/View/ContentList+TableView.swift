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
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
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
        let content = answerExpanded
        content.expended = !content.expended
        print(content.expended)
        self.contentsTableView.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.identifier, for: indexPath) as! ContentCell
        let item = viewModel.contents[indexPath.row]
        
        cell.configureUI(item: item, isExpanded: answerExpanded)
        cell.selectionStyle = .none
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            
            self.viewModel.contents.remove(at: indexPath[1])
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        print(indexPath[1])
        action.backgroundColor = .white
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .darkGray
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}


