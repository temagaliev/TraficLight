//
//  ViewController.swift
//  TrafficLight
//
//  Created by Артем Галиев on 23.10.2020.
//

import UIKit

class TrafficViewController: UIViewController {
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    var presenter: TraficLightPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startVisualSettings()
    }
    
    //Кнопка запуска
    @IBAction func startTrafficLights(_ sender: UIButton) {
        presenter.startTrafficLights()  
    }
    
    //Стартовые настройки элементов
    private func startVisualSettings() {
        redView.layer.cornerRadius = redView.frame.width / 2
        redView.backgroundColor = .red
        yellowView.layer.cornerRadius = yellowView.frame.width / 2
        yellowView.backgroundColor = .yellow
        greenView.layer.cornerRadius = greenView.frame.width / 2
        greenView.backgroundColor = .green
        startButton.layer.cornerRadius = 5
        mainView.layer.cornerRadius = 30
    }
}

//Расширение для TraficLightViewProtocol, работа UI
extension TrafficViewController: TraficLightViewProtocol {
    
    //Включение красного света
    func lightRedIsNow() {
        redView.backgroundColor = .red
        yellowView.backgroundColor = .gray
        greenView.backgroundColor = .gray
    }
    
    //Включение желтого света
    func lightYellowIsNow(trafficColor: TraficColor) {
        if trafficColor == .yellowPastRed {
            redView.backgroundColor = .red
        } else {
            redView.backgroundColor = .gray
        }
        yellowView.backgroundColor = .yellow
        greenView.backgroundColor = .gray
    }
    
    //Включение зеленого света
    func lightGreenIsNow() {
        redView.backgroundColor = .gray
        yellowView.backgroundColor = .gray
        greenView.backgroundColor = .green
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(shimmerTrafficLight), userInfo: nil, repeats: false)
    }
    
    //Анимация мигания
    @objc func shimmerTrafficLight() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseIn]) {
            self.shimmerGreenColor()
        } completion: { (finish) in
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseIn]) {
                self.shimmerClearColor()
            } completion: { (finish) in
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseIn]) {
                    self.shimmerGreenColor()
                } completion: { (finish) in
                    UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseIn]) {
                        self.shimmerClearColor()
                    } completion: { (finish) in
                        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseIn]) {
                            self.shimmerGreenColor()
                        } completion: { (finish) in
                        }
                    }
                }
            }
        }
    }
    
    //Методы мигания
    private func shimmerClearColor() {
        self.redView.backgroundColor = .gray
        self.yellowView.backgroundColor = .gray
        self.greenView.backgroundColor = .gray
    }
    
    private func shimmerGreenColor() {
        self.redView.backgroundColor = .gray
        self.yellowView.backgroundColor = .gray
        self.greenView.backgroundColor = .green
    }
    
    
}


