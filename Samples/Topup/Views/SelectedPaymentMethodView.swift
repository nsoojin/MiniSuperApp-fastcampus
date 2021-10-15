import UIKit

struct SelectedPaymentMethodViewModel {
  let image: UIImage?
  let name: String
  
  init(_ paymentMethod: PaymentMethod) {
    image = UIColor(hex: paymentMethod.color).flatMap { UIImage(color: $0) }
    name = "\(paymentMethod.name) \(paymentMethod.digits)"
  }
}

final class SelectedPaymentMethodView: UIView {
  
  func update(with viewModel: SelectedPaymentMethodViewModel) {
    self.thumbnailView.image = viewModel.image
    self.nameLabel.text = viewModel.name
  }
  
  init() {
    super.init(frame: .zero)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
  }
  
  private let thumbnailView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleToFill
    imageView.roundCorners(4)
    imageView.backgroundColor = .systemGray3
    return imageView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    label.numberOfLines = 1
    return label
  }()
  
  private let rightChevronIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(
      systemName: "chevron.right",
      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
    )
    imageView.tintColor = .systemGray3
    return imageView
  }()
  
  private func setupViews() {
    self.backgroundColor = .white
    self.addSubview(thumbnailView)
    self.addSubview(nameLabel)
    self.addSubview(rightChevronIcon)
    
    NSLayoutConstraint.activate([
      thumbnailView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      thumbnailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
      thumbnailView.widthAnchor.constraint(equalToConstant: 46),
      thumbnailView.heightAnchor.constraint(equalToConstant: 34),
      nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 22),
      rightChevronIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      rightChevronIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
    ])
  }
}
