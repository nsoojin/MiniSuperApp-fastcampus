// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CX",
  platforms: [.iOS(.v14)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "AppHome",
      targets: ["AppHome"]
    ),
  ],
  dependencies: [
    .package(name: "ModernRIBs", url: "https://github.com/DevYeom/ModernRIBs", .exact("1.0.1")),
    .package(path: "../Finance"),
    .package(path: "../Transport"),
    .package(path: "../Platform")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "AppHome",
      dependencies: [
        "ModernRIBs",
        .product(name: "FinanceRepository", package: "Finance"),
        .product(name: "TransportHome", package: "Transport"),
        .product(name: "SuperUI", package: "Platform"),
      ]
    ),
  ]
)
