import Foundation
import AppHome
import FinanceHome
import ProfileHome
import FinanceRepository
import ModernRIBs
import TransportHome
import TransportHomeImp
import Topup
import TopupImp
import AddPaymentMethod
import AddPaymentMethodImp
import Network
import NetworkImp
import CombineSchedulers

final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency, TopupDependency, AddPaymentMethodDependency {
  
  var cardOnFileRepository: CardOnFileRepository
  var superPayRepository: SuperPayRepository
  var mainQueue: AnySchedulerOf<DispatchQueue> { .main }
  
  lazy var transportHomeBuildable: TransportHomeBuildable = {
    return TransportHomeBuilder(dependency: self)
  }()
  
  lazy var topupBuildable: TopupBuildable = {
    return TopupBuilder(dependency: self)
  }()
  
  lazy var addPaymentMethodBuildable: AddPaymentMethodBuildable = {
    return AddPaymentMethodBuilder(dependency: self)
  }()
  
  var topupBaseViewController: ViewControllable { rootViewController.topViewControllable }
  
  private let rootViewController: ViewControllable
  
  init(
    dependency: AppRootDependency,
    rootViewController: ViewControllable
  ) {
    #if UITESTING
    let config = URLSessionConfiguration.default
    #else
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [SuperAppURLProtocol.self]
    setupURLProtocol()
    #endif
    
    let network = NetworkImp(session: URLSession(configuration: config))
    
    self.cardOnFileRepository = CardOnFileRepositoryImp(network: network, baseURL: BaseURL().financeBaseURL)
    self.cardOnFileRepository.fetch()
    
    self.superPayRepository = SuperPayRepositoryImp(network: network, baseURL: BaseURL().financeBaseURL)
    self.rootViewController = rootViewController
    super.init(dependency: dependency)
  }
}
