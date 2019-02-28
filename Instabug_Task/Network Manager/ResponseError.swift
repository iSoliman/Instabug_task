//
//  ResponseError.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/28/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit

class ResponseError: Decodable {

    let statusMsg: String?
    let success: Bool?
    let statusCode: Int?
        
    enum CodingKeys: String, CodingKey {
        
        case success
        case statusMsg = "status_message"
        case statusCode = "status_code"
    }
    
}
