import Foundation
import ModernRIBs

public protocol TopupBuildable: Buildable {
  func build(withListener listener: TopupListener) -> Routing
}

public protocol TopupListener: AnyObject {
  func topupDidClose()
  func topupDidFinish()
}
