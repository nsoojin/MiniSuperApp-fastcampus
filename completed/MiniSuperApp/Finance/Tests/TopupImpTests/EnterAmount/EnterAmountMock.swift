@testable import TopupImp
import Foundation
import CombineUtil
import FinanceEntity
import FinanceRepository
import FinanceRepositoryTestSupport
import CombineSchedulers
import RIBsTestSupport

final class EnterAmountPresentableMock: EnterAmountPresentable {
  
  var listener: EnterAmountPresentableListener?

  var updateSelectedPaymentMethodCallCount = 0
  var updateSelectedPaymentMethodViewModel: SelectedPaymentMethodViewModel?
  func updateSelectedPaymentMethod(with viewModel: SelectedPaymentMethodViewModel) {
    updateSelectedPaymentMethodCallCount += 1
    updateSelectedPaymentMethodViewModel = viewModel
  }
  
  var startLoadingCallCount = 0
  func startLoading() {
    startLoadingCallCount += 1
  }
  
  var stopLoadingCallCount = 0
  func stopLoading() {
    stopLoadingCallCount += 1
  }
  
  init() {
    
  }
}

final class EnterAmountDependencyMock: EnterAmountInteractorDependency {
  var mainQueue: AnySchedulerOf<DispatchQueue> { .immediate }
  
  var selectedPaymentMethodSubject = CurrentValuePublisher<PaymentMethod>(
    PaymentMethod(
      id: "",
      name: "",
      digits: "",
      color: "",
      isPrimary: false
    )
  )
  
  var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { selectedPaymentMethodSubject }
  var superPayRepository: SuperPayRepository = SuperPayRepositoryMock()
}

final class EnterAmountListenerMock: EnterAmountListener {
  
  var enterAmountDidTapCloseCallCount = 0
  func enterAmountDidTapClose() {
    enterAmountDidTapCloseCallCount += 1
  }
  
  var enterAmountDidTapPaymentMethodCallCount = 0
  func enterAmountDidTapPaymentMethod() {
    enterAmountDidTapPaymentMethodCallCount += 1
  }
  
  var enterAmountDidFinishTopupCallCount = 0
  func enterAmountDidFinishTopup() {
    enterAmountDidFinishTopupCallCount += 1
  }
  
}

final class EnterAmountBuildableMock: EnterAmountBuildable {
  
  var buildHandler: ((_ listener: EnterAmountListener) -> EnterAmountRouting)?
  
  var buildCallCount = 0
  func build(withListener listener: EnterAmountListener) -> EnterAmountRouting {
    buildCallCount += 1
    
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
}

final class EnterAmountRoutingMock: ViewableRoutingMock, EnterAmountRouting {
  
}
