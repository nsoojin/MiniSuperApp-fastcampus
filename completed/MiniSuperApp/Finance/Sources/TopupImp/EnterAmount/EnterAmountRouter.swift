import ModernRIBs

protocol EnterAmountInteractable: Interactable {
  var router: EnterAmountRouting? { get set }
  var listener: EnterAmountListener? { get set }
}

protocol EnterAmountViewControllable: ViewControllable {
}

final class EnterAmountRouter: ViewableRouter<EnterAmountInteractable, EnterAmountViewControllable>, EnterAmountRouting {
  
  override init(interactor: EnterAmountInteractable, viewController: EnterAmountViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
