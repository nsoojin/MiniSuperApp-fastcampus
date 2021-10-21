import Foundation

struct Formatter {
  static let balanceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()
}
