//
//  TesteViewController.swift
//  UIKitStudy
//
//  Created by Alcebiades Santana on 14/01/21.
//

import UIKit

class TesteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: "TesteViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func voltar(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
