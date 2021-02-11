//
//  ViewController.swift
//  UIKitStudy
//
//  Created by Alcebiades Santana on 13/01/21.
//

import UIKit

class ContactListTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Atibutos da classe
    var listContact = [Contact]()
    var listContactTableView = [Contact]()
    let contactFileService = ContactFileService()
    var contactSelected: Contact?
        
    // MARK: - Outlets
    @IBOutlet weak var txtSearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.delegate = self
        loadContacts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contactSelected = nil
    }
    
    // Configura o click listener
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        contactSelected = listContact[indexPath.row]
        
        performSegue(withIdentifier: "ContactRegisterViewController", sender: self)
    }
    
    // Configura a quantidade de linhas que a tabela vai ter
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listContactTableView.count
    }
    
    // Monta a visualização do celula que será exibida na tabela
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = listContactTableView[indexPath.row].name
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(share(_:)))
        cell.addGestureRecognizer(gesture)
        
        return cell
    }

    @objc func share(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let tableViewCell = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: tableViewCell) else { return }

            let contact = listContact[indexPath.row]

            let activityViewController = UIActivityViewController(activityItems: [contact.name, contact.address, contact.phone], applicationActivities: nil)
            
            present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listContactTableView = listContact
        if !searchText.isEmpty {
            let filter = NSPredicate(format: "name contains %@", searchText)
            let contactsNSArray = listContactTableView as NSArray
            let contactsFiltered = contactsNSArray.filtered(using: filter) as! [Contact]
            listContactTableView = contactsFiltered
        }
        tableView.reloadData()
    }
    
    func add(contact: Contact) {
       
        if contact.id == -1 {
            listContact.append(contact)
        } else {
            listContact[contact.id] = contact
        }
        
        saveContactList(listContactToSave: listContact)
        loadContacts()
    }
    
    func deleteContact(contact: Contact) {
        listContact.remove(at: contact.id)
        saveContactList(listContactToSave: listContact)
        loadContacts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let contactRegisterViewController = segue.destination as? ContactRegisterViewController {
            contactRegisterViewController.contactListTableViewController = self
        }
    }
    
    fileprivate func saveContactList(listContactToSave: [Contact]) {
        contactFileService.saveContactList(listContactToSave: listContactToSave)
    }
    
    fileprivate func loadContacts() {
        listContact = contactFileService.loadContacts()
        listContactTableView = listContact
        tableView.reloadData()
    }
}

