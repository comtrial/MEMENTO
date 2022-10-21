//
//  ContentCell.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/20.
//
import UIKit

class ExpandingContentCell {
    var expended: Bool
    
    init() {
        self.expended = false
    }
}

protocol OptButtonDelegate: AnyObject {
    func didTapButton()
}

class ContentCell: UITableViewCell {
    
    weak var delegate: OptButtonDelegate?
    
    static let identifier = "CellId"
    private var textView = UITextView()
    
    var contentOptionView = ContentOptionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(item: ContentData, isExpanded: ExpandingContentCell) {
        self.textView.text = item.content
        
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        
        let size = CGSize(width: frame.width, height: .infinity)
//        let estimateHeightSize = textView.sizeThatFits(size).height
//        let estimateWidthSize = textView.sizeThatFits(size).width
        
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        textView.layer.cornerRadius = 8
        
        
        if !isExpanded.expended {
            NSLayoutConstraint.activate([
                textView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
        } else {
            NSLayoutConstraint.activate([
            
                textView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ])
            
            addSubview(contentOptionView)
            contentOptionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentOptionView.topAnchor.constraint(equalTo: textView.bottomAnchor),
                contentOptionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                contentOptionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            
            ])
            
            contentOptionView.tagButton.addTarget(self, action: #selector(optionButtonClicked), for: .touchDown)
        }
    }
    
    @objc func optionButtonClicked(_ sender: Any) {
        self.delegate?.didTapButton()
    }
}
