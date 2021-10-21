import UIKit

final class EnterAmountWidget: UIView {
  
  var text: String? {
    amountTextField.text
  }

  init() {
    super.init(frame: .zero)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
  }
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    label.text = "금액"
    label.numberOfLines = 1
    return label
  }()
  
  private lazy var amountStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    let button = UIButton()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 5
    stackView.addArrangedSubview(self.amountTextField)
    stackView.addArrangedSubview(self.currencyLabel)
    return stackView
  }()
  
  private let amountTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    textField.textAlignment = .right
    textField.keyboardType = .numberPad
    textField.accessibilityIdentifier = "topup_enteramount_textfield"
    return textField
  }()
  
  private let currencyLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    label.text = "원"
    return label
  }()
  
  private func setupViews() {
    self.backgroundColor = .white
    self.addSubview(titleLabel)
    self.addSubview(amountStackView)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      amountStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      amountStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      amountStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
      amountStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
    ])
  }
}

