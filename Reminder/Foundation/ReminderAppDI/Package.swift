// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderAppDI",
    platforms: [
      .iOS(.v17)
    ],
    products: [
        .library(
            name: "ReminderAppDI",
            targets: ["ReminderAppDI"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
      .package(path: "../ReminderDomain"),
      .package(path: "../ReminderDomainContracts"),
      .package(path: "../ReminderPersistence"),
      .package(path: "../ReminderPersistenceContracts"),
      .package(path: "../ReminderConfigurations"),
      .package(path: "../ReminderUserDefaultsStorage"),
      .package(path: "../ReminderClosest"),
      .package(path: "../ReminderCreate"),
      .package(path: "../ReminderSettings"),
      .package(path: "../ReminderMainTabView"),
      .package(path: "../ReminderMainTabViewContracts"),
      .package(path: "../ReminderStart"),
      .package(path: "../Language"),
    ],
    targets: [
      .target(
        name: "ReminderAppDI",
        dependencies: [
          .product(name: "Swinject", package: "Swinject"),
          "ReminderDomain",
          "ReminderDomainContracts",
          "ReminderPersistence",
          "ReminderPersistenceContracts",
          "ReminderConfigurations",
          "ReminderUserDefaultsStorage",
          "ReminderClosest",
          "ReminderCreate",
          "ReminderSettings",
          "ReminderMainTabView",
          "ReminderMainTabViewContracts",
          "ReminderStart",
          "Language",
        ]),
      
    ]
)
