import ModernRIBs
import UIKit
import RIBsUtil
import SuperUI

protocol AddPaymentMethodPresentableListener: AnyObject {
  func didTapClose()
  func didTapConfirm(with number: String, cvc: String, expiry: String)
}

final class AddPaymentMethodViewController: UIViewController, AddPaymentMethodPresentable, AddPaymentMethodViewControllable {
  
  weak var listener: AddPaymentMethodPresentableListener?
  
  private let cardNumberTextField: UITextField = {
    let textField = makeTextField()
    textField.placeholder = "카드 번호"
    textField.accessibilityIdentifier = "addpaymentmethod_cardnumber_textfield"
    return textField
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    stackView.spacing = 14
    return stackView
  }()
  
  private let securityTextField: UITextField = {
    let textField = makeTextField()
    textField.placeholder = "CVC"
    textField.accessibilityIdentifier = "addpaymentmethod_security_textfield"
    return textField
  }()
  
  private let expirationTextField: UITextField = {
    let textField = makeTextField()
    textField.placeholder = "유효기한"
    textField.accessibilityIdentifier = "addpaymentmethod_expiry_textfield"
    return textField
  }()
  
  private lazy var addCardButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.roundCorners()
    button.backgroundColor = .primaryRed
    button.setTitle("추가하기", for: .normal)
    button.accessibilityIdentifier = "addpaymentmethod_addcard_button"
    button.addTarget(self, action: #selector(didTapAddCard), for: .touchUpInside)
    return button
  }()
  
  private static func makeTextField() -> UITextField {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .white
    textField.borderStyle = .roundedRect
    textField.keyboardType = .numberPad
    return textField
  }
  
  init(closeButtonType: DismissButtonType) {
    super.init(nibName: nil, bundle: nil)
    
    setupViews()
    setupNavigationItem(with: closeButtonType, target: self, action: #selector(didTapClose))
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
    setupNavigationItem(with: .close, target: self, action: #selector(didTapClose))
  }
  
  private func setupViews() {
    title = "카드 추가"
    
    view.backgroundColor = .backgroundColor
    view.addSubview(cardNumberTextField)
    view.addSubview(stackView)
    view.addSubview(addCardButton)
    
    stackView.addArrangedSubview(securityTextField)
    stackView.addArrangedSubview(expirationTextField)
    
    NSLayoutConstraint.activate([
      cardNumberTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
      cardNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      cardNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      
      cardNumberTextField.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      
      stackView.bottomAnchor.constraint(equalTo: addCardButton.topAnchor, constant: -20),
      addCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      addCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      
      cardNumberTextField.heightAnchor.constraint(equalToConstant: 60),
      securityTextField.heightAnchor.constraint(equalToConstant: 60),
      expirationTextField.heightAnchor.constraint(equalToConstant: 60),
      addCardButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  @objc
  private func didTapAddCard() {
    if
      let number = cardNumberTextField.text,
      let cvc = securityTextField.text,
      let expiry = expirationTextField.text {
      listener?.didTapConfirm(with: number, cvc: cvc, expiry: expiry)
    }
  }
  
  @objc
  private func didTapClose() {
    listener?.didTapClose()
  }
}
