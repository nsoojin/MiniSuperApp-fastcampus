import UIKit

public extension UIView {
  func addShadowWithRoundedCorners(
    _ radius: CGFloat = 16,
    shadowColor: CGColor = UIColor.black.cgColor,
    opacity: Float = 0.1
  ) {
    self.layer.cornerCurve = .continuous
    self.layer.masksToBounds = false
    self.layer.shadowColor = shadowColor
    self.layer.shadowOffset = CGSize(width: 0, height: 0)
    self.layer.shadowOpacity = opacity
    self.layer.shadowRadius = 2.5
    self.layer.cornerRadius = radius
  }
  
  func roundCorners(
    _ radius: CGFloat = 16
  ) {
    self.layer.cornerCurve = .continuous
    self.layer.cornerRadius = radius
    self.clipsToBounds = true
  }
}
