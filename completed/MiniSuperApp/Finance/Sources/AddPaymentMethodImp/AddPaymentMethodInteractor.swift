import ModernRIBs
import Combine
import FinanceEntity
import FinanceRepository
import AddPaymentMethod
import Foundation

protocol AddPaymentMethodRouting: ViewableRouting {
}

protocol AddPaymentMethodPresentable: Presentable {
  var listener: AddPaymentMethodPresentableListener? { get set }
}

protocol AddPaymentMethodInteractorDependency {
  var cardOnFileRepository: CardOnFileRepository { get }
}

final class AddPaymentMethodInteractor: PresentableInteractor<AddPaymentMethodPresentable>, AddPaymentMethodInteractable, AddPaymentMethodPresentableListener {
  
  weak var router: AddPaymentMethodRouting?
  weak var listener: AddPaymentMethodListener?
  
  private let dependency: AddPaymentMethodInteractorDependency
  
  private var cancellables: Set<AnyCancellable>
  
  init(
    presenter: AddPaymentMethodPresentable,
    dependency: AddPaymentMethodInteractorDependency
  ) {
    self.dependency = dependency
    self.cancellables = .init()
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  override func willResignActive() {
    super.willResignActive()
  }
  
  func didTapClose() {
    listener?.addPaymentMethodDidTapClose()
  }
  
  func didTapConfirm(with number: String, cvc: String, expiry: String) {
    let info = AddPaymentMethodInfo(number: number, cvc: cvc, expiration: expiry)
    dependency.cardOnFileRepository.addCard(info: info)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { _ in },
        receiveValue: { [weak self] method in
          self?.listener?.addPaymentMethodDidAddCard(paymentMethod: method)
        }
      ).store(in: &cancellables)
  }
}
