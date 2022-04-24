//
//  MailViewController.swift
//  SaidSo
//
//  Created by Michael Tran on 23/4/2022.
//

import UIKit
import MessageUI
import ContactsUI

class MailViewController: UITableViewController {
    
    @IBAction func contactPickbtnClicked(_ sender: Any) {
        pickContacts();
    }
    @IBAction func sendBtnClick(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            MailCore.prepareMailList();
            showMailComposer();
        } else {
            self.showAlert(title: "Device Error", message: "Email has not been setup. Abort!");
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add two buttons on right side
        let sendBtn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sendTapped))
        let pickBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pickTapped))
        navigationItem.rightBarButtonItems = [sendBtn, pickBtn];
       
        guard MFMailComposeViewController.canSendMail() else {
            //show alert
            DispatchQueue.main.async {
                self.showAlert(title: "Device Error", message: "Email has not been setup.")
            }
            return
        }
    }
    @objc func sendTapped () {
        if MFMailComposeViewController.canSendMail() {
            MailCore.prepareMailList();
            showMailComposer();
        } else {
            self.showAlert(title: "Device Error", message: "Email has not been setup. Abort!");
        }
    }
    @objc func pickTapped () {
        pickContacts();
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emailList.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mailList", for: indexPath)
        
        cell.textLabel?.text = emailList[indexPath.row].name;
        
        return cell
    }
    
}

// MARK: Extensions
extension MailViewController:CNContactPickerDelegate{
    func pickContacts() {
        let peoplePicker = CNContactPickerViewController();
        peoplePicker.delegate = self;
        self.present(peoplePicker, animated: true, completion: nil);
    }
    
    func contactPickerDidCancel(picker: CNContactPickerViewController) {
        
        picker.dismiss(animated: true, completion: nil);
        MailCore.prepareMailList();
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {

               //Dismiss the picker VC
               picker.dismiss(animated: true, completion: nil)

        if contacts.count > 0 {
            emailList = emaiListDummy; // reset email list
            for item in contacts {
                let aName = item.givenName + " " + item.familyName;
                let anEmail = item.emailAddresses;
                if anEmail.count > 0 {
                let aContact = contact(name: aName, email: anEmail[0].value as String);
                emailList.append(aContact);
             }
            }
        }
        DispatchQueue.main.async { self.tableView.reloadData() };
    }
}

extension MailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            controller.dismiss(animated: true)
        }
        switch result {
        case .cancelled:
            print("cancelled email")
        case .failed:
            print("failed to send email")
        case .saved:
            print("saved email")
        case .sent:
            print("email sent!")
        default:
            print("default ")
            controller.dismiss(animated: true)
        }
        controller.dismiss(animated: true)
    }
    
    private func showMailComposer() {
        
        let composer = MFMailComposeViewController();
        composer.mailComposeDelegate = self;
        composer.setToRecipients(theList);
        composer.setSubject(quoteTitle);
        composer.setMessageBody("'" + quoteLine + "'" + " - " + quoteAuthor, isHTML: false)
        present(composer, animated: true)
    }
}

extension MailViewController {
    
    public func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    
}
