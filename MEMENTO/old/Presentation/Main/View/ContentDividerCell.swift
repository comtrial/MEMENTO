//
//  ContentDividerCell.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/11/07.
//

import UIKit

class ContentDividerCell: UITableViewCell {
    
    weak var delegate: OptButtonDelegate?
    
    var item: ContentData?
    
    static let identifier = "DividerCell"
    private var textView = UITextView()
    
    let dividerView = UIView()
    let dividerLabel = UILabel()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(divideDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        addSubview(dividerLabel)
        dividerLabel.translatesAutoresizingMaskIntoConstraints = false
        dividerLabel.text = dateFormatter.string(from: divideDate)
        dividerLabel.font = UIFont.systemFont(ofSize: 13)
        dividerLabel.textColor = .black
        NSLayoutConstraint.activate([
            dividerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dividerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dividerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
        addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = UIColor(red: 0.884, green: 0.888, blue: 0.9, alpha: 1)
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: dividerLabel.bottomAnchor, constant: 8),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
