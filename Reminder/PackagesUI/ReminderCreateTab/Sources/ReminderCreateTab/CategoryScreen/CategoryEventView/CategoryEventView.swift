//
//  CategoryEventView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import SwiftUI

public struct CategoryEventView: View {
  @ObservedObject var store: CategoryEventViewStore
  let interactor: CategoryEventInteractor

  public init(store: CategoryEventViewStore, interactor: CategoryEventInteractor) {
    self.store = store
    self.interactor = interactor
  }
  
  public var body: some View {
    ZStack {
      Color(.systemBackground)
        .ignoresSafeArea()
      ScrollView {
        VStack(spacing: 16) {
          Text(store.viewTitle)
            .font(.headline)
          
          VStack(alignment: .leading, spacing: 8) {
            Text("Title:")
            TextField("Title", text: $store.eventTitle)
              .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
              Spacer()
              DatePicker("", selection: $store.eventDate, displayedComponents: [.date])
                .datePickerStyle(.wheel)
                .labelsHidden()
              Spacer()
            }
            
            Text("Comment:")
            TextField("Comment", text: $store.eventComment)
              .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if !store.remindRepeatOptions.isEmpty {
              Text("Repeat:")
              Picker("Repeat", selection: $store.eventRemindRepeat) {
                ForEach(store.remindRepeatOptions, id: \.self) { option in
                  Text(store.remindRepeatTitles[option] ?? "")
                    .tag(option)
                }
              }
              .pickerStyle(.segmented)
            }
          }
          
          Button(action: {
            interactor.saveButtonTapped()
          }) {
            Group {
              if store.isSaving {
                ProgressView()
                  .tint(.white)
              } else {
                Text(store.saveButtonTitle)
              }
            }
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(Color.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
          }
          .disabled(store.isSaving || store.isDeleting)

          Button(action: {
            interactor.cancelButtonTapped()
          }) {
            Text(store.cancelButtonTitle)
              .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
              .background(Color.gray)
              .foregroundStyle(.white)
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
          .disabled(store.isSaving || store.isDeleting)

          if store.isDeleteButtonVisible {
            Button(action: {
              interactor.deleteButtonTapped()
            }) {
              Group {
                if store.isDeleting {
                  ProgressView()
                    .tint(.white)
                } else {
                  Text(store.deleteButtonTitle)
                }
              }
              .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
              .background(Color.red)
              .foregroundStyle(.white)
              .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(store.isSaving || store.isDeleting)
          }
        }
        .padding()
        .frame(maxWidth: 400)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 10)
      }
    }
    .disabled(store.isViewBlocked)
    .alert(store.alertInfo.title, isPresented: $store.isAlertVisible) {
      Button(store.alertInfo.buttonTitle, role: .cancel) {
        store.alertInfo.completion?()
      }
    } message: {
      Text(store.alertInfo.message)
    }
    .confirmationDialog(store.confirmationDialogInfo.title,
                        isPresented: $store.isConfirmationDialogVisible,
                        titleVisibility: .visible) {
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
}

