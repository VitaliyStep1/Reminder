//
//  ClosestScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

public struct ClosestScreenView: View {
  @StateObject var viewModel: ClosestViewModel
  
  public init(viewModel: ClosestViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    NavigationStack {
      ZStack {
        if let noEventsText = viewModel.noEventsText {
          VStack {
            Text(noEventsText)
              .multilineTextAlignment(.center)
            Button {
              viewModel.createEventClicked()
            } label: {
              Text("Create Event")
            }
          }
        }
      }
      .navigationTitle("Closest events")
    }
  }
}
