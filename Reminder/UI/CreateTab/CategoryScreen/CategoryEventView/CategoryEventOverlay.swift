//
//  CategoryEventOverlay.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.10.2025.
//

import SwiftUI

struct CategoryEventOverlay: View {
  @StateObject private var vm: CategoryEventViewModel
  
  init(dataService: DataServiceProtocol,
       type: CategoryEventViewType,
       onChanged: @escaping () -> Void,
       onClose: @escaping () -> Void) {
    _vm = StateObject(wrappedValue:
                        CategoryEventViewModel(
                          dataService: dataService,
                          type: type,
                          eventsWereChangedHandler: onChanged,
                          closeViewHandler: onClose
                        )
    )
  }
  
  var body: some View {
    CategoryEventView(viewModel: vm)   // child now uses @ObservedObject
  }
}
