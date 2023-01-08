//
//  ResponseResult.swift
//  AZS
//
//  Created by Паша Терехов on 03.01.2023.
//

import Foundation

enum ResponseResult<Value, Error> {
    case success(Value)
    case failture(Error)
}

enum LoadingError {
    case InvalidURL
    case InvalidStatusCode
    case DataIsNil
    case DecodingError
    case Error
}
