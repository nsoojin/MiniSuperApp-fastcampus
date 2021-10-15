import UIKit

final class RideTypeView: UIView {
  
  private let thumbnailView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .black
    imageView.image = UIImage(
      systemName: "bolt.car",
      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
    )
    return imageView
  }()
  
  private let rideTypeNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    label.text = "슈퍼전기차 택시"
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "18,000원"
    return label
  }()
  
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
    addSubview(priceLabel)
    addSubview(rideTypeNameLabel)
    
    NSLayoutConstraint.activate([
      thumbnailView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      thumbnailView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      thumbnailView.widthAnchor.constraint(equalToConstant: 40),
      thumbnailView.heightAnchor.constraint(equalToConstant: 40),
      
      rideTypeNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      rideTypeNameLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 10),
      
      priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
