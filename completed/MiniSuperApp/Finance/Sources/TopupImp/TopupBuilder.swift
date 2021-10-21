import ModernRIBs
import FinanceRepository
import CombineUtil
import AddPaymentMethod
import FinanceEntity
import Topup
import CombineSchedulers

public protocol TopupDependency: Dependency {
  var topupBaseViewController: ViewControllable { get }
  var cardOnFileRepository: CardOnFileRepository { get }
  var superPayRepository: SuperPayRepository { get }
  var addPaymentMethodBuildable: AddPaymentMethodBuildable { get }
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
}

final class TopupComponent: Component<TopupDependency>, TopupInteractorDependency, EnterAmountDependency, CardOnFileDependency {
  var superPayRepository: SuperPayRepository { dependency.superPayRepository }
  var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { paymentMethodStream }
  var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
  var mainQueue: AnySchedulerOf<DispatchQueue> { dependency.mainQueue }
  fileprivate var topupBaseViewController: ViewControllable { dependency.topupBaseViewController }
  
  let paymentMethodStream: CurrentValuePublisher<PaymentMethod>
  
  var addPaymentMethodBuildable: AddPaymentMethodBuildable { dependency.addPaymentMethodBuildable }
  
  init(
    dependency: TopupDependency,
    paymentMethodStream: CurrentValuePublisher<PaymentMethod>
  ) {
    self.paymentMethodStream = paymentMethodStream
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

public final class TopupBuilder: Builder<TopupDependency>, TopupBuildable {
  
  public override init(dependency: TopupDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: TopupListener) -> Routing {
    let paymentMethodStream = CurrentValuePublisher(PaymentMethod(id: "", name: "", digits: "", color: "", isPrimary: false))
    
    let component = TopupComponent(dependency: dependency, paymentMethodStream: paymentMethodStream)
    let interactor = TopupInteractor(dependency: component)
    interactor.listener = listener
    
    let enterAmountBuilder = EnterAmountBuilder(dependency: component)
    let cardOnFileBuilder = CardOnFileBuilder(dependency: component)
    
    return TopupRouter(
      interactor: interactor,
      viewController: component.topupBaseViewController,
      addPaymentMethodBuildable: component.addPaymentMethodBuildable,
      enterAmountBuildable: enterAmountBuilder,
      cardOnFileBuildable: cardOnFileBuilder
    )
  }
}
