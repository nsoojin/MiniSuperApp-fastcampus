import Foundation

typealias Path = String
typealias MockResponse = (statusCode: Int, data: Data?)

final class SuperAppURLProtocol: URLProtocol {
  static var successMock: [Path: MockResponse] = [:]
  static var failureErrors: [Path: Error] = [:]
  
  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }
  
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  override func startLoading() {
    if let path = request.url?.path {
      if let mockResponse = SuperAppURLProtocol.successMock[path] {
        client?.urlProtocol(self, didReceive: HTTPURLResponse(
          url: request.url!,
          statusCode: mockResponse.statusCode,
          httpVersion: nil,
          headerFields: nil)!, cacheStoragePolicy: .notAllowed)
        mockResponse.data.map { client?.urlProtocol(self, didLoad: $0) }
      } else if let error = SuperAppURLProtocol.failureErrors[path] {
        client?.urlProtocol(self, didFailWithError: error)
      } else {
        client?.urlProtocol(self, didFailWithError: MockSessionError.notSupported)
      }
    }
    
    client?.urlProtocolDidFinishLoading(self)
  }
  
  override func stopLoading() {
    
  }

}

enum MockSessionError: Error {
  case notSupported
}
