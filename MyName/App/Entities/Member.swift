//
//  Member.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

struct Member: Codable {
  var id: Int?
  var name: String?
  var email: String?
  var occupation: String?
  var imageURL: String?

  enum CodingKeys: String, CodingKey {
    case id = "memberId"
    case name = "name"
    case email = "email"
    case occupation = "occupation"
    case imageURL = "image"
  }
}
