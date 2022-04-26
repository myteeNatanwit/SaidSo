//
//  RefreshView.swift
//  SaidSo
//
//  Created by Michael Tran on 25/4/2022.
//

import UIKit

class RefreshView: UIView {
  
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
            print("touch");
       //     QuoteCore.QueryQuote(self.displayResult);
        }
    }
}
