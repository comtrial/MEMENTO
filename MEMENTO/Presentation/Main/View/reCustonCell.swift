////
////  ContentCell.swift
////  MEMENTO
////
////  Created by 최승원 on 2022/10/20.
////
//import UIKit
//
//class ExpandingContentCell {
//    var expended: Bool
//    
//    init() {
//        self.expended = false
//    }
//}
//
//protocol OptButtonDelegate: AnyObject {
//    func didTapNotiButton()
//    func didTapTagButton()
//}
//
//class ContentCell: UITableViewCell {
//    
//    weak var delegate: OptButtonDelegate?
//    
//    var isShit: Bool = false
//    static let identifier = "CellId"
//    private var textView = UITextView()
//    
//    let notiButton = UIButton()
//    let tagButton = UIButton()
//    
//    
//    var contentOptionView = ContentOptionView()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configureUI(item: ContentData, isExpanded: ExpandingContentCell) {
//        self.textView.text = item.content
//        
//        addSubview(textView)
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.isScrollEnabled = false
//        textView.isSelectable = false
//        textView.isEditable = false
//        
//        let size = CGSize(width: frame.width, height: .infinity)
//        
//        textView.font = UIFont.systemFont(ofSize: 14)
//        textView.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
//        textView.layer.cornerRadius = 8
//        NSLayoutConstraint.activate([
//            textView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//        ])
//        
//        notiButton.addTarget(self, action: #selector(optionNotiButtonClicked), for: .touchDown)
//        tagButton.addTarget(self, action: #selector(optionTagButtonClicked), for: .touchDown)
////        let contentOptionView = ContentOptionView(frame: .zero, notiButton: notiButton, tagButton: tagButton)
//        
//        addSubview(contentOptionView)
//        contentOptionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            contentOptionView.topAnchor.constraint(equalTo: textView.bottomAnchor),
//            contentOptionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            contentOptionView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//
////        let addView = UIView()
////        addView.translatesAutoresizingMaskIntoConstraints = false
////
////        addView.addSubview(tagButton)
////        tagButton.translatesAutoresizingMaskIntoConstraints = false
////        tagButton.setImage(UIImage(systemName: "tag"), for: .normal)
////        tagButton.tintColor = .black
////        tagButton.setBackgroundColor(UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1), for: .normal)
////        tagButton.setBackgroundColor(.black, for: .highlighted)
////
////        tagButton.layer.cornerRadius = 4
////        tagButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
////        NSLayoutConstraint.activate([
////            tagButton.topAnchor.constraint(equalTo: addView.bottomAnchor, constant: 8),
////            tagButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
////            tagButton.bottomAnchor.constraint(equalTo: bottomAnchor),
////        ])
////
////        print("tag button alse show")
////        addView.addSubview(notiButton)
////        notiButton.translatesAutoresizingMaskIntoConstraints = false
////        notiButton.setImage(UIImage(systemName: "alarm"), for: .normal)
////        notiButton.tintColor = .black
////        notiButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
////        notiButton.layer.cornerRadius = 4
////        notiButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
////
////
////        NSLayoutConstraint.activate([
////            notiButton.topAnchor.constraint(equalTo: addView.bottomAnchor, constant: 8),
////            notiButton.trailingAnchor.constraint(equalTo: addView.leadingAnchor, constant: -8),
////            notiButton.bottomAnchor.constraint(equalTo: bottomAnchor),
////        ])
////
////        addSubview(addView)
//        
//    }
//    
//    @objc func optionNotiButtonClicked(_ sender: Any) {
//        self.delegate?.didTapNotiButton()
//    }
//    
//    @objc func optionTagButtonClicked(_ sender: Any) {
//        self.delegate?.didTapTagButton()
//    }
//}
//
//extension ContentCell {
//    var isDetailViewHidden: Bool {
//            return contentOptionView.isHidden
//        }
//
//        func showDetailView() {
//            contentOptionView.isHidden = false
//        }
//
//        func hideDetailView() {
//            contentOptionView.isHidden = true
//        }
//
//        override func setSelected(_ selected: Bool, animated: Bool) {
//            super.setSelected(selected, animated: animated)
//            if isDetailViewHidden, selected {
//                showDetailView()
//            } else {
//                hideDetailView()
//            }
//        }
//    }
