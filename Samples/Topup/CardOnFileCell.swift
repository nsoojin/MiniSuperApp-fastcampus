import UIKit

final class CardOnFileCell: UITableViewCell {
  
  func setImage(_ image: UIImage?) {
    thumbnailView.image = image
  }
  
  func setTitle(_ title: String) {
    titleLabel.text = title
  }
  
  private let thumbnailView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.roundCorners(4)
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    return label
  }()
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViews()
  }
  
  private func setupViews() {
    contentView.addSubview(thumbnailView)
    contentView.addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      thumbnailView.widthAnchor.constraint(equalToConstant: 46),
      thumbnailView.heightAnchor.constraint(equalToConstant: 34),
      thumbnailView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      titleLabel.centerYAnchor.constraint(equalTo: thumbnailView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 14)
    ])
  }
  
}
