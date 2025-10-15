// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderResolver",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderResolver",
            targets: ["ReminderResolver"]),
    ],
    dependencies: [
      .package(path: "../ReminderPersistenceContracts")
    ],
    targets: [
        .target(
            name: "ReminderResolver",
            dependencies: [
              "ReminderPersistenceContracts"
            ]),

    ]
)
