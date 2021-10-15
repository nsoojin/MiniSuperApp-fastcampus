import Foundation
import ModernRIBs
import Combine

open class ViewableRoutingMock: ViewableRouting {
  // Variables
  public var viewControllable: ViewControllable
  public var interactable: Interactable { didSet { interactableSetCallCount += 1 } }
  public var interactableSetCallCount = 0
  public var children: [Routing] = [Routing]() { didSet { childrenSetCallCount += 1 } }
  public var childrenSetCallCount = 0
  public var lifecycleSubject = PassthroughSubject<RouterLifecycle, Never>() {
    didSet {
      lifecycleSubjectSetCallCount += 1
    }
  }
  public var lifecycleSubjectSetCallCount = 0
  public var lifecycle: AnyPublisher<RouterLifecycle, Never> { return lifecycleSubject.eraseToAnyPublisher() }

  // Function Handlers
  public var loadHandler: (() -> ())?
  public var loadCallCount: Int = 0
  public var attachChildHandler: ((_ child: Routing) -> ())?
  public var attachChildCallCount: Int = 0
  public var detachChildHandler: ((_ child: Routing) -> ())?
  public var detachChildCallCount: Int = 0

  public init(
    interactable: Interactable,
    viewControllable: ViewControllable
  ) {
    self.interactable = interactable
    self.viewControllable = viewControllable
  }

  public func load() {
    loadCallCount += 1
    if let loadHandler = loadHandler {
      return loadHandler()
    }
  }

  public func attachChild(_ child: Routing) {
    attachChildCallCount += 1
    if let attachChildHandler = attachChildHandler {
      return attachChildHandler(child)
    }
  }

  public func detachChild(_ child: Routing) {
    detachChildCallCount += 1
    if let detachChildHandler = detachChildHandler {
      return detachChildHandler(child)
    }
  }
}
