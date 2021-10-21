import UIKit
import ModernRIBs

protocol AppRootPresentableListener: AnyObject {
  
}

final class RootTabBarController: UITabBarController, AppRootViewControllable, AppRootPresentable {
  weak var listener: AppRootPresentableListener?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tabBar.isTranslucent = false
    tabBar.tintColor = .black
    tabBar.backgroundColor = .white
  }
  
  func setViewControllers(_ viewControllers: [ViewControllable]) {
    super.setViewControllers(viewControllers.map(\.uiviewController), animated: false)
  }
}
