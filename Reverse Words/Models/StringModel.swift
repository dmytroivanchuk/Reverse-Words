//
//  StringModel.swift
//  Reverse Words
//
//  Created by Dmytro Ivanchuk on 23.07.2022.
//

import Foundation

struct StringModel {
    func reverseWords(in string: String?) -> String {
        var result = ""
        if let str = string {
            result = String(str.components(separatedBy: " ").map { $0.reversed() }.joined(separator: " "))
        }
        return result
    }
}
