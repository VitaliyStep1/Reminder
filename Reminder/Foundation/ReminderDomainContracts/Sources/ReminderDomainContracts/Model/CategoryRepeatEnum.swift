//
//  CategoryRepeatEnum.swift
//  ReminderDomainContracts
//
//  Created by Vitaliy Stepanenko on 18.10.2025.
//

public enum CategoryRepeatEnum: Int, CaseIterable, Sendable {
  case repeatEveryYear_notChoose = 1
  case repeatEveryMonth_notChoose = 2
  case repeatEveryDay_notChoose = 3
  case notRepeat_notChoose = 4
  case repeatEveryYear_chooseAll = 5
  case repeatEveryMonth_chooseAll = 6
  case repeatEveryDay_chooseAll = 7
  case notRepeat_chooseAll = 8
  
  public init(fromRawValue: Int) {
    self = Self.init(rawValue: fromRawValue) ?? .repeatEveryYear_notChoose
  }
  
  public var defaultRemindRepeat: RemindRepeatEnum {
    switch self {
    case .repeatEveryYear_notChoose:
      return .everyYear
    case .repeatEveryMonth_notChoose:
      return .everyMonth
    case .repeatEveryDay_notChoose:
      return .everyDay
    case .notRepeat_notChoose:
      return .notRepeat
    case .repeatEveryYear_chooseAll:
      return .everyYear
    case .repeatEveryMonth_chooseAll:
      return .everyMonth
    case .repeatEveryDay_chooseAll:
      return .everyDay
    case .notRepeat_chooseAll:
      return .notRepeat
    }
  }
  
  public var chooseOptions: [RemindRepeatEnum] {
    switch self {
    case .repeatEveryYear_chooseAll,
        .repeatEveryMonth_chooseAll,
        .repeatEveryDay_chooseAll,
        .notRepeat_chooseAll:
      return [.everyYear, .everyMonth, .everyDay, .notRepeat]
    default:
      return []
    }
  }
}
