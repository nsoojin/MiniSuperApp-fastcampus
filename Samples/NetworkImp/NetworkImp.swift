import Foundation
import Network
import Combine

public final class NetworkImp: Network {
  
  private let session: URLSession
  
  public init(
    session: URLSession
  ) {
    self.session = session
  }
  
  public func send<T>(_ request: T) -> AnyPublisher<Response<T.Output>, Error> where T: Request {
    do {
      let urlRequest = try RequestFactory(request: request).urlRequestRepresentation()
      return session.dataTaskPublisher(for: urlRequest)
        .tryMap { data, response in
          let output = try JSONDecoder().decode(T.Output.self, from: data)
          return Response(output: output, statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        .eraseToAnyPublisher()
    } catch {
      return Fail(error: error).eraseToAnyPublisher()
    }
  }
  
}

private final class RequestFactory<T: Request> {
  
  let request: T
  private var urlComponents: URLComponents?
  
  init(request: T) {
    self.request = request
    self.urlComponents = URLComponents(url: request.endpoint, resolvingAgainstBaseURL: true)
  }
  
  func urlRequestRepresentation() throws -> URLRequest {
    switch request.method {
    case .get:
      return try makeGetRequest()
    case .post:
      return try makePostRequest()
    case .put:
      return try makePutRequest()
    }
  }
  
  private func makeGetRequest() throws -> URLRequest {
    if request.query.isEmpty == false {
      urlComponents?.queryItems = request.query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
    return try makeURLRequest()
  }
  
  private func makePostRequest() throws -> URLRequest {
    let body = try JSONSerialization.data(withJSONObject: request.query, options: [])
    return try makeURLRequest(httpBody: body)
  }
  
  private func makePutRequest() throws -> URLRequest {
    if request.query.isEmpty == false {
      urlComponents?.queryItems = request.query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
    return try makeURLRequest()
  }
  
  private func makeURLRequest(httpBody: Data? = nil) throws -> URLRequest {
    guard let url = urlComponents?.url else {
      throw NetworkError.invalidURL(url: request.endpoint.absoluteString)
    }
    
    var urlRequest = URLRequest(url: url)
    request.header.forEach {
      urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
    }
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.httpBody = httpBody
    
    return urlRequest
  }
}
