//
//  EventScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import SwiftUI
import ReminderDesignSystem

public struct EventScreenView: View {
  @ObservedObject private var store: EventViewStore
  private let interactor: EventInteractor
  @Environment(\.locale) private var locale
  
  public init(store: EventViewStore, interactor: EventInteractor) {
    self.store = store
    self.interactor = interactor
  }
  
  public var body: some View {
    contentView
      .padding(.top, Styles.Padding.ScreenPadding.top)
      .padding(.bottom, Styles.Padding.ScreenPadding.bottom)
//      .dsScreenPadding()
      .dsScreenBackground()
      .disabled(store.isViewBlocked)
      .dsErrorAlert(
        isPresented: $store.isAlertVisible,
        message: store.alertInfo.message,
        completion: store.alertInfo.completion
      )
      .dsDeleteConfirmationDialog(
        isPresented: $store.isConfirmationDialogVisible,
        title: store.confirmationDialogInfo.title,
        deleteAction: store.confirmationDialogInfo.deleteButtonHandler,
        message: store.confirmationDialogInfo.message
      )
      .onAppear {
        interactor.updateLocale(locale)
        interactor.onAppear()
      }
      .onChange(of: locale) { newLocale in
        interactor.updateLocale(newLocale)
      }
  }
  
  //MARK: - Views

  var contentView: some View {
    ScrollView(showsIndicators: false) {
      LazyVStack(spacing: DSSpacing.s24) {
        EventScreenTitleView(screenTitleData: store.screenTitleData)
        EventDetailsSectionView(detailsSectionData: store.detailsSectionData)
        EventAlertsSectionView(alertsSectionData: store.alertsSectionData, interactor: interactor)
        EventPlannedSectionView(plannedSectionData: store.plannedSectionData)
        EventButtonsView(buttonsData: store.buttonsData, interactor: interactor)
      }
      .padding(.horizontal, Styles.Padding.ScreenPadding.horizontal)
      
      //      .frame(maxWidth: 640)
      //      .frame(maxWidth: .infinity)
    }
  }
}
