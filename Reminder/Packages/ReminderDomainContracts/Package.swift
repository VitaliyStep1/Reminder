// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderDomainContracts",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderDomainContracts",
            targets: ["ReminderDomainContracts"]),
    ],
    dependencies: [
      .package(path: "../ReminderPersistenceContracts")
    ],
    targets: [
        .target(
            name: "ReminderDomainContracts",
            dependencies: [
              "ReminderPersistenceContracts",
            ],
        ),

    ]
)
