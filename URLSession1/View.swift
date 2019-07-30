//
//  View.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 26/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import UIKit

class View {
    static func loadingView(show: Bool, showLoading: Bool? = false, view: UIView) {
        DispatchQueue.main.async {
            if show {
                let loadingView = UIView(frame: CGRect(origin: .zero, size: view.frame.size))
                loadingView.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
                loadingView.tag = 99098
                view.addSubview(loadingView)
                
                if showLoading! {
                    let activityView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
                    activityView.center = view.center
                    activityView.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
                    activityView.layer.cornerRadius = 10
                    activityView.clipsToBounds = true
                    
                    let activityIndicator = UIActivityIndicatorView()
                    activityIndicator.center = CGPoint(x: activityView.frame.size.width/2, y: activityView.frame.size.height/2)
                    activityIndicator.hidesWhenStopped = true
                    activityIndicator.startAnimating()
                    activityIndicator.style = .whiteLarge
                    //                    activityIndicator.color = UIColor(white: 0.5, alpha: 1.0)
                    
                    loadingView.addSubview(activityView)
                    activityView.addSubview(activityIndicator)
                }
            } else {
                for subview in view.subviews {
                    if subview.tag == 99098 {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    // Alerta booleano - Sim/Não
    static func showBoolAlert(title: String, message: String?, viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: {_ in completion(true)}))
            alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: {_ in completion(false)}))
            
            viewController.present(alert, animated: true)
        }
    }
    
    // Alerta erro
    static func showOkAlert(title: String, message: String?, viewController: UIViewController, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in completion()}))
            
            viewController.present(alert, animated: true)
        }
    }
    
    // Alerta com text field
    static func showInputAlert(title: String, message: String?, placeholder: String?, viewController: UIViewController, completion: @escaping (String) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = placeholder
                textField.returnKeyType = .done
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                guard let text = alert.textFields?.first?.text, text != "" else {
                    showOkAlert(title: "Campo de texto não pode ser vazio.", message: nil, viewController: viewController, completion: {})
                    return
                }
                completion(text.uppercased())
            }))
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            
            viewController.present(alert, animated: true)
        }
    }
}
