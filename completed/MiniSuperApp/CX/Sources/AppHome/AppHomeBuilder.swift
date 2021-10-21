import ModernRIBs
import FinanceRepository
import TransportHome

public protocol AppHomeDependency: Dependency {
  var cardOnFileRepository: CardOnFileRepository { get }
  var superPayRepository: SuperPayRepository { get }
  var transportHomeBuildable: TransportHomeBuildable { get }
}

final class AppHomeComponent: Component<AppHomeDependency> {
  var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
  var superPayRepository: SuperPayRepository { dependency.superPayRepository }
  var transportHomeBuildable: TransportHomeBuildable { dependency.transportHomeBuildable }
}

// MARK: - Builder

public protocol AppHomeBuildable: Buildable {
  func build(withListener listener: AppHomeListener) -> ViewableRouting
}

public final class AppHomeBuilder: Builder<AppHomeDependency>, AppHomeBuildable {
  
  public override init(dependency: AppHomeDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: AppHomeListener) -> ViewableRouting {
    let component = AppHomeComponent(dependency: dependency)
    let viewController = AppHomeViewController()
    let interactor = AppHomeInteractor(presenter: viewController)
    interactor.listener = listener
    
    return AppHomeRouter(
      interactor: interactor,
      viewController: viewController,
      transportHomeBuildable: component.transportHomeBuildable
    )
  }
}
