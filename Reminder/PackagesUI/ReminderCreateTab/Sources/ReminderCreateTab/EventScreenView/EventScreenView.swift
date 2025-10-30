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
  let interactor: EventInteractor

  public init(store: EventViewStore, interactor: EventInteractor) {
    _store = ObservedObject(wrappedValue: store)
    self.interactor = interactor
  }
  
  public var body: some View {
    ZStack {
      BackgroundSharedView()
      contentView
    }
    .disabled(store.isViewBlocked)
    .alert(store.alertInfo.title, isPresented: $store.isAlertVisible) {
      Button(store.alertInfo.buttonTitle, role: .cancel) {
        store.alertInfo.completion?()
      }
    } message: {
      Text(store.alertInfo.message)
    }
    .confirmationDialog(store.confirmationDialogInfo.title, isPresented: $store.isConfirmationDialogVisible, titleVisibility: .visible) {
      Button(store.confirmationDialogInfo.deleteButtonTitle, role: .destructive) {
        store.confirmationDialogInfo.deleteButtonHandler?()
      }
      Button(store.confirmationDialogInfo.cancelButtonTitle, role: .cancel) { }
    } message: {
      Text(store.confirmationDialogInfo.message)
    }
    .onAppear {
      interactor.onAppear()
    }
  }
  
  //MARK: - Views
  
  var contentView: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 24) {
        viewTitleView
        sectionContainer(title: "Event details", systemImage: "square.and.pencil") {
          eventTitleView
          Divider()
            .padding(.horizontal, -8)
          eventCommentView
          Divider()
            .padding(.horizontal, -8)
          eventDateView
        }
        sectionContainer(title: "Alerts", systemImage: "bell.badge") {
          remindRepeatView
          Divider()
            .padding(.horizontal, -8)
          remindTimeView()
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
  
  private var viewTitleView: some View {
      Label {
        Text(store.viewTitle)
          .font(.largeTitle.bold())
      } icon: {
        Image(systemName: "calendar.badge.plus")
          .font(.title3.weight(.semibold))
          .foregroundStyle(.white)
          .padding(12)
          .background(
            Circle()
              .fill(
                LinearGradient(
                  colors: [Color.accentColor, Color.accentColor.opacity(0.7)],
                  startPoint: .topLeading,
                  endPoint: .bottomTrailing
                )
              )
          )
          .shadow(color: Color.accentColor.opacity(0.3), radius: 10, x: 0, y: 6)
      }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  @ViewBuilder
  private var eventTitleView: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("Title")
        .font(.subheadline.weight(.semibold))
        .foregroundStyle(.secondary)
      TextField("Title", text: $store.eventTitle)
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(fieldBackground)
        .overlay(
          RoundedRectangle(cornerRadius: 14, style: .continuous)
            .stroke(Color.accentColor.opacity(store.eventTitle.isEmpty ? 0 : 0.4), lineWidth: 1)
        )
    }
  }

  private var eventDateView: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("Date")
        .font(.subheadline.weight(.semibold))
        .foregroundStyle(.secondary)
      EventDateView(eventDate: $store.eventDate)
        .padding(.horizontal, 4)
    }
  }

  @ViewBuilder
  private var eventCommentView: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("Comment")
        .font(.subheadline.weight(.semibold))
        .foregroundStyle(.secondary)
      TextField("Comment", text: $store.eventComment)
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(fieldBackground)
        .overlay(
          RoundedRectangle(cornerRadius: 14, style: .continuous)
            .stroke(Color.accentColor.opacity(store.eventComment.isEmpty ? 0 : 0.4), lineWidth: 1)
        )
    }
  }

  @ViewBuilder
  private var remindRepeatView: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Repeat")
        .font(.subheadline.weight(.semibold))
        .foregroundStyle(.secondary)
      switch store.repeatRepresentationEnum {
      case .picker(let values, let titles):
        Picker("Repeat", selection: $store.eventRemindRepeat) {
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
        selection: $store.remindTimeDate1
      )
      if store.isRemindTime2ViewVisible {
        remindTimeRow(
          title: "Remind time 2",
          selection: bindingForOptionalDate($store.remindTimeDate2),
          removeAction: interactor.removeRemindTimeDate2ButtonTapped
        )
      }
      if store.isRemindTime3ViewVisible {
        remindTimeRow(
          title: "Remind time 3",
          selection: bindingForOptionalDate($store.remindTimeDate3),
          removeAction: interactor.removeRemindTimeDate3ButtonTapped
        )
      }
      if store.isAddRemindTimeButtonVisible {
        Button(action: interactor.addRemindTimeButtonTapped) {
          Label("Add remind time", systemImage: "plus.circle.fill")
            .font(.body.weight(.semibold))
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.accentColor)
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
            .tint(.white)
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
              colors: [Color.accentColor, Color.accentColor.opacity(0.8)],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
          )
      )
      .foregroundStyle(.white)
      .shadow(color: Color.accentColor.opacity(0.25), radius: 10, x: 0, y: 6)
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
            .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
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
              .tint(.white)
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
                colors: [Color.red, Color.red.opacity(0.85)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              )
            )
        )
        .foregroundStyle(.white)
        .shadow(color: Color.red.opacity(0.2), radius: 10, x: 0, y: 6)
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
            .foregroundStyle(.red)
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
      .fill(Color(.systemBackground).opacity(0.9))
      .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
  }

  private func sectionContainer<Content: View>(
    title: String,
    systemImage: String,
    @ViewBuilder content: () -> Content
  ) -> some View {
    VStack(alignment: .leading, spacing: 16) {
      Label(title, systemImage: systemImage)
        .font(.title3.weight(.semibold))
        .foregroundStyle(.primary)
      content()
    }
    .padding(20)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      RoundedRectangle(cornerRadius: 24, style: .continuous)
        .fill(.ultraThinMaterial)
    )
    .overlay(
      RoundedRectangle(cornerRadius: 24, style: .continuous)
        .stroke(Color.primary.opacity(0.08))
    )
    .shadow(color: Color.black.opacity(0.08), radius: 18, x: 0, y: 10)
  }
}

