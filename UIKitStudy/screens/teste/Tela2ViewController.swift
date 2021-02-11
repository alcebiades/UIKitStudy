//
//  Tela2ViewController.swift
//  UIKitStudy
//
//  Created by Alcebiades Santana on 14/01/21.
//

import UIKit

class Tela2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(super.nibName as Any)
    }
    
    init() {
        super.init(nibName: "Tela2ViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func voltar(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
