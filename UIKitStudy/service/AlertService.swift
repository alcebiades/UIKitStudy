//
//  AlertService.swift
//  UIKitStudy
//
//  Created by Alcebiades Santana on 08/02/21.
//

import UIKit

class AlertService {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func showMessage(title: String = "Atenção", message: String, action: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnCancel = UIAlertAction(title: "Fechar", style: .cancel, handler: action)
        alert.addAction(btnCancel)
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showConfirm(title: String = "Atenção", message: String, actionButtonNo: ((UIAlertAction) -> Void)? = nil, actionButtonYes: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let btnNo = UIAlertAction(title: "Não", style: .cancel, handler: actionButtonNo)
        let btnYes = UIAlertAction(title: "Sim", style: .destructive, handler: actionButtonYes)
        
        alert.addAction(btnNo)
        alert.addAction(btnYes)
        
        controller.present(alert, animated: true, completion: nil)
    }
}
