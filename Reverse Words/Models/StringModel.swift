//
//  StringModel.swift
//  Reverse Words
//
//  Created by Dmytro Ivanchuk on 23.07.2022.
//

import Foundation

struct StringModel {
    func reverseWords(in string: String?, ignoring text: String? = nil) -> String {
        var result = ""
        
        if let str = string {
            
            let charactersArray = str.compactMap { $0 }
            let ignoredCharactersArray = text?.compactMap { $0 }
            var ignoredCharactersCounter = 0
            
            let reversedCharactersArray = str
                .components(separatedBy: " ")
                .map { $0.reversed() }
                .joined(separator: " ")
                .filter { text == nil ? $0.isLetter : !ignoredCharactersArray!.contains($0) }
                .compactMap { $0 }
            
            for index in charactersArray.indices {
                if text == nil ? !charactersArray[index].isLetter : ignoredCharactersArray!.contains(charactersArray[index]) {
                    result += String(charactersArray[index])
                    ignoredCharactersCounter += 1
                } else {
                    result += String(reversedCharactersArray[index - ignoredCharactersCounter])
                }
            }
        }
        return result
    }
}
