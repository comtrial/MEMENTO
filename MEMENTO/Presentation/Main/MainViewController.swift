
import UIKit

class MainViewController: UIViewController{
    let typingPlaceholder = "typing to remember"
    var sendTextView = SendTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
    }
    
    func setup() {
        setupKeyboardHiding()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        drawMain()

        view.addSubview(sendTextView)
        sendTextView.translatesAutoresizingMaskIntoConstraints = false
        
        sendTextView.isUserInteractionEnabled = true
         
        NSLayoutConstraint.activate([
            sendTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sendTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sendTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sendTextView.heightAnchor.constraint(equalToConstant: 48 * 2)
        ])

        sendTextView.button.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    @objc func click() {
        print("cl")
    }
    
    // MARK: 다른 곳 터치시 editor 종료 시점 알리기 -> 키보드 내리기 등에서 사용가능 할 듯
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension MainViewController {
    func drawMain() {
        let text = UILabel()
        
        view.addSubview(text)
        text.text = "title"
        text.translatesAutoresizingMaskIntoConstraints = false
        
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}


extension MainViewController {
    // MARK: Keyboard show and hide problem with NotificatinCentr
    // https://www.youtube.com/watch?v=O4tP7egAV1I&ab_channel=SwiftArcade
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("hide")
        view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextView else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
            let newFrameY = (textBoxY - keyboardTopY + 14) * -1
            view.frame.origin.y = newFrameY
        }
        
        print("called")
        
    }
    
    func setupKeyboardHiding() {
        print("keyboard setup done")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

// MARK: SendTextView PlaceHold Helper
extension MainViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.text == sendTextView.typingPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        print("end")

        // setup placeholder
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = sendTextView.typingPlaceholder
            textView.textColor = .gray
        }
    }
}


