//
//  TrafficPresenter.swift
//  TrafficLight
//
//  Created by Артем Галиев on 23.10.2020.
//

import Foundation

//Протокол выхода
protocol TraficLightViewProtocol {
    func lightRedIsNow()
    func lightYellowIsNow(trafficColor: TraficColor)
    func lightGreenIsNow()
}

//Протокол входа
protocol TraficLightPresenterProtocol {
    init(view: TraficLightViewProtocol, traficColor: TraficColor)
    func startTrafficLights()
}

class TraficLightPresenter: TraficLightPresenterProtocol {
    
    public var mainView: TraficLightViewProtocol
    public var traficColor: TraficColor
    
    private var mainTimer = Timer()
    private var redAndGreenTimeInterval: TimeInterval = 5
    private var yellowTimeInterval: TimeInterval = 1
    
    required init(view: TraficLightViewProtocol, traficColor: TraficColor) {
        self.mainView = view
        self.traficColor = traficColor
    }
    
    //Главный метод
    public func startTrafficLights() {
        startTimer(currentTimeInterval: redAndGreenTimeInterval)
    }
    
    //Переключатель светофора
    @objc func actionTimer() {
        switch traficColor {
        case .red:
            mainView.lightRedIsNow()
            traficColor = .yellowPastRed
            startTimer(currentTimeInterval: redAndGreenTimeInterval)
        case .yellowPastRed:
            mainView.lightYellowIsNow(trafficColor: traficColor)
            traficColor = .green
            startTimer(currentTimeInterval: yellowTimeInterval)
        case .green:
            startTimer(currentTimeInterval: redAndGreenTimeInterval)
            mainView.lightGreenIsNow()
            traficColor = .yellowPastGreen
        case .yellowPastGreen:
            startTimer(currentTimeInterval: yellowTimeInterval)
            mainView.lightYellowIsNow(trafficColor: traficColor)
            traficColor = .red
        }
    }
    
    //Таймер светофора
    private func startTimer(currentTimeInterval: TimeInterval) {
        mainTimer.invalidate()
        mainTimer = Timer.scheduledTimer(timeInterval: currentTimeInterval, target: self, selector: #selector(actionTimer), userInfo: nil, repeats: true)
    }
}
