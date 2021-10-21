@testable import TopupImp
import XCTest
import RIBsTestSupport
import AddPaymentMethodTestSupport
import ModernRIBs

final class TopupRouterTests: XCTestCase {
  
  private var sut: TopupRouter!
  private var interactor: TopupInteractableMock!
  private var viewController: ViewControllableMock!
  private var addPaymentMethodBuildable: AddPaymentMethodBuildableMock!
  private var enterAmountBuildable: EnterAmountBuildableMock!
  private var cardOnFileBuildable: CardOnFileBuildableMock!
  
  override func setUp() {
    super.setUp()
    
    interactor = TopupInteractableMock()
    viewController = ViewControllableMock()
    addPaymentMethodBuildable = AddPaymentMethodBuildableMock()
    enterAmountBuildable = EnterAmountBuildableMock()
    cardOnFileBuildable = CardOnFileBuildableMock()
    
    sut = TopupRouter(
      interactor: interactor,
      viewController: viewController,
      addPaymentMethodBuildable: addPaymentMethodBuildable,
      enterAmountBuildable: enterAmountBuildable,
      cardOnFileBuildable: cardOnFileBuildable
    )
  }
  
  // MARK: - Tests
  
  func testAttachAddPaymentMethod() {
    // given
    
    // when
    sut.attachAddPaymentMethod(closeButtonType: .close)
    
    // then
    XCTAssertEqual(addPaymentMethodBuildable.buildCallCount, 1)
    XCTAssertEqual(addPaymentMethodBuildable.closeButtonType, .close)
    XCTAssertEqual(viewController.presentCallCount, 1)
  }
  
  func testAttachEnterAmount() {
    // given
    let router = EnterAmountRoutingMock(
      interactable: Interactor(),
      viewControllable: ViewControllableMock()
    )
    
    var assignedListener: EnterAmountListener?
    enterAmountBuildable.buildHandler = { listener in
      assignedListener = listener
      return router
    }
    
    // when
    sut.attachEnterAmount()
    
    // then
    XCTAssertTrue(assignedListener === interactor)
    XCTAssertEqual(enterAmountBuildable.buildCallCount, 1)
  }
  
  func testAttachEnterAmountOnNavigation() {
    // given
    let router = EnterAmountRoutingMock(
      interactable: Interactor(),
      viewControllable: ViewControllableMock()
    )
    
    var assignedListener: EnterAmountListener?
    enterAmountBuildable.buildHandler = { listener in
      assignedListener = listener
      return router
    }
    
    // when
    sut.attachAddPaymentMethod(closeButtonType: .close)
    sut.attachEnterAmount()
    
    // then
    XCTAssertTrue(assignedListener === interactor)
    XCTAssertEqual(enterAmountBuildable.buildCallCount, 1)
    XCTAssertEqual(viewController.presentCallCount, 1)
    XCTAssertEqual(sut.children.count, 1)
  }
  
}
