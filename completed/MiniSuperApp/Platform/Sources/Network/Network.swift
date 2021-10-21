import Combine
import Foundation

public typealias QueryItems = [String: AnyHashable]
public typealias HTTPHeader = [String: String]

public protocol Request: Hashable {
  associatedtype Output: Decodable
  
  var endpoint: URL { get }
  var method: HTTPMethod { get }
  var query: QueryItems { get }
  var header: HTTPHeader { get }
}

public protocol Network {
  func send<T: Request>(_ request: T) -> AnyPublisher<Response<T.Output>, Error>
}

public struct Response<T: Decodable> {
  public let output: T
  public let statusCode: Int
  
  public init(output: T, statusCode: Int) {
    self.output = output
    self.statusCode = statusCode
  }
}
