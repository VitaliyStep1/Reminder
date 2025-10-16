// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderDomain",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderDomain",
            targets: ["ReminderDomain"]),
    ],
    dependencies: [
      .package(path: "../ReminderDomainContracts"),
      .package(path: "../ReminderPersistence"),
      .package(path: "../ReminderPersistenceContracts"),
    ],
    targets: [
        .target(
            name: "ReminderDomain",
            dependencies: [
              "ReminderDomainContracts",
              "ReminderPersistence",
              "ReminderPersistenceContracts",
            ]
        ),
    ]
)
