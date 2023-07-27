//
//  Array+SplitByIndex.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 28.06.2023.
//

import Foundation

extension Array {

    func splitArray(step: Int) -> [[Element]] {
        var result: [[Element]] = []
        var startIndex = 0
        var endIndex = step - 1

        while endIndex < self.count && startIndex <= endIndex {
            let slice = Array(self[startIndex...endIndex])

            result.append(slice)
            startIndex += step

            if endIndex > self.count - step {
                endIndex = self.count - 1
            } else {
                endIndex += step
            }
        }

        return result
    }
    
    func splitArray(step: Int, firstStep: Int) -> [[Element]] {
        var result: [[Element]] = []
        var startIndex = 0
        var endIndex = firstStep - 1

        while endIndex < self.count && startIndex <= endIndex {
            let slice = Array(self[startIndex...endIndex])

            result.append(slice)
            
            if startIndex == 0 {
                startIndex += firstStep
            } else {
                startIndex += step
            }

            if endIndex > self.count - step {
                endIndex = self.count - 1
            } else {
                endIndex += step
            }
        }

        return result
    }
}
