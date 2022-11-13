//
//  SendTextView.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/10/11.
//

import UIKit

protocol ToolButtonDelegate: AnyObject {
    func didTapPhotoButton()
    func didTapClipBoardButton()
}

class SendTextView: UIView {
    let typingPlaceholder = "기억해야할 기록들을 남겨보세요"
    
    weak var delegate: ToolButtonDelegate?
    var textView = UITextView()
    var button = UIButton()
    let toolStackView = UIStackView()
    
    
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
        
        // MARK: Toolbar
        addSubview(toolStackView)
        toolStackView.translatesAutoresizingMaskIntoConstraints = false
        toolStackView.spacing = 12
        NSLayoutConstraint.activate([
            toolStackView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -12),
            toolStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
        ])
        
        let photoButton = UIButton()
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        photoButton.setImage(UIImage(systemName: "photo"), for: .normal)
        photoButton.tintColor = .black
        photoButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        photoButton.layer.cornerRadius = 6
        photoButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        photoButton.addTarget(self, action: #selector(tapPhotoButton), for: .touchDown)
        
        let cameraButton = UIButton()
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.setImage(UIImage(systemName: "camera"), for: .normal)
        cameraButton.tintColor = .black
        cameraButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        cameraButton.layer.cornerRadius = 6
        cameraButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
        let clipBoardButton = UIButton()
        clipBoardButton.translatesAutoresizingMaskIntoConstraints = false
        clipBoardButton.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        clipBoardButton.tintColor = .black
        clipBoardButton.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        clipBoardButton.layer.cornerRadius = 6
        clipBoardButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
        clipBoardButton.addTarget(self, action: #selector(tapClipBoardButton), for: .touchDown)
        
        toolStackView.addArrangedSubview(photoButton)
        toolStackView.addArrangedSubview(cameraButton)
        toolStackView.addArrangedSubview(clipBoardButton)
        
    }
    
    @objc func tapPhotoButton() {
        self.delegate?.didTapPhotoButton()
    }
    
    @objc func tapClipBoardButton() {
        self.delegate?.didTapClipBoardButton()
    }
}

