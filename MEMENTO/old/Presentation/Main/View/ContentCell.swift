//
//  ContentCell.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/20.
//
import UIKit

protocol OptButtonDelegate: AnyObject {
    func didTapNotiButton(item: ContentData)
    func didTapTagButton(item: ContentData)
}

class ContentCell: UITableViewCell {
    
    weak var delegate: OptButtonDelegate?
    
    var item: ContentData?
    
    static let identifier = "CellId"
    private var textView = UITextView()
    
    let dividerView = UIView()
    let dividerLabel = UILabel()
    
    let dateLabel = UILabel()
    let notiButton = UIButton()
    let tagButton = UIButton()
    

    let sideStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(item: ContentData, dateDivider: Bool = false) {
        self.backgroundColor = .white
        
        self.item = item
        self.textView.text = item.content
        
        
        
        drawDateLabel()
//        drawContent()
        drawSideLabel()
        notiButton.addTarget(self, action: #selector(optionNotiButtonClicked), for: .touchDown)
        tagButton.addTarget(self, action: #selector(optionTagButtonClicked), for: .touchDown)
        
        
//        addSubview(textView)
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.isScrollEnabled = false
//        textView.isSelectable = false
//        textView.isEditable = false
//
//        let size = CGSize(width: frame.width, height: .infinity)
//
//        textView.font = UIFont.systemFont(ofSize: 14)
//        textView.textColor = .black
//
//        NSLayoutConstraint.activate([
//            textView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
//            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
//            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
////                textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
//        ])
        
        
        
        
//        
//        if item.image != nil {
//            textView.isHidden = true
//            let imageView = UIImageView()
//            addSubview(imageView)
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            imageView.image = UIImage(data: item.image!)
//
//            NSLayoutConstraint.activate([
//                imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor , constant: 8),
//                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//                imageView.heightAnchor.constraint(equalToConstant: 180),
//                imageView.widthAnchor.constraint(equalToConstant: 180),
//                imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
//            ])
//        } else {
//            print("expanded not show")
//            NSLayoutConstraint.activate([
//                textView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
//                textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
//                textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
////                textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
//            ])
//        }
        
        
//
//
//
//        if !isOpen {
//            if item.image != nil {
//                textView.isHidden = true
//                let imageView = UIImageView()
//                addSubview(imageView)
//                imageView.translatesAutoresizingMaskIntoConstraints = false
//                imageView.image = UIImage(data: item.image!)
//
//                NSLayoutConstraint.activate([
//                    imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//                    imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//                    imageView.heightAnchor.constraint(equalToConstant: 180),
//                    imageView.widthAnchor.constraint(equalToConstant: 180),
//                    imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
//                ])
//            } else {
//                print("expanded not show")
//                NSLayoutConstraint.activate([
//                    textView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//                    textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//                    textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//                    textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
//                ])
//            }
//
//
//        } else {
//            print("expanded show")
//            NSLayoutConstraint.activate([
//                textView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//                textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            ])
//
//            notiButton.addTarget(self, action: #selector(optionNotiButtonClicked), for: .touchDown)
//            tagButton.addTarget(self, action: #selector(optionTagButtonClicked), for: .touchDown)
//
//            addSubview(tagButton)
//            tagButton.translatesAutoresizingMaskIntoConstraints = false
//            tagButton.setImage(UIImage(systemName: "tag"), for: .normal)
//            tagButton.tintColor = .black
//            tagButton.setBackgroundColor(UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1), for: .normal)
//            tagButton.setBackgroundColor(.black, for: .highlighted)
//
//            tagButton.layer.cornerRadius = 4
//            tagButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
//            NSLayoutConstraint.activate([
//                tagButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
//                tagButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//                tagButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            ])
//
//            print("tag button alse show")
//            addSubview(notiButton)
//            notiButton.translatesAutoresizingMaskIntoConstraints = false
//            notiButton.setImage(UIImage(systemName: "alarm"), for: .normal)
//            notiButton.tintColor = .black
//            notiButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
//            notiButton.layer.cornerRadius = 4
//            notiButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
//
//
//            NSLayoutConstraint.activate([
//                notiButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
//                notiButton.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -8),
//                notiButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            ])
//
//        }
//
//
//        // MARK: sideLabel
//        sideStackView.removeAllArrangedSubviews()
//        print(item)
//        if item.notiTime != nil {
//            let notiLabel = PaddingUILabel(padding: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4))
//            addSubview(notiLabel)
//            notiLabel.translatesAutoresizingMaskIntoConstraints = false
//            let notiLabelAttachment = NSTextAttachment()
//            notiLabelAttachment.image = UIImage(systemName: "alarm")
//            notiLabelAttachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
//            notiLabel.attributedText = NSAttributedString(attachment: notiLabelAttachment)
//            notiLabel.tintColor = .black
//            notiLabel.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        
//
//            sideStackView.addArrangedSubview(notiLabel)
//        }
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
//            sideStackView.addArrangedSubview(tagLabel)
//        }
//
//        addSubview(sideStackView)
//        sideStackView.translatesAutoresizingMaskIntoConstraints = false
//        sideStackView.spacing = 8
//        NSLayoutConstraint.activate([
//            sideStackView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
//            sideStackView.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: -8),
//        ])
    }

    func drawContent() {
        
    }
    
    func drawSideLabel() {
        // MARK: sideLabel
        sideStackView.removeAllArrangedSubviews()
        print(item)
        
//        let notiButton = UIButton()
        
        notiButton.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(notiButton)
        if item!.notiTime != nil {
//            let notiButton = UIButton()
            
            notiButton.setImage(UIImage(systemName: "alarm"), for: .normal)
            notiButton.contentVerticalAlignment = .fill
            notiButton.contentHorizontalAlignment = .fill
            notiButton.tintColor = .black
            notiButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            notiButton.layer.cornerRadius = 4
            notiButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
            
            NSLayoutConstraint.activate([
                notiButton.heightAnchor.constraint(equalToConstant: 24),
                notiButton.widthAnchor.constraint(equalToConstant: 24)
            ])
            sideStackView.addArrangedSubview(notiButton)
        } else {
//            let notiButton = UIButton()
            notiButton.setImage(UIImage(systemName: "alarm"), for: .normal)
            notiButton.contentVerticalAlignment = .fill
            notiButton.contentHorizontalAlignment = .fill
            notiButton.tintColor = .black
            notiButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            notiButton.layer.cornerRadius = 4
            notiButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
            NSLayoutConstraint.activate([
                notiButton.heightAnchor.constraint(equalToConstant: 24),
                notiButton.widthAnchor.constraint(equalToConstant: 24)
            ])
            sideStackView.addArrangedSubview(notiButton)        }
        
//        let tagButton = UIButton()
        tagButton.translatesAutoresizingMaskIntoConstraints = false
        
        if let tagText: String = item!.tag {
            
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .default)
            tagButton.setImage(UIImage(systemName: "tag", withConfiguration: imageConfig), for: .normal)
            tagButton.setTitle(tagText, for: .normal)
            tagButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            tagButton.setTitleColor(.black, for: .normal)
            tagButton.tintColor = .black
            tagButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            tagButton.layer.cornerRadius = 4
            tagButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
            NSLayoutConstraint.activate([
                tagButton.heightAnchor.constraint(equalToConstant: 24)
            ])
            sideStackView.addArrangedSubview(tagButton)

        } else {
            
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .default)
            tagButton.setImage(UIImage(systemName: "tag", withConfiguration: imageConfig), for: .normal)
            tagButton.tintColor = .black
            tagButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            tagButton.layer.cornerRadius = 4

            NSLayoutConstraint.activate([
                tagButton.heightAnchor.constraint(equalToConstant: 24)
            ])
            sideStackView.addArrangedSubview(tagButton)

        }
        
        contentView.addSubview(sideStackView)
        sideStackView.translatesAutoresizingMaskIntoConstraints = false
        sideStackView.spacing = 8
        NSLayoutConstraint.activate([
            sideStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            sideStackView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            sideStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }
    func drawDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateLabel.text = dateFormatter.string(from: self.item!.date!)
        dateLabel.font = UIFont.systemFont(ofSize: 10)
        dateLabel.textColor = .lightGray
        NSLayoutConstraint.activate([
//            dateLabel.topAnchor.constraint(equalTo: dateDivider ? dividerView.bottomAnchor : topAnchor, constant: 8),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    
//
//    func drawDateDivider() {
//        print("ddddd")
//
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        addSubview(dividerLabel)
//        dividerLabel.translatesAutoresizingMaskIntoConstraints = false
//        dividerLabel.text = dateFormatter.string(from: self.item?.date!)
//        dividerLabel.font = UIFont.systemFont(ofSize: 13)
//        dividerLabel.textColor = .black
//        NSLayoutConstraint.activate([
//            dividerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            dividerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            dividerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//        ])
//
//        addSubview(dividerView)
//        dividerView.translatesAutoresizingMaskIntoConstraints = false
//        dividerView.backgroundColor = UIColor(red: 0.884, green: 0.888, blue: 0.9, alpha: 1)
//
//        NSLayoutConstraint.activate([
//            dividerView.topAnchor.constraint(equalTo: dividerLabel.bottomAnchor, constant: 8),
//            dividerView.heightAnchor.constraint(equalToConstant: 1),
//            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//        ])
//    }
//
    

    
    
    
    @objc func optionNotiButtonClicked(_ sender: Any) {
        self.delegate?.didTapNotiButton(item: self.item!)
    }
    
    @objc func optionTagButtonClicked(_ sender: Any) {
        self.delegate?.didTapTagButton(item: self.item!)
    }
}
