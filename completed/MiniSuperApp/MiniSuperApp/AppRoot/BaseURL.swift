import Foundation

struct BaseURL {
  var financeBaseURL: URL {
    #if UITESTING
    return URL(string: "http://localhost:8080")!
    #else
    return URL(string: "https://finance.superapp.com/api/v1")!
    #endif
  }
}
