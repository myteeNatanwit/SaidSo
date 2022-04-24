//
//  QuoteData.swift
//  SaidSo
//
//  Created by Michael Tran on 21/4/2022.
//

 let json = """
 {
     "success": {
         "total": 1
     },
     "contents": {
         "quotes": [
             {
                 "quote": "Not every day is going to offer us a chance to save somebody's life, but every day offers us an opportunity to affect one.",
                 "length": "122",
                 "author": "Mark Bezos",
                 "tags": {
                     "0": "inspire",
                     "1": "life",
                     "3": "tod"
                 },
                 "category": "inspire",
                 "language": "en",
                 "date": "2022-04-24",
                 "permalink": "https://theysaidso.com/quote/mark-bezos-not-every-day-is-going-to-offer-us-a-chance-to-save-somebodys-life-bu",
                 "id": "9V2lXZnG7op9S4S8prwXfQeF",
                 "background": "https://theysaidso.com/img/qod/qod-inspire.jpg",
                 "title": "Inspiring Quote of the day"
             }
         ]
     },
     "baseurl": "https://theysaidso.com",
     "copyright": {
         "year": 2024,
         "url": "https://theysaidso.com"
     }
 }

"""

import Foundation

// MARK: - theQuote
struct theQuote: Codable {
    let contents: Contents
}

// MARK: - Contents
struct Contents: Codable {
    let quotes: [Quote]
}

// MARK: - Quote
struct Quote: Codable {
    let quote, title, author: String
}

var quoteTitle = "";
var quoteLine = ""
var quoteAuthor = "";
