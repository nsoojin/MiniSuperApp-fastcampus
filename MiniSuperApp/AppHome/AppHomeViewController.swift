import ModernRIBs
import UIKit

protocol AppHomePresentableListener: AnyObject {
}

final class AppHomeViewController: UIViewController, AppHomePresentable, AppHomeViewControllable {
  
  weak var listener: AppHomePresentableListener?
  
  private let widgetStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .top
    stackView.spacing = 20
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
  
  func updateWidget(_ viewModels: [HomeWidgetViewModel]) {
    let views = viewModels.map { HomeWidgetView(viewModel: $0) }
    
    views.forEach {
      $0.addShadowWithRoundedCorners(12)
      widgetStackView.addArrangedSubview($0)
    }
  }
  
  private func setupViews() {
    title = "홈"
    tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    view.backgroundColor = .backgroundColor
    view.addSubview(widgetStackView)
    
    NSLayoutConstraint.activate([
      widgetStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
      widgetStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      widgetStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    ])
  }
  
}
