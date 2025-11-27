// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderPersistence",
    platforms: [
      .iOS(.v17)
    ],
    products: [
        .library(
            name: "ReminderPersistence",
            targets: ["ReminderPersistence"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
      .package(path: "../ReminderPersistenceContracts")
    ],
    targets: [
        .target(
            name: "ReminderPersistence",
            dependencies: [
              .product(name: "Swinject", package: "Swinject"),
              "ReminderPersistenceContracts",
            ],
            resources: [
              .process("Model.xcdatamodeld")
            ]
        ),
    ]
)
