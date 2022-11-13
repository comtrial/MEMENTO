////
////  ContentList+CollectionView.swift
////  MEMENTO
////
////  Created by 최승원 on 2022/11/09.
////
//
//import UIKit
//
//extension MainViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        viewModel.contents.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewContentCell.identifier, for: indexPath) as! NewContentCell
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
////        if viewModel.dateTime != dateNow {
////            dateDividerStatus = true
////            viewModel.dateTime = dateNow
////            let dividerCell = tableView.dequeueReusableCell(withIdentifier: ContentDividerCell.identifier) as! ContentDividerCell
////            dividerCell.configureUI(divideDate: item.date!)
//        }
//        
////        cell.configureUI(item: item, dateDivider: dateDividerStatus)
//        
//        
////        cell.selectionStyle = .none
//        cell.delegate = self
//        
//        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
//        return cell
//    }
//    
//}
//
//extension MainViewController: UICollectionViewDelegate {
//    
//}
//
//extension MainViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let width = view.frame.width
//        var estimatedHeight: CGFloat = 150.0
//        let item = viewModel.contents[indexPath.row]
//        
//        if item.type == "image" {
//            estimatedHeight = 400
//        }
//        return CGSize(width: width, height: estimatedHeight)
//    }
//}
