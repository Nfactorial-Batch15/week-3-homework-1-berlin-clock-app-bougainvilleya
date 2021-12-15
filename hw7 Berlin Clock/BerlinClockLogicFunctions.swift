//
//  BerlinClockLogic.swift
//  hw7 Berlin Clock
//
//  Created by Leyla Nyssanbayeva on 14.12.2021.
//

import Foundation

func convertSeconds(seconds: Int, clockArr: inout [Bool]) {
    clockArr[0] = (seconds % 2 == 0 ? true : false)
}
