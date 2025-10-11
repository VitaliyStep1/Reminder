//
//  AlertInfo.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.10.2025.
//

struct AlertInfo {
  var title: String = "Error"
  let message: String
  var buttonTitle: String = "OK"
  var completion: (() -> Void)?
}
