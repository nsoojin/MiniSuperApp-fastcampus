import ModernRIBs

protocol ProfileHomeInteractable: Interactable {
  var router: ProfileHomeRouting? { get set }
  var listener: ProfileHomeListener? { get set }
}

protocol ProfileHomeViewControllable: ViewControllable {
}

final class ProfileHomeRouter: ViewableRouter<ProfileHomeInteractable, ProfileHomeViewControllable>, ProfileHomeRouting {
  
  override init(interactor: ProfileHomeInteractable, viewController: ProfileHomeViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
