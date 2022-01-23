//
//  DataCheckerViewModel.swift
//  dataChecker
//
//  Created by NasirHasanovic on 21. 1. 2022..
//

import Foundation
import UIKit

class DataCheckerViewModel{
    var dataExpression : Box<String> = Box("")
    var expression : DataSet = DataSet(type: "apple", color: "red", weight: "100")
    var matchedExpressions: Box<[String]> = Box([])
    
    func updateExpression(expression: String){
        dataExpression.value = expression
    }
}

extension DataCheckerViewModel{
    func compareExpressions(){
        matchedExpressions.value.removeAll()
        let regexPattern = ["type(\\s+)=(\\s+)(?<type>\\w+)", "color(\\s+)=(\\s+)(?<color>\\w+)", "weight(\\s+)=(\\s+)(?<weight>\\d+)"]
        
        for pattern in regexPattern {
            extractMatchingTypes(expres: dataExpression.value, regex: pattern)
        }
        print(matchedExpressions.value)
    }

    func extractMatchingTypes(expres: String, regex: String) {
        let regex = try? NSRegularExpression(pattern: regex, options: .caseInsensitive)
        if let matches = regex?.matches(in: expres, options: [], range: NSRange(location: 0, length: expres.utf16.count)) {
            for match in matches {
                
                if let typeRange = Range(match.range(withName: "type"), in: expres) {
                    let type = String(expres[typeRange])
                    if type == expression.type {
                        matchedExpressions.value.append(type)
                    }else {
                        print("this type is not the same")
                    }
                }
                
                if let colorRange = Range(match.range(withName: "color"), in: expres) {
                    let color = String(expres[colorRange])
                    if color == expression.color {
                        matchedExpressions.value.append(color)
                        print(color)
                    }else {
                        print("color is not the same")
                    }
                }
                
                if let weightRange = Range(match.range(withName: "weight"), in: expres) {
                    let weight = String(expres[weightRange])
                    if weight == expression.weight {
                        matchedExpressions.value.append(weight)
                        print(weight)
                    }else {
                        print("weight is not the same")
                    }
                }
            }
        }
    }
    
    // we could use matches method which is combination of regex
    // using  let regexPattern2 = ["type(\\s+)=(\\s+)" + "\(expression.type)", "color(\\s+)=(\\s+)\(expression.color)", "weight(\\s+)=(\\s+)\(expression.weight)"]
    
    func matches(for regex: String, in text: String) -> [String] {
        
        let range = NSRange(location: 0, length: dataExpression.value.utf16.count)
        let regexOptions: NSRegularExpression.Options = [.caseInsensitive, .useUnicodeWordBoundaries, ]
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: regexOptions)
            let results = regex.matches(in: text, options: [], range: range)
            
            return results.compactMap {
                return  Range($0.range, in: text).map { String(text[$0])}
            }
        } catch {
            print("invalid regex")
            return []
        }
    }
    
    // MARK: -Begginers method for checking
    func findMatchEasyWay() {
        let arrayOfData = [expression.type, expression.color, expression.weight]
        let pattern = ["type = " + "\(expression.type)", "color = \(expression.color)", "weight = \(expression.weight)"]
        
        for  data in arrayOfData{
            for pattern in pattern {
                if dataExpression.value.contains(pattern){
                    print(data)
                    break
                }
            }
        }
    }
}
