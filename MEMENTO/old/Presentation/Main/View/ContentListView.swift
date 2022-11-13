//
//  ContentListView.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/20.
//
import UIKit

class ContentListView: UIView {
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        return view
    }()
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .white
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.estimatedRowHeight = 50
//        tableView.rowHeight = UITableView.automaticDimension;
//        collectionView.separatorStyle = .none
        collectionView.register(NewContentCell.self, forCellWithReuseIdentifier: NewContentCell.identifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
