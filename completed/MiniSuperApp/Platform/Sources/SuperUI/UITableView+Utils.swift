import UIKit

public protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
}

public extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: Reusable {}

public extension UITableView {
  
  func register<T: UITableViewCell>(cellType: T.Type) {
    self.register(cellType, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
    guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Failed to dequeue reusable cell")
    }
    return cell
  }
}
