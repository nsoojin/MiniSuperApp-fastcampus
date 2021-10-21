import UIKit

final class SuperPayView: UIView {
  
  private let thumbnailView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .systemBlue
    imageView.roundCorners(4)
    return imageView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    label.text = "슈퍼페이"
    return label
  }()
  
  private let balanceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    label.text = "---원"
    return label
  }()
  
  func setBalanceText(_ text: String) {
    balanceLabel.text = text
  }
  
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
  private func setupViews() {
    addSubview(thumbnailView)
    addSubview(nameLabel)
    addSubview(balanceLabel)
    
    NSLayoutConstraint.activate([
      thumbnailView.widthAnchor.constraint(equalToConstant: 46),
      thumbnailView.heightAnchor.constraint(equalToConstant: 34),
      thumbnailView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      
      nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 10),
      
      balanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      balanceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])
  }
}
