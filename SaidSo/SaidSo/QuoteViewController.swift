//
//  ViewController.swift
//  SaidSo
//
//  Created by Michael Tran on 21/4/2022.
//

import UIKit

class QuoteViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBAction func sendEmalBtn(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard NetworkModel.isConnectedToNetwork() // check internet connection
        else {    //show alert
            DispatchQueue.main.async {
                self.showAlert(title: "Device Error", message: "No Network! App aborts");
            }
            return };
        
        QuoteCore.QueryQuote(self.displayResult); // calling from GUI only

    }
    
}

// MARK: local functions

extension QuoteViewController {
    
    public func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func displayResult(dataStr: String) {
        let results = QuoteCore.parseJson(jsonString: dataStr);
        quoteTitle = results.title;
        quoteLine = results.quote;
        quoteAuthor = results.author;
        titleLabel.text = quoteTitle;
        quoteLabel.text = quoteLine + "\n\n\n" + quoteAuthor;

    }
    
}
