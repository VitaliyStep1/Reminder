// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderPersistence",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderPersistence",
            targets: ["ReminderPersistence"]),
    ],
    dependencies: [
      .package(path: "../ReminderPersistenceContracts")
    ],
    targets: [
        .target(
            name: "ReminderPersistence",
            dependencies: [
              "ReminderPersistenceContracts"
            ],
            resources: [
              .process("Model.xcdatamodeld")
            ]
        ),
    ]
)
