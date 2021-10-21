import ModernRIBs

public protocol ProfileHomeDependency: Dependency {
}

final class ProfileHomeComponent: Component<ProfileHomeDependency> {
}

// MARK: - Builder

public protocol ProfileHomeBuildable: Buildable {
  func build(withListener listener: ProfileHomeListener) -> ViewableRouting
}

public final class ProfileHomeBuilder: Builder<ProfileHomeDependency>, ProfileHomeBuildable {
  
  public override init(dependency: ProfileHomeDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: ProfileHomeListener) -> ViewableRouting {
    let _ = ProfileHomeComponent(dependency: dependency)
    let viewController = ProfileHomeViewController()
    let interactor = ProfileHomeInteractor(presenter: viewController)
    interactor.listener = listener
    return ProfileHomeRouter(interactor: interactor, viewController: viewController)
  }
}
