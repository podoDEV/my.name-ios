//
//  Keyboard+Rx.swift
//  MyName
//
//  Created by hb1love on 05/05/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import RxCocoa
import RxSwift

func keyboardHeight() -> Observable<CGFloat> {
  return Observable
    .from(
      [NotificationCenter.default.rx.notification(UIResponder.keyboardWillChangeFrameNotification)
        .map { notification -> CGFloat in
          (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
        },
       NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
        .map { _ -> CGFloat in
          0
        }
      ]
    )
    .merge()
}
