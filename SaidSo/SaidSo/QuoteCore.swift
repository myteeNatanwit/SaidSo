//
//  QuoteCore.swift
//  SaidSo
//
//  Created by Michael Tran on 22/4/2022.
//

import Foundation

public class QuoteCore {

    class func QueryQuote(_ callback: @escaping (_ in: String) -> ()) {
 
            NetworkModel.getRequest(theUrl: "https://quotes.rest/qod.json?category=inspire"){jsonStr in

                  callback(jsonStr);
          }
    }
   
// parse n return 3 strings (title, quote and author)
    class func parseJson(jsonString: String) -> (title: String, quote: String, author: String) {
        do {

            // Decode data to object
            let data = jsonString.data(using: .utf8)!
            
            let jsonDecoder = JSONDecoder();
            let aQuote = try jsonDecoder.decode(theQuote.self, from: data);
  
            return (title : aQuote.contents.quotes[0].title, quote : aQuote.contents.quotes[0].quote, author : aQuote.contents.quotes[0].author);
            
        }
        catch {
            print("Error parseJson");
        }
        return ("","","");
    }
    
}
