//
//  MailCore.swift
//  SaidSo
//
//  Created by Michael Tran on 23/4/2022.
//

import Foundation
import MessageUI

var theList: [String] = [];
public class MailCore {
    
    class func prepareMailList() {
        theList = [];
        for item in emailList {
            theList.append(item.email);
        }
    }
    
}
