// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Transport",
  platforms: [.iOS(.v14)],
  products: [
    .library(
      name: "TransportHome",
      targets: ["TransportHome"]
    ),
    .library(
      name: "TransportHomeImp",
      targets: ["TransportHomeImp"]
    ),
  ],
  dependencies: [
    .package(name: "ModernRIBs", url: "https://github.com/DevYeom/ModernRIBs", .exact("1.0.1")),
    .package(path: "../Finance"),
    .package(path: "../Platform")
  ],
  targets: [
    .target(
      name: "TransportHome",
      dependencies: [
        "ModernRIBs",
      ]
    ),
    .target(
      name: "TransportHomeImp",
      dependencies: [
        "ModernRIBs",
        "TransportHome",
        .product(name: "FinanceRepository", package: "Finance"),
        .product(name: "Topup", package: "Finance"),
        .product(name: "SuperUI", package: "Platform"),
      ],
      resources: [
        .process("Resources"),
      ]
    ),
  ]
)
