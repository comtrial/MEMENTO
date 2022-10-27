//
//  SendTextView.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/11.
//

import UIKit

class SendTextView: UIView {
    
    let typingPlaceholder = "기억해야할 기록들을 남겨보세요"
    
    var textView = UITextView()
    var button = UIButton()
    
    
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
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonConfiguration = UIImage.SymbolConfiguration(pointSize: 14, weight: .bold)
        let buttonUIImage = UIImage(systemName: "arrow.right", withConfiguration: buttonConfiguration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        button.setImage(buttonUIImage, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
    
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -4),
            button.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

class SendTagView: UIView {
    let typingPlaceholder = "태그를 입력하세요"
    
    var textView = UITextView()
    var button = UIButton()
    var contentTags: [String] = []
    
    
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
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("태그입력", for: .normal)

        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -4),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        print("tag status: \(contentTags)")
        // MARK: tag list
        if contentTags != [] {
            print("drawing stackview ...")
            let stackView = UIStackView()
            
            for tag in contentTags {
                let button = UIButton()
                button.setTitle(tag, for: .normal)
                button.backgroundColor = .red
                stackView.addArrangedSubview(button)
            }
            
            addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.bottomAnchor.constraint(equalTo: textView.topAnchor),
                stackView.leftAnchor.constraint(equalTo: textView.leadingAnchor)
            ])
        }
    }
}

