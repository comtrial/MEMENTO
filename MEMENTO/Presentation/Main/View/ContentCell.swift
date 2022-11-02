//
//  ContentCell.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/20.
//
import UIKit

//class ExpandingContentCell {
//    var expended: Bool
//
//    init() {
//        self.expended = false
//    }
//}

protocol OptButtonDelegate: AnyObject {
    func didTapNotiButton(item: ContentData)
    func didTapTagButton(item: ContentData)
}

class ContentCell: UITableViewCell {
    
    weak var delegate: OptButtonDelegate?
    
    var item: ContentData?
    
    static let identifier = "CellId"
    private var textView = UITextView()
    
    let notiButton = UIButton()
    let tagButton = UIButton()
    
    let sideStackView = UIStackView()
    
    var contentOptionView = ContentOptionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(item: ContentData, isOpen: Bool = false) {
        self.backgroundColor = .white
        
        self.item = item
        self.textView.text = item.content
        
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.isEditable = false
        
        let size = CGSize(width: frame.width, height: .infinity)
        
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .black
        textView.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        textView.layer.cornerRadius = 8

        
        if !isOpen {
            print("expanded not show")
            NSLayoutConstraint.activate([
                textView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
            
        } else {
            print("expanded show")
            NSLayoutConstraint.activate([
                textView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ])
            
            notiButton.addTarget(self, action: #selector(optionNotiButtonClicked), for: .touchDown)
            tagButton.addTarget(self, action: #selector(optionTagButtonClicked), for: .touchDown)
            
            addSubview(tagButton)
            tagButton.translatesAutoresizingMaskIntoConstraints = false
            tagButton.setImage(UIImage(systemName: "tag"), for: .normal)
            tagButton.tintColor = .black
            tagButton.setBackgroundColor(UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1), for: .normal)
            tagButton.setBackgroundColor(.black, for: .highlighted)
                                         
            tagButton.layer.cornerRadius = 4
            tagButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
            NSLayoutConstraint.activate([
                tagButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
                tagButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                tagButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
            
            print("tag button alse show")
            addSubview(notiButton)
            notiButton.translatesAutoresizingMaskIntoConstraints = false
            notiButton.setImage(UIImage(systemName: "alarm"), for: .normal)
            notiButton.tintColor = .black
            notiButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            notiButton.layer.cornerRadius = 4
            notiButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)

            
            NSLayoutConstraint.activate([
                notiButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
                notiButton.trailingAnchor.constraint(equalTo: tagButton.leadingAnchor, constant: -8),
                notiButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
            
        }
        
        
        // MARK: sideLabel
        sideStackView.removeAllArrangedSubviews()
        print(item)
        if item.notiTime != nil {
            let notiLabel = PaddingUILabel(padding: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4))
            addSubview(notiLabel)
            notiLabel.translatesAutoresizingMaskIntoConstraints = false
            let notiLabelAttachment = NSTextAttachment()
            notiLabelAttachment.image = UIImage(systemName: "alarm")
            notiLabelAttachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
            notiLabel.attributedText = NSAttributedString(attachment: notiLabelAttachment)
            notiLabel.tintColor = .black
            notiLabel.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            
            sideStackView.addArrangedSubview(notiLabel)
        }
        
        if let tagText: String = item.tag {
            let tagLabel = PaddingUILabel(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
            addSubview(tagLabel)
            tagLabel.translatesAutoresizingMaskIntoConstraints = false
            tagLabel.text = tagText
            tagLabel.font = UIFont.systemFont(ofSize: 10)
            tagLabel.textColor = .black
            tagLabel.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
            tagLabel.layer.cornerRadius = 6
            
            sideStackView.addArrangedSubview(tagLabel)
        }
        
        addSubview(sideStackView)
        sideStackView.translatesAutoresizingMaskIntoConstraints = false
        sideStackView.spacing = 8
        NSLayoutConstraint.activate([
            sideStackView.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
            sideStackView.trailingAnchor.constraint(equalTo: textView.leadingAnchor, constant: -8),
        ])
//
//        if let tagText: String = item.tag {
//            let tagLabel = PaddingUILabel(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
//            addSubview(tagLabel)
//            tagLabel.translatesAutoresizingMaskIntoConstraints = false
//            tagLabel.text = tagText
//            tagLabel.font = UIFont.systemFont(ofSize: 10)
//            tagLabel.textColor = .black
//            tagLabel.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
//            tagLabel.layer.cornerRadius = 6
//
//            NSLayoutConstraint.activate([
//                tagLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
//                tagLabel.trailingAnchor.constraint(equalTo: textView.leadingAnchor, constant: -8),
//            ])
//        }
//
//        if item.notiTime != nil {
//            let notiLabel = PaddingUILabel(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
//            addSubview(notiLabel)
//            notiLabel.translatesAutoresizingMaskIntoConstraints = false
//            let notiLabelAttachment = NSTextAttachment()
//            notiLabelAttachment.image = UIImage(systemName: "alarm")
//            notiLabelAttachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
//            notiLabel.attributedText = NSAttributedString(attachment: notiLabelAttachment)
//            notiLabel.tintColor = .black
//            notiLabel.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
//
//
//            NSLayoutConstraint.activate([
//                notiLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
//                notiLabel.trailingAnchor.constraint(equalTo: textView.leadingAnchor, constant: -8),
//            ])
//        }
    }
    
    @objc func optionNotiButtonClicked(_ sender: Any) {
        self.delegate?.didTapNotiButton(item: self.item!)
    }
    
    @objc func optionTagButtonClicked(_ sender: Any) {
        self.delegate?.didTapTagButton(item: self.item!)
    }
}
