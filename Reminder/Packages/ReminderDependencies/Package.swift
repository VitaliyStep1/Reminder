// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderDependencies",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderDependencies",
            targets: ["ReminderDependencies"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
      .package(path: "../ReminderResolver"),
      .package(path: "../ReminderDomain"),
      .package(path: "../ReminderPersistence"),
      .package(path: "../ReminderNavigation"),
      .package(path: "../ReminderStartUI"),
      .package(path: "../ReminderNavigationContracts"),
      .package(path: "../ReminderPersistenceContracts"),
      .package(path: "../ReminderDomainContracts"),
      .package(path: "../ReminderMainTabViewContracts"),
    ],
    targets: [
        .target(
          name: "ReminderDependencies",
          dependencies: [
            .product(name: "Swinject", package: "Swinject"),
            "ReminderResolver",
            "ReminderDomain",
            "ReminderPersistence",
            "ReminderNavigation",
            "ReminderStartUI",
            "ReminderNavigationContracts",
            "ReminderPersistenceContracts",
            "ReminderDomainContracts",
            "ReminderMainTabViewContracts",
          ]),

    ]
)
