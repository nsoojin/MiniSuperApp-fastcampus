import Foundation
import Network
import FinanceEntity

struct CardOnFileRequest: Request {
  typealias Output = CardOnFileResponse
  
  let endpoint: URL
  let method: HTTPMethod
  let query: QueryItems
  let header: HTTPHeader
  
  init(baseURL: URL) {
    self.endpoint = baseURL.appendingPathComponent("/cards")
    self.method = .get
    self.query = [:]
    self.header = [:]
  }
}

struct CardOnFileResponse: Decodable {
  let cards: [PaymentMethod]
}
