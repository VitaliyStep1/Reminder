//
//  EventScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import SwiftUI
import ReminderSharedUI

public struct EventScreenView: View {
  @ObservedObject var store: EventViewStore
  @ObservedObject var eventData: EventData
  let interactor: EventInteractor

  public init(store: EventViewStore, interactor: EventInteractor) {
    _store = ObservedObject(wrappedValue: store)
    _eventData = ObservedObject(wrappedValue: store.eventData)
    self.interactor = interactor
  }
  
  public var body: some View {
    ZStack {
      BackgroundSharedView()
      contentView
    }
    .disabled(store.isViewBlocked)
    .sharedErrorAlert(
      isPresented: $store.isAlertVisible,
      message: store.alertInfo.message,
      completion: store.alertInfo.completion
    )
    .sharedDeleteConfirmationDialog(
      isPresented: $store.isConfirmationDialogVisible,
      title: store.confirmationDialogInfo.title,
      deleteAction: store.confirmationDialogInfo.deleteButtonHandler,
      message: store.confirmationDialogInfo.message
    )
    .onAppear {
      interactor.onAppear()
    }
  }
  
  //MARK: - Views
  
  var contentView: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 24) {
        EventScreenTitleView(title: store.viewTitle)
        EventSectionContainer(title: "Event details", systemImageName: "square.and.pencil") {
          titleSubSectionView
          sectionDivider
          commentSubSectionView
          sectionDivider
          dateSubSectionView
        }
        EventSectionContainer(title: "Alerts", systemImageName: "bell.badge") {
          repeatSubSectionView
          sectionDivider
          remindTimeView()
        }
        EventSectionContainer(title: "Planned Reminds", systemImageName: "square.and.pencil") {
          switch store.plannedRemindsRepresentationEnum {
          case .noRemindPermission:
            noRemindPermissionView
          case .noPlannedReminds:
            noPlannedRemindsView
          case .plannedReminds(let plannedReminds):
            plannedRemindsView(plannedReminds: plannedReminds)
          }
        }
        VStack(spacing: 12) {
          saveButtonView()
          cancelButtonView()
          deleteButtonView()
        }
      }
      .padding(.horizontal, 24)
      .padding(.vertical, 32)
      .frame(maxWidth: 640)
      .frame(maxWidth: .infinity)
    }
  }
  
  @ViewBuilder
  private var noRemindPermissionView: some View {
    Text("You have not allowed to send notifications yet.")
    Button {
      
    } label: {
      Text("Allow notifications")
    }
  }
  
  private var noPlannedRemindsView: some View {
    Text("There are no planned reminds yet.")
  }
  
  private func plannedRemindsView(plannedReminds: [EventEntity.PlannedRemind]) -> some View {
    Text("Planned Reminds")
  }
  
  private var sectionDivider: some View {
    Divider()
      .padding(.horizontal, -8)
  }

  private var titleSubSectionView: some View {
    EventSubSectionView(title: "Title") {
      EventTextFieldView(placeholder: "Title", text: $eventData.title)
    }
  }
  
  private var commentSubSectionView: some View {
    EventSubSectionView(title: "Comment") {
      EventTextFieldView(placeholder: "Comment", text: $eventData.comment)
    }
  }
  
  private var dateSubSectionView: some View {
    EventSubSectionView(title: "Date") {
      EventDateView(eventDate: $eventData.date)
        .padding(.horizontal, 4)
    }
  }
  
  private var repeatSubSectionView: some View {
    EventSubSectionView(title: "Repeat every") {
      switch store.repeatRepresentationEnum {
      case .picker(let values, let titles):
        Picker("Repeat every", selection: $eventData.remindRepeat) {
          ForEach(values, id: \.self) { option in
            Text(titles[option] ?? "")
              .tag(option)
          }
        }
        .pickerStyle(.segmented)
      case .text(let text):
        Text(text)
          .font(.body.weight(.medium))
          .padding(.horizontal, 14)
          .padding(.vertical, 12)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(fieldBackground)
      }
    }
  }

  @ViewBuilder
  private func remindTimeView() -> some View {
    VStack(alignment: .leading, spacing: 12) {
      remindTimeRow(
        title: "Remind time 1",
        selection: $eventData.remindTimeDate1
      )
      if store.isRemindTime2ViewVisible {
        remindTimeRow(
          title: "Remind time 2",
          selection: bindingForOptionalDate($eventData.remindTimeDate2),
          removeAction: interactor.removeRemindTimeDate2ButtonTapped
        )
      }
      if store.isRemindTime3ViewVisible {
        remindTimeRow(
          title: "Remind time 3",
          selection: bindingForOptionalDate($eventData.remindTimeDate3),
          removeAction: interactor.removeRemindTimeDate3ButtonTapped
        )
      }
      if store.isAddRemindTimeButtonVisible {
        Button(action: interactor.addRemindTimeButtonTapped) {
          Label("Add remind time", systemImage: "plus.circle.fill")
            .font(.body.weight(.semibold))
        }
        .buttonStyle(.borderedProminent)
        .tint(ReminderColor.Accent.primary)
      }
    }
  }

  private func saveButtonView() -> some View {
    Button(action: {
      interactor.saveButtonTapped()
    }) {
      HStack(spacing: 10) {
        if store.isSaving {
          ProgressView()
            .tint(ReminderColor.Text.inverse)
          Text(store.saveButtonTitle)
        } else {
          Image(systemName: "checkmark.circle.fill")
          Text(store.saveButtonTitle)
        }
      }
      .font(.headline)
      .frame(maxWidth: .infinity, minHeight: 50)
      .padding(.horizontal, 4)
      .background(
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(
            LinearGradient(
              colors: [ReminderColor.Accent.gradientStart, ReminderColor.Accent.gradientStrong],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
          )
      )
      .foregroundStyle(ReminderColor.Text.inverse)
      .shadow(color: ReminderColor.Accent.shadowSoft, radius: 10, x: 0, y: 6)
    }
    .disabled(store.isSaving || store.isDeleting)
  }

  private func cancelButtonView() -> some View {
    Button(action: {
      interactor.cancelButtonTapped()
    }) {
      Text(store.cancelButtonTitle)
        .font(.headline)
        .frame(maxWidth: .infinity, minHeight: 50)
        .padding(.horizontal, 4)
        .background(
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(.ultraThinMaterial)
        )
        .overlay(
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .stroke(ReminderColor.Text.secondary.opacity(0.2), lineWidth: 1)
        )
    }
    .disabled(store.isSaving || store.isDeleting)
  }

  @ViewBuilder
  private func deleteButtonView() -> some View {
    if store.isDeleteButtonVisible {
      Button(action: {
        interactor.deleteButtonTapped()
      }) {
        HStack(spacing: 10) {
          if store.isDeleting {
            ProgressView()
              .tint(ReminderColor.Text.inverse)
            Text(store.deleteButtonTitle)
          } else {
            Image(systemName: "trash.fill")
            Text(store.deleteButtonTitle)
          }
        }
        .font(.headline)
        .frame(maxWidth: .infinity, minHeight: 50)
        .padding(.horizontal, 4)
        .background(
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(
              LinearGradient(
                colors: [ReminderColor.Danger.gradientStart, ReminderColor.Danger.gradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              )
            )
        )
        .foregroundStyle(ReminderColor.Text.inverse)
        .shadow(color: ReminderColor.Danger.shadow, radius: 10, x: 0, y: 6)
      }
      .disabled(store.isSaving || store.isDeleting)
    }
  }

  @ViewBuilder
  private func remindTimeRow(
    title: String,
    selection: Binding<Date>,
    removeAction: (() -> Void)? = nil
  ) -> some View {
    HStack(spacing: 12) {
      VStack(alignment: .leading, spacing: 6) {
        Text(title)
          .font(.subheadline.weight(.semibold))
          .foregroundStyle(.secondary)
        DatePicker(
          "",
          selection: selection,
          displayedComponents: .hourAndMinute
        )
        .labelsHidden()
        .datePickerStyle(.compact)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      if let removeAction {
        Button(action: removeAction) {
          Image(systemName: "minus.circle.fill")
            .font(.title2)
            .foregroundStyle(ReminderColor.Danger.primary)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Remove \(title)")
      }
    }
    .padding(.horizontal, 14)
    .padding(.vertical, 12)
    .background(fieldBackground)
    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
  }

  private func bindingForOptionalDate(_ optionalDate: Binding<Date?>) -> Binding<Date> {
    Binding(
      get: { optionalDate.wrappedValue ?? store.defaultRemindTimeDate },
      set: { optionalDate.wrappedValue = $0 }
    )
  }

  private var fieldBackground: some View {
    RoundedRectangle(cornerRadius: 14, style: .continuous)
      .fill(ReminderColor.Background.primary.opacity(0.9))
      .shadow(color: ReminderColor.Shadow.extraLight, radius: 6, x: 0, y: 3)
  }
}
