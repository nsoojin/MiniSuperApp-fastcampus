import ModernRIBs
import Combine
import Foundation

protocol TransportHomeRouting: ViewableRouting {
}

protocol TransportHomePresentable: Presentable {
  var listener: TransportHomePresentableListener? { get set }
  
}

protocol TransportHomeListener: AnyObject {
  func transportHomeDidTapClose()
}

protocol TransportHomeInteractorDependency {
}

final class TransportHomeInteractor: PresentableInteractor<TransportHomePresentable>, TransportHomeInteractable, TransportHomePresentableListener {
  
  weak var router: TransportHomeRouting?
  weak var listener: TransportHomeListener?
  
  
  override init(presenter: TransportHomePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  func didTapBack() {
    listener?.transportHomeDidTapClose()
  }
}
