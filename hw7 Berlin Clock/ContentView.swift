//
//  ContentView.swift
//  hw7 Berlin Clock
//
//  Created by Leyla Nyssanbayeva on 14.12.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var time = Date()
    @State var hours = 0
    @State var minutes = 0
    @State var seconds = 0
    @State var lampsArr = Array(repeating: false, count: 24)
    
    // таймер для секунд
    let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack{
            Colors.cream
                .ignoresSafeArea()
            
            VStack(spacing: 10){
                Text("Time is \(hours):\(minutes):\(seconds)")
                    .onReceive(timer, perform: { _ in
                        self.seconds += 1
                        checkTime()
                    })
                    .font(Font.system(size: 17, weight: .semibold))
                    .padding()
                
                ZStack{
                    // фоновый прямоугольник
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .frame(height: 312)
                        .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 6)
                    // лампы
                    VStack(spacing: 16){
                        secondsLamp
                        fiveHourLamps
                        oneHourLamps
                        fiveMinuteLamps
                        oneMinuteLamps
                    }
                }
                
                ZStack{
                    // второй прямоугольник
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .frame(height: 54)
                        .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 6)
                    
                    HStack{
                        Text("Insert time")
                        Spacer()
                        VStack {
                            TimePicker(time: $time).onChange(of: time) { _ in
                                getTime()
                                convertHours(hours: hours)
                                convertMinutes(minutes: minutes)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .onAppear {
            getTime()
        }
    }
    
    // чтобы минуты/секунды не были больше 60, а часы больше 24
    func checkTime(){
        if(self.seconds == 60){
            self.seconds = 0
            self.minutes += 1
        }
        if(self.minutes == 60){
            self.minutes = 0
            self.hours += 1
        }
        
        if(self.hours == 24){
            self.hours = 0
        }
    }
    
    // получить значения времени из тайм пикера
    func getTime(){
        lampsArr = Array(repeating: false, count: 24)
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: time)
        hours = components.hour ?? 0
        minutes = components.minute ?? 0
        seconds = components.second ?? 0
    }
    
    // конвертаторы в берлин клок
    func convertHours(hours: Int) {
        var lamps = 0
        if hours > 4{
            lamps = hours / 5
            for i in Range(1...lamps){
                lampsArr[i] = true
            }
        }
        lamps = hours % 5
        if lamps > 0{
            for i in Range(5...lamps + 4){
                lampsArr[i] = true
            }
        }
    }
    
    func convertMinutes(minutes: Int) {
        var lamps = 0
        if minutes > 4 {
            lamps = minutes / 5
            for i in Range(9...lamps + 8){
                lampsArr[i] = true
            }
        }
        lamps = minutes % 5
        if lamps > 0{
            for i in Range(20...lamps + 19){
                lampsArr[i] = true
            }
        }
    }

    var secondsLamp: some View{
        Circle()
            .frame(width: 56, height: 56)
            .foregroundColor((seconds % 2 == 0 ? Colors.yellow : Colors.lightYellow))
    }
    
    var fiveHourLamps: some View{
        HStack(spacing: 10){
            HourLamp(isOn: $lampsArr[1])
            HourLamp(isOn: $lampsArr[2])
            HourLamp(isOn: $lampsArr[3])
            HourLamp(isOn: $lampsArr[4])
        }
    }
    
    var oneHourLamps: some View{
        HStack(spacing: 10){
            HourLamp(isOn: $lampsArr[5])
            HourLamp(isOn: $lampsArr[6])
            HourLamp(isOn: $lampsArr[7])
            HourLamp(isOn: $lampsArr[8])
        }
    }
    
    
    var fiveMinuteLamps: some View{
        HStack(spacing: 9){
            FiveMinuteLamp(isOn: $lampsArr[9], isRed: false)
            FiveMinuteLamp(isOn: $lampsArr[10], isRed: false)
            FiveMinuteLamp(isOn: $lampsArr[11], isRed: true)
            FiveMinuteLamp(isOn: $lampsArr[12], isRed: false)
            FiveMinuteLamp(isOn: $lampsArr[13], isRed: false)
            FiveMinuteLamp(isOn: $lampsArr[14], isRed: true)
            FiveMinuteLamp(isOn: $lampsArr[15], isRed: false)
            FiveMinuteLamp(isOn: $lampsArr[16], isRed: false)
            FiveMinuteLamp(isOn: $lampsArr[17], isRed: true)
            Group{
                FiveMinuteLamp(isOn: $lampsArr[18], isRed: false)
                FiveMinuteLamp(isOn: $lampsArr[19], isRed: false)
            }
        }
        .padding(.horizontal)
    }
    
    var oneMinuteLamps: some View{
        HStack(spacing: 10){
            OneMinuteLamp(isOn: $lampsArr[20])
            OneMinuteLamp(isOn: $lampsArr[21])
            OneMinuteLamp(isOn: $lampsArr[22])
            OneMinuteLamp(isOn: $lampsArr[23])
        }
    }
}

struct TimePicker: View{
    @Binding var time: Date
    var body: some View{
            DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .environment(\.locale, Locale(identifier: "en_DK"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
