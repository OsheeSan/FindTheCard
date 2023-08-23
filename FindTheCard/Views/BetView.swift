import UIKit

class BetView: UIView, UITextFieldDelegate {
    
    var delegate: FloatingMenuVC!
    
    var enumValue: Any!

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter a number"
        textField.keyboardType = .numberPad
        textField.textAlignment = .right
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
                textField.rightView = paddingView
                textField.rightViewMode = .always
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        numberTextField.delegate = self
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = numberTextField.text, let value = Int(text) {
            switch enumValue {
                case is cardColor:
                    print("cardColor enum was passed")
                    delegate.colorBet  = value
                case is cardLogo:
                    print("cardLogo enum was passed")
                    delegate.logoBet  = value
                case is cardNumber:
                    print("cardNumber enum was passed")
                    delegate.numberBet  = value
                default:
                    print("Unknown enum type")
                }
        } else {
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        numberTextField.delegate = self
    }
    


    private func setupUI() {
        // Add imageView
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ])

        // Add number text field
        addSubview(numberTextField)
        NSLayoutConstraint.activate([
            numberTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            numberTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberTextField.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
}
