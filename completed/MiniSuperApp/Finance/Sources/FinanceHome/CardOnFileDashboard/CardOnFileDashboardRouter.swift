import ModernRIBs

protocol CardOnFileDashboardInteractable: Interactable {
  var router: CardOnFileDashboardRouting? { get set }
  var listener: CardOnFileDashboardListener? { get set }
}

protocol CardOnFileDashboardViewControllable: ViewControllable {
}

final class CardOnFileDashboardRouter: ViewableRouter<CardOnFileDashboardInteractable, CardOnFileDashboardViewControllable>, CardOnFileDashboardRouting {
  
  override init(interactor: CardOnFileDashboardInteractable, viewController: CardOnFileDashboardViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
