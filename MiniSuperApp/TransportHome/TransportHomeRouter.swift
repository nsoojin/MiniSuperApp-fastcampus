import ModernRIBs

protocol TransportHomeInteractable: Interactable {
  var router: TransportHomeRouting? { get set }
  var listener: TransportHomeListener? { get set }
}

protocol TransportHomeViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TransportHomeRouter: ViewableRouter<TransportHomeInteractable, TransportHomeViewControllable>, TransportHomeRouting {
  
  override init(
    interactor: TransportHomeInteractable,
    viewController: TransportHomeViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
}
