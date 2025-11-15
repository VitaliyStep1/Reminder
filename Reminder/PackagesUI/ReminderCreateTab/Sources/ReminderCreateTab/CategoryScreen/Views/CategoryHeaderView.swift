//
//  CategoryHeaderView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI

struct CategoryHeaderView: View {
  let title: String
  let subtitle: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.largeTitle.weight(.semibold))
        .foregroundStyle(.primary)
      
      Text(subtitle)
        .font(.callout)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
