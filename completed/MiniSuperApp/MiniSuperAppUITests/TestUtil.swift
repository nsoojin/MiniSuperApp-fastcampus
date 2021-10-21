import Foundation

enum TestUtilError: Error {
  case fileNotFound
}

final class TestUtil {
  static func path(for fileName: String, in bundleClass: AnyClass) throws -> String {
    if let path = Bundle(for: bundleClass).path(forResource: fileName, ofType: nil) {
      return path
    } else {
      throw TestUtilError.fileNotFound
    }
  }
}
