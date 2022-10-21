//
//  ContentOptionView.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/21.
//

import UIKit


class ContentOptionView: UIView{
    
    let notiButton = UIButton()
    let tagButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(tagButton)
        tagButton.translatesAutoresizingMaskIntoConstraints = false
        tagButton.setImage(UIImage(systemName: "tag"), for: .normal)
        tagButton.tintColor = .black
        tagButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        tagButton.layer.cornerRadius = 4
        tagButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        NSLayoutConstraint.activate([
            tagButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            tagButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        addSubview(notiButton)
        notiButton.translatesAutoresizingMaskIntoConstraints = false
        notiButton.setImage(UIImage(systemName: "alarm"), for: .normal)
        notiButton.tintColor = .black
        notiButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        notiButton.layer.cornerRadius = 4
        notiButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)

        NSLayoutConstraint.activate([
            notiButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            notiButton.trailingAnchor.constraint(equalTo: tagButton.leadingAnchor, constant: -8),
            notiButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}
