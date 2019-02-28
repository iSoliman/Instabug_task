//
//  Utilities.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/25/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit

class Utilities: NSObject {

    static func formattedText(fromDate date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        
        return formatter.string(from: date)
        
    }
    
}
