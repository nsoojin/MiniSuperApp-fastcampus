@testable import TopupImp
import XCTest
import Foundation
import SnapshotTesting
import FinanceEntity

final class CardOnFileViewTests: XCTestCase {
  
  func testCardOnFile() {
    // given
    let viewModels = [
      PaymentMethodViewModel(PaymentMethod(id: "0", name: "우리은행", digits: "1111", color: "#3478f6ff", isPrimary: false)),
      PaymentMethodViewModel(PaymentMethod(id: "1", name: "현대카드", digits: "2222", color: "#f19a38ff", isPrimary: false)),
      PaymentMethodViewModel(PaymentMethod(id: "2", name: "신한카드", digits: "3333", color: "#78c5f5ff", isPrimary: false)),
    ]
    
    // when
    let sut = CardOnFileViewController()
    sut.update(with: viewModels)
    
    // then
    assertSnapshot(matching: sut, as: .image(on: .iPhoneXsMax))
  }
  
}
