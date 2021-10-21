@testable import TopupImp
import XCTest
import FinanceEntity
import FinanceRepositoryTestSupport

final class EnterAmountInteractorTests: XCTestCase {
  
  private var sut: EnterAmountInteractor!
  private var presenter: EnterAmountPresentableMock!
  private var dependency: EnterAmountDependencyMock!
  private var listener: EnterAmountListenerMock!
  
  private var repository: SuperPayRepositoryMock! {
    dependency.superPayRepository as? SuperPayRepositoryMock
  }
  
  override func setUp() {
    super.setUp()
    
    self.presenter = EnterAmountPresentableMock()
    self.dependency = EnterAmountDependencyMock()
    self.listener = EnterAmountListenerMock()
    
    sut = EnterAmountInteractor(
      presenter: self.presenter,
      dependency: self.dependency
    )
    sut.listener = self.listener
  }
  
  // MARK: - Tests
  func testActivate() {
    // given
    let paymentMethod = PaymentMethod(
      id: "id_0",
      name: "name_0",
      digits: "9999",
      color: "#13ABE8FF",
      isPrimary: false
    )
    dependency.selectedPaymentMethodSubject.send(paymentMethod)
    
    // when
    sut.activate()
    
    // then
    XCTAssertEqual(presenter.updateSelectedPaymentMethodCallCount, 1)
    XCTAssertEqual(presenter.updateSelectedPaymentMethodViewModel?.name, "name_0 9999")
    XCTAssertNotNil(presenter.updateSelectedPaymentMethodViewModel?.image)
  }
  
  func testTopupWithValidAmount() {
    // given
    let paymentMethod = PaymentMethod(
      id: "id_0",
      name: "name_0",
      digits: "9999",
      color: "#13ABE8FF",
      isPrimary: false
    )
    dependency.selectedPaymentMethodSubject.send(paymentMethod)
    
    // when
    sut.didTapTopup(with: 1_000_000)
    
    // then
    XCTAssertEqual(presenter.startLoadingCallCount, 1)
    XCTAssertEqual(presenter.stopLoadingCallCount, 1)
    XCTAssertEqual(repository.topupCallCount, 1)
    XCTAssertEqual(repository.paymentMethodID, "id_0")
    XCTAssertEqual(repository.topupAmount, 1_000_000)
    XCTAssertEqual(listener.enterAmountDidFinishTopupCallCount, 1)
  }
  
  func testTopupWithFailure() {
    // given
    let paymentMethod = PaymentMethod(
      id: "id_0",
      name: "name_0",
      digits: "9999",
      color: "#13ABE8FF",
      isPrimary: false
    )
    dependency.selectedPaymentMethodSubject.send(paymentMethod)
    repository.shouldTopupSucceed = false
    
    // when
    sut.didTapTopup(with: 1_000_000)
    
    // then
    XCTAssertEqual(presenter.startLoadingCallCount, 1)
    XCTAssertEqual(presenter.stopLoadingCallCount, 1)
    XCTAssertEqual(listener.enterAmountDidFinishTopupCallCount, 0)
  }
  
  func testDidTapClose() {
    // given
    
    // when
    sut.didTapClose()
    
    // then
    XCTAssertEqual(listener.enterAmountDidTapCloseCallCount, 1)
  }
  
  func testDidTapPaymentMethod() {
    // given
    
    // when
    sut.didTapPaymentMethod()
    
    // then
    XCTAssertEqual(listener.enterAmountDidTapPaymentMethodCallCount, 1)
  }
  
}
