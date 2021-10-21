import ModernRIBs
import SuperUI
import TransportHome

protocol AppHomeInteractable: Interactable, TransportHomeListener {
  var router: AppHomeRouting? { get set }
  var listener: AppHomeListener? { get set }
}

protocol AppHomeViewControllable: ViewControllable {

}

final class AppHomeRouter: ViewableRouter<AppHomeInteractable, AppHomeViewControllable>, AppHomeRouting {
  
  private let transportHomeBuildable: TransportHomeBuildable
  private var transportHomeRouting: Routing?
  private let transitioningDelegate: PushModalPresentationController
  
  init(
    interactor: AppHomeInteractable,
    viewController: AppHomeViewControllable,
    transportHomeBuildable: TransportHomeBuildable
  ) {
    self.transitioningDelegate = PushModalPresentationController()
    self.transportHomeBuildable = transportHomeBuildable
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  func attachTransportHome() {
    if transportHomeRouting != nil {
      return
    }
    
    let router = transportHomeBuildable.build(withListener: interactor)
    presentWithPushTransition(router.viewControllable, animated: true)
    attachChild(router)
    self.transportHomeRouting = router
  }
  
  func detachTransportHome() {
    guard let router = transportHomeRouting else {
      return
    }
    
    viewController.dismiss(completion: nil)
    self.transportHomeRouting = nil
    detachChild(router)
  }
  
  private func presentWithPushTransition(_ viewControllable: ViewControllable, animated: Bool) {
    viewControllable.uiviewController.modalPresentationStyle = .custom
    viewControllable.uiviewController.transitioningDelegate = transitioningDelegate
    viewController.present(viewControllable, animated: true, completion: nil)
  }
  
}
