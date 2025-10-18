//
//  CategoryEventView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import SwiftUI

public struct CategoryEventView: View {
  @ObservedObject var viewModel: CategoryEventViewModel
  
  public init(viewModel: CategoryEventViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack {
      Color(.systemBackground)
        .ignoresSafeArea()
      ScrollView {
        VStack(spacing: 16) {
          Text(viewModel.viewTitle)
            .font(.headline)
          
          VStack(alignment: .leading, spacing: 8) {
            Text("Title:")
            TextField("Title", text: $viewModel.title)
              .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
              Spacer()
              DatePicker("", selection: $viewModel.date, displayedComponents: [.date])
                .datePickerStyle(.wheel)
                .labelsHidden()
              Spacer()
            }
            
            Text("Comment:")
            TextField("Comment", text: $viewModel.comment)
              .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text("Repeat:")
            Picker("Repeat", selection: $viewModel.remindRepeat) {
              ForEach(viewModel.remindRepeatOptions, id: \.self) { option in
                Text(viewModel.remindRepeatTitle(for: option))
                  .tag(option)
              }
            }
            .pickerStyle(.segmented)
          }
          
          Button(action: {
            viewModel.saveButtonTapped()
          }) {
            Group {
              if viewModel.isSaving {
                ProgressView()
                  .tint(.white)
              } else {
                Text(viewModel.saveButtonTitle)
              }
            }
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(Color.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
          }
          .disabled(viewModel.isSaving || viewModel.isDeleting)
          
          Button(action: {
            viewModel.cancelButtonTapped()
          }) {
            Text(viewModel.cancelButtonTitle)
              .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
              .background(Color.gray)
              .foregroundStyle(.white)
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
          .disabled(viewModel.isSaving || viewModel.isDeleting)
          
          if viewModel.isDeleteButtonVisible {
            Button(action: {
              viewModel.deleteButtonTapped()
            }) {
              Group {
                if viewModel.isDeleting {
                  ProgressView()
                    .tint(.white)
                } else {
                  Text(viewModel.deleteButtonTitle)
                }
              }
              .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
              .background(Color.red)
              .foregroundStyle(.white)
              .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(viewModel.isSaving || viewModel.isDeleting)
          }
        }
        .padding()
        .frame(maxWidth: 400)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 10)
      }
    }
    .disabled(viewModel.isViewBlocked)
    .alert(viewModel.alertInfo.title, isPresented: $viewModel.isAlertVisible) {
      Button(viewModel.alertInfo.buttonTitle, role: .cancel) {
        viewModel.alertInfo.completion?()
      }
    } message: {
      Text(viewModel.alertInfo.message)
    }
    .confirmationDialog(viewModel.confirmationDialogInfo.title,
                        isPresented: $viewModel.isConfirmationDialogVisible,
                        titleVisibility: .visible) {
      Button(viewModel.confirmationDialogInfo.deleteButtonTitle, role: .destructive) {
        viewModel.confirmationDialogInfo.deleteButtonHandler?()
      }
      Button(viewModel.confirmationDialogInfo.cancelButtonTitle, role: .cancel) { }
    } message: {
      Text(viewModel.confirmationDialogInfo.message)
    }
  }
}

