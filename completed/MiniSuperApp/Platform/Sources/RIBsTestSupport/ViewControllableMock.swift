import Foundation
import ModernRIBs
import UIKit

public final class ViewControllableMock: UIViewController, ViewControllable {
  
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public var presentCallCount = 0
  public override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    presentCallCount += 1
  }
  
  public var dismissCallCount = 0
  public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
    dismissCallCount += 1
  }

}
