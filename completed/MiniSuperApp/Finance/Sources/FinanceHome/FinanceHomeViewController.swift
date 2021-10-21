import ModernRIBs
import UIKit

protocol FinanceHomePresentableListener: AnyObject {
}

final class FinanceHomeViewController: UIViewController, FinanceHomePresentable, FinanceHomeViewControllable {
  
  weak var listener: FinanceHomePresentableListener?
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 4
    return stackView
  }()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
  }
  
  func setupViews() {
    title = "슈퍼페이"
    tabBarItem = UITabBarItem(title: "슈퍼페이", image: UIImage(systemName: "creditcard"), selectedImage: UIImage(systemName: "creditcard.fill"))
    tabBarItem.accessibilityIdentifier = "superpay_home_tab_bar_item"
    view.backgroundColor = .white
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  func addDashboard(_ view: ViewControllable) {
    let vc = view.uiviewController
    
    addChild(vc)
    stackView.addArrangedSubview(vc.view)
    vc.didMove(toParent: self)
  }
}
