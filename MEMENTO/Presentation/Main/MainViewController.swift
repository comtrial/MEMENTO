
import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    private var typingTextFieldView = TypingTextFildView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        configureTextField()
    }
    
    func configureTextField() {
        
        view.addSubview(typingTextFieldView)
        typingTextFieldView.delegate = self
        typingTextFieldView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            typingTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typingTextFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            typingTextFieldView.heightAnchor.constraint(equalToConstant: 100),
//            typingTextFieldView.widthAnchor.constraint(equalToConstant: 300),
        ])
        
    }
}

class TypingTextFildView: UITextField {
//    var textView = UITextField()
    let textViewPlaceHolder = "아래 버튼을 클릭하세요"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
//        self.addSubview(textView)
        
        self.translatesAutoresizingMaskIntoConstraints = false
//        textView.delegate = self
        self.font = UIFont.init(name: "Avenir", size: 18)
        self.text = textViewPlaceHolder
        self.textColor = .lightGray
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 8

        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 100),
            self.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}
