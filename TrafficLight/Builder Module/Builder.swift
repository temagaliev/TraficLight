//
//  BuilderModule.swift
//  TrafficLight
//
//  Created by Артем Галиев on 23.10.2020.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = TrafficViewController()
        let traficColor: TraficColor = .red
        let presenter = TraficLightPresenter(view: view, traficColor: traficColor)
        view.presenter = presenter
        return view
    }
    
    
}
