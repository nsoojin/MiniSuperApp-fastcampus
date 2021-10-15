import Foundation
import ModernRIBs
import Combine

public final class RoutingMock: Routing {
  
  public var loadHandler: (() -> ())?
  public var loadCallCount: Int = 0
  public var attachChildHandler: ((_ child: Routing) -> ())?
  public var attachChildCallCount: Int = 0
  public var detachChildHandler: ((_ child: Routing) -> ())?
  public var detachChildCallCount: Int = 0
  
  public var interactable: Interactable
  
  public var children: [Routing] = [Routing]() { didSet { childrenSetCallCount += 1 } }
  public var childrenSetCallCount = 0
  
  public init(
    interactable: Interactable
  ) {
    self.interactable = interactable
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
  
  public var lifecycleSubject = PassthroughSubject<RouterLifecycle, Never>() {
    didSet {
      lifecycleSubjectSetCallCount += 1
    }
  }
  public var lifecycleSubjectSetCallCount = 0
  public var lifecycle: AnyPublisher<RouterLifecycle, Never> { return lifecycleSubject.eraseToAnyPublisher() }
}
