// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "ReminderTuistSupport",
  platforms: [
    .iOS(.v16)
  ],
  dependencies: [
    .package(path: "../Reminder/Packages/ReminderConfigurations"),
    .package(path: "../Reminder/Packages/ReminderDomainContracts"),
    .package(path: "../Reminder/Packages/ReminderDomain"),
    .package(path: "../Reminder/Packages/ReminderPersistenceContracts"),
    .package(path: "../Reminder/Packages/ReminderPersistence"),
    .package(path: "../Reminder/Packages/ReminderResolver"),
    .package(path: "../Reminder/Packages/ReminderDependencies"),
    .package(path: "../Reminder/Packages/ReminderUserDefaultsStorage"),
    
    .package(path: "../Reminder/PackagesUI/ReminderSharedUI"),
    .package(path: "../Reminder/PackagesUI/ReminderNavigationContracts"),
    .package(path: "../Reminder/PackagesUI/ReminderMainTabViewContracts"),
    .package(path: "../Reminder/PackagesUI/ReminderMainTabView"),
    
    .package(path: "../Reminder/PackagesUIFeatures/ReminderCreateTab"),
    .package(path: "../Reminder/PackagesUIFeatures/ReminderClosestTab"),
    .package(path: "../Reminder/PackagesUIFeatures/ReminderSettingsTab"),
    .package(path: "../Reminder/PackagesUIFeatures/ReminderStartUI"),
  ]
)
