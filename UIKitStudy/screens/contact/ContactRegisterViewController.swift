//
//  ContactRegisterViewController.swift
//  UIKitStudy
//
//  Created by Alcebiades Santana on 31/01/21.
//

import UIKit

class ContactRegisterViewController: UIViewController {
    
    //MARK: - Variaveis da classe
    // Obs: Atributos declarados com "var" não precisam ser inicializadas desde que ela receba o "optional" (?) na declaração, se ele for declarado como "let" obrigatoriamente ele precisa ser inicializada no construtor "init".
    var contactListTableViewController: ContactListTableViewController?
    let errorColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    let normalTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    // MARK: - Bindings dos fields
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    // MARK: - Bindings das labels
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    // MARK: - Bindings dos botoes
    @IBOutlet weak var btnDelete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contactFromList = contactListTableViewController?.contactSelected {
            txtName.text = contactFromList.name
            txtAddress.text = contactFromList.address
            txtPhone.text = contactFromList.phone
        } else {
            btnDelete.isEnabled = false
        }
    }
    
    // MARK: - Bindings dos botoes
    @IBAction func save(_ sender: Any) {
        
        guard let name = txtName.text else {
            return
        }
        
        guard let address = txtAddress.text else {
            return
        }
        
        guard let phone = txtPhone.text else {
            return
        }
    
        let contact = Contact(name: name, address: address, phone: phone)
        contact.id = contactListTableViewController?.contactSelected?.id ?? -1
        
        if validateMandatoryFields(contact) {
            contactListTableViewController?.add(contact: contact)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func deleteContact(_ sender: Any) {
        if let contact = contactListTableViewController?.contactSelected {
            AlertService(controller: self).showConfirm(
                message: "Deseja excluir o contato?",
                actionButtonYes: {
                    (alertAction) in
                        self.contactListTableViewController?.deleteContact(contact: contact)
                        self.navigationController?.popViewController(animated: true)
                }
            )
        }
    }
    
    // MARK: - Funcoes
    fileprivate func validateMandatoryFields(_ contact: Contact) -> Bool{
        
        var isFormValid = true
        
        if contact.name.isEmpty {
            print("O campo Nome é obrigatório")
            lblName.textColor = errorColor
            isFormValid = false
        } else {
            lblName.textColor = normalTextColor
        }
        
        if contact.address.isEmpty {
            print("O campo Endereço é obrigatório")
            lblAddress.textColor = errorColor
            isFormValid = false
        } else {
            lblAddress.textColor = normalTextColor
        }
        
        if contact.phone.isEmpty {
            print("O campo Telefone é obrigatório")
            lblPhone.textColor = errorColor
            isFormValid = false
        } else {
            lblPhone.textColor = normalTextColor
        }
    
        return isFormValid
    }
}
 
