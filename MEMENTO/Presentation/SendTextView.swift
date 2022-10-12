//
//  SendTextView.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/11.
//

import UIKit

class SendTextView: UIView {
    
    let typingPlaceholder = "typing to remember"
    
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
        
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = .gray
        textView.layer.borderWidth = 0.8
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        textView.textContainerInset = UIEdgeInsets(top: 14,left: 14,bottom: 14,right: 14)
        
        NSLayoutConstraint.activate([
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            textView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // MARK: button Config
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        let buttonUIImage = UIImage(systemName: "arrow.right", withConfiguration: buttonConfiguration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        button.setImage(buttonUIImage, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -4),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

