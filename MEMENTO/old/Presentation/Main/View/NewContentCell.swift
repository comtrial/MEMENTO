//
//  NewContentCell.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/11/08.
//

import UIKit
import LinkPresentation



protocol NewOptButtonDelegate: AnyObject {
    func didTapNotiButton(item: ContentData)
    func didTapTagButton(item: ContentData)
}

class NewContentCell: UICollectionViewCell {
    weak var delegate: NewOptButtonDelegate?
    var isFinished: Bool = false
    var item: ContentData?
    static let identifier = "CellIdnew"
    
    // MARK: View Properties
    let dateLabel = UILabel()
    let mainView = UIView()
    let optionView = UIStackView()
    
//    override ini
//    override init(style: UICollectionViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func configureUI(item: ContentData, dateDivider: Bool = false) {
        contentView.layoutIfNeeded()
         
        self.item = item
        drawDateLabel()
        drawMainView()
        drawSideView()
        

    }
    
    func drawMainView() {
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        switch item?.type {
        case "text": _drawMainTextView()
        case "image": _drawMainImageView()
        case "url": _drawMainURLView()
        default: _drawMainTextView()
        }
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
//            mainView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func _drawMainURLView() {
       print("drawing link preview")
        let imageView = UIImageView()
        let linkLabel = PaddingUILabel(padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        
        mainView.addSubview(imageView)
        mainView.addSubview(linkLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        //FIXME: 기본 이미지 값 설정
        
        
        let urlString = item?.content!
        linkLabel.text = urlString
        linkLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        linkLabel.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)

        let url = URL(string: urlString!)!

        LPMetadataProvider().startFetchingMetadata(for: url) { (linkMetadata, error) in
            guard let linkMetadata = linkMetadata, let imageProvider = linkMetadata.iconProvider else { return }

            print(linkMetadata.title ?? "Untitled")

            imageProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                guard error == nil else {
                    // handle error
                    return
                }

                if let image = image as? UIImage {
                    // do something with image
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                } else {
                    print("no image available")
                }
            }
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            linkLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            linkLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            linkLabel.widthAnchor.constraint(equalToConstant: 200),
            linkLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
        ])
    }
    
    func _drawMainTextView() {
        let textView = UITextView()
        
        mainView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = item?.content
        
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.isEditable = false
        let size = CGSize(width: frame.width, height: .infinity)
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .black
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: mainView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
//            textView.heightAnchor.constraint(equalToConstant: 40),
            textView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        
    }
    func _drawMainImageView() {
        let imageView = UIImageView()
        
        mainView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //FIXME: 기본 이미지 값 설정
        imageView.image = UIImage(data: (item?.image)!)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
    
    func drawSideView() {
        optionView.removeAllArrangedSubviews()
        
        let notiButton = UIButton()
        let tagButton = UIButton()
    
        notiButton.translatesAutoresizingMaskIntoConstraints = false
        tagButton.translatesAutoresizingMaskIntoConstraints = false
    
        notiButton.addTarget(self, action: #selector(optionNotiButtonClicked), for: .touchDown)
        tagButton.addTarget(self, action: #selector(optionTagButtonClicked), for: .touchDown)

        if item!.notiTime != nil {
            notiButton.setImage(UIImage(systemName: "alarm"), for: .normal)
            notiButton.contentVerticalAlignment = .fill
            notiButton.contentHorizontalAlignment = .fill
            notiButton.tintColor = .black
            notiButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            notiButton.layer.cornerRadius = 4
            notiButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
            
            NSLayoutConstraint.activate([
                notiButton.heightAnchor.constraint(equalToConstant: 30),
                notiButton.widthAnchor.constraint(equalToConstant: 30)
            ])
        } else {
            notiButton.setImage(UIImage(systemName: "alarm"), for: .normal)
            notiButton.contentVerticalAlignment = .fill
            notiButton.contentHorizontalAlignment = .fill
            notiButton.tintColor = .black
            notiButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            notiButton.layer.cornerRadius = 4
            notiButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
            NSLayoutConstraint.activate([
                notiButton.heightAnchor.constraint(equalToConstant: 30),
                notiButton.widthAnchor.constraint(equalToConstant: 30)
            ])
        }
        
        
        if let tagText: String = item!.tag {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .default)
            tagButton.setImage(UIImage(systemName: "tag", withConfiguration: imageConfig), for: .normal)
            tagButton.setTitle(tagText, for: .normal)
            tagButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            tagButton.setTitleColor(.black, for: .normal)
            tagButton.tintColor = .black
            tagButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            tagButton.layer.cornerRadius = 4
            tagButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
            NSLayoutConstraint.activate([
                tagButton.heightAnchor.constraint(equalToConstant: 30)
            ])
            

        } else {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .default)
            tagButton.setImage(UIImage(systemName: "tag", withConfiguration: imageConfig), for: .normal)
            tagButton.tintColor = .black
            tagButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            tagButton.layer.cornerRadius = 4

            NSLayoutConstraint.activate([
                tagButton.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        
        
        optionView.addArrangedSubview(notiButton)
        optionView.addArrangedSubview(tagButton)
        
        contentView.addSubview(optionView)
        optionView.translatesAutoresizingMaskIntoConstraints = false
        optionView.spacing = 8
        NSLayoutConstraint.activate([
            optionView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 8),
            optionView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            optionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
   
    func drawDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateLabel.text = dateFormatter.string(from: self.item!.date!)
        dateLabel.font = UIFont.systemFont(ofSize: 10)
        dateLabel.textColor = .lightGray
        
        NSLayoutConstraint.activate([
//            dateLabel.topAnchor.constraint(equalTo: dateDivider ? dividerView.bottomAnchor : topAnchor, constant: 8),
//            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
    }
        
    @objc func optionNotiButtonClicked(_ sender: Any) {
        self.delegate?.didTapNotiButton(item: self.item!)
        print("fuct")
    }
    
    @objc func optionTagButtonClicked(_ sender: Any) {
        self.delegate?.didTapTagButton(item: self.item!)
    }
}
    
//extension NewContentCell {
//    override func prepareForReuse() {
//        super.prepareForReuse()
////        self.mainView = nil 
//        self.accessoryType = .none
//    }
//}
