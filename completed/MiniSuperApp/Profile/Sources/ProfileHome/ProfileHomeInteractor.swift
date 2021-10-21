import ModernRIBs

protocol ProfileHomeRouting: ViewableRouting {
}

protocol ProfileHomePresentable: Presentable {
  var listener: ProfileHomePresentableListener? { get set }
}

public protocol ProfileHomeListener: AnyObject {
}

final class ProfileHomeInteractor: PresentableInteractor<ProfileHomePresentable>, ProfileHomeInteractable, ProfileHomePresentableListener {
  
  weak var router: ProfileHomeRouting?
  weak var listener: ProfileHomeListener?
  
  override init(presenter: ProfileHomePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  override func willResignActive() {
    super.willResignActive()
  }
}
