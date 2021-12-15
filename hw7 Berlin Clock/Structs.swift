//
//  structs.swift
//  hw7 Berlin Clock
//
//  Created by Leyla Nyssanbayeva on 14.12.2021.
//

import Foundation
import SwiftUI

struct FiveMinuteLamp: View{
    @Binding var isOn: Bool
    var isRed: Bool
    
    var body: some View{
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(self.setColor())
            .frame(width: 21, height: 32)
            .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 6)
    }
    
    private func setColor() -> Color{
        switch isRed{
        case true:
            return isOn ? Colors.red : Colors.lightRed
        default:
            return isOn ? Colors.yellow : Colors.lightYellow
        }
    }
}

struct OneMinuteLamp: View{
    @Binding var isOn: Bool
    
    var body: some View{
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(isOn ? Colors.yellow : Colors.lightYellow)
            .frame(width: 74, height: 32)
            .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 6)
    }
}

struct HourLamp: View{
    @Binding var isOn: Bool
    var body: some View{
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(isOn ? Colors.red : Colors.lightRed)
            .frame(width: 74, height: 32)
            .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 6)
    }
}
