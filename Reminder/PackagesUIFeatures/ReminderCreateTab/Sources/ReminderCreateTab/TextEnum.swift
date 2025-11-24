//
//  TextEnum.swift
//  ReminderCreateTab
//
//  Created by OpenAI Assistant on 18.11.2025.
//

import Foundation

enum TextEnum: String {
  case deleteEventTitle
  case deleteEventMessage
  case eventTitleEmptyAlert
  case eventNotSavedAlert
  case eventDeleteFailedAlert
  case eventNotFoundAlert
  case categoryNotFoundAlert
  case eventsNotFetchedAlert

  case createEventScreenTitle
  case createEventButtonTitle
  case editEventScreenTitle
  case saveEventButtonTitle

  case yearTitle
  case monthTitle
  case dayTitle
  case notRepeatTitle

  case plannedRemindsSectionTitle
  case noPlannedRemindsText
  case notificationsNotAllowedText
  case allowNotificationsButton

  case eventDetailsSectionTitle
  case eventTitleTitle
  case eventTitlePlaceholder
  case eventCommentTitle
  case eventCommentPlaceholder
  case eventDateTitle
  case eventDateLabel
  case selectEventDateTitle
  case cancelTitle
  case deleteButtonTitle
  case doneTitle

  case alertsSectionTitle
  case repeatEveryTitle
  case addRemindTimeButtonTitle
  case remindTime1Title
  case remindTime2Title
  case remindTime3Title

  case categoriesNavigationTitle
  case noCategoriesText
  case eventSingular
  case eventsPlural
  case addNewEventButtonTitle
  case categoryNoEventsText
  case addedEventsFormat

  var localized: String {
    NSLocalizedString(rawValue, bundle: .module, comment: "")
  }
}
