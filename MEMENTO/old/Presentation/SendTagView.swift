//
//  SendTagView.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/28.
//

import UIKit

protocol TagButtonDelegate: AnyObject {
    func didTapTagButton(newTag: String)
}

class SendTagView: UIView {
    let typingPlaceholder = "태그를 입력하세요"
    weak var delegate: TagButtonDelegate?
    var textView = UITextView()
    var sendButton = UIButton()
    var contentTags: [String] = []
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        // MARK: textView Config
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = typingPlaceholder
        
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor(red: 0.198, green: 0.202, blue: 0.233, alpha: 0.38)
        textView.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        textView.layer.cornerRadius = 8
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        NSLayoutConstraint.activate([
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            textView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // MARK: button Config
        addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(tagSendClicked), for: .touchDown)
        sendButton.setTitle("태그입력", for: .normal)

        sendButton.backgroundColor = .lightGray
        sendButton.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            sendButton.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -4),
            sendButton.heightAnchor.constraint(equalToConstant: 30),
            sendButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        print("tag status: \(contentTags)")
        // MARK: tag list
        if contentTags != [] {
            stackView.removeAllArrangedSubviews()
            print("drawing stackview ...")
            addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            for tag in contentTags {
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(tagButtonClicked), for: .touchDown)
                button.setTitle(tag, for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
                button.layer.cornerRadius = 4
                button.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
                stackView.addArrangedSubview(button)
            }
            
            stackView.spacing = 8
            NSLayoutConstraint.activate([
                stackView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -8),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ])
        }
    }
    
    @objc func tagSendClicked(_ sender: UIButton) {
        self.delegate?.didTapTagButton(newTag: self.textView.text!)
    }
    
    @objc func tagButtonClicked(_ sender: UIButton) {
        print("tag click")
        self.delegate?.didTapTagButton(newTag: sender.titleLabel?.text ?? "")
    }
}
