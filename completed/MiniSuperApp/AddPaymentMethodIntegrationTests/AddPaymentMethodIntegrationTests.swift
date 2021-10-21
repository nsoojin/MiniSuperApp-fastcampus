import XCTest
import Hammer
import FinanceRepository
import FinanceRepositoryTestSupport
import AddPaymentMethodTestSupport
import ModernRIBs
import RIBsUtil
import FinanceEntity
@testable import AddPaymentMethodImp

class AddPaymentMethodIntegrationTests: XCTestCase {
  
  private var eventGenerator: EventGenerator!
  private var dependency: AddPaymentMethodDependencyMock!
  private var listener: AddPaymentMethodListenerMock!
  private var viewController: UIViewController!
  private var router: Routing!
  
  private var repository: CardOnFileRepositoryMock {
    dependency.cardOnFileRepository as! CardOnFileRepositoryMock
  }
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    self.dependency = AddPaymentMethodDependencyMock()
    self.listener = AddPaymentMethodListenerMock()
    
    let builder = AddPaymentMethodBuilder(dependency: self.dependency)
    let router = builder.build(withListener: self.listener, closeButtonType: .close)
    
    let navigation = NavigationControllerable(root: router.viewControllable)
    self.viewController = navigation.uiviewController
    
    eventGenerator = try EventGenerator(viewController: navigation.navigationController)
    
    router.load()
    router.interactable.activate()
    
    self.router = router
  }
  
  func testAddPaymentMethod() throws {
    // given
    repository.addedPaymentMethod = PaymentMethod(
      id: "1234",
      name: "",
      digits: "",
      color: "",
      isPrimary: false
    )
    
    let cardNumberTF = try eventGenerator.viewWithIdentifier("addpaymentmethod_cardnumber_textfield")
    try eventGenerator.fingerTap(at: cardNumberTF)
    try eventGenerator.keyType("1234123412341234")
    
    let cvc = try eventGenerator.viewWithIdentifier("addpaymentmethod_security_textfield")
    try eventGenerator.fingerTap(at: cvc)
    try eventGenerator.keyType("123")
    
    let expiry = try eventGenerator.viewWithIdentifier("addpaymentmethod_expiry_textfield")
    try eventGenerator.fingerTap(at: expiry)
    try eventGenerator.keyType("1212")
    
    // when
    let confirm = try eventGenerator.viewWithIdentifier("addpaymentmethod_addcard_button")
    try eventGenerator.fingerTap(at: confirm)
    
    // then
    XCTAssertEqual(repository.addCardCallCount, 1)
    try eventGenerator.wait(0.2)
    XCTAssertEqual(listener.addPaymentMethodDidAddCardCallCount, 1)
    XCTAssertEqual(listener.addPaymentMethodDidAddCardPaymentMethod?.id, "1234")
  }
}

final class AddPaymentMethodDependencyMock: AddPaymentMethodDependency {
  var cardOnFileRepository: CardOnFileRepository = CardOnFileRepositoryMock()
}
