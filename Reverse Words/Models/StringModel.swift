//
//  StringModel.swift
//  Reverse Words
//
//  Created by Dmytro Ivanchuk on 23.07.2022.
//

import Foundation

struct StringModel {
    func reverseWords(in string: String?) -> String {
        if let str = string {
            let result = str.components(separatedBy: " ").map { $0.reversed() }.joined(separator: " ")
            return String(result)
        } else {
            return ""
        }
    }
}
