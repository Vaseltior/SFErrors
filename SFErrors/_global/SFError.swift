//
// The MIT License (MIT)
//
// Copyright (c) 2015 Samuel GRAU
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

//
//  SFErrors : SFError.swift
//
//  Created by Samuel Grau on 01/03/2015.
//  Copyright (c) 2015 Samuel Grau. All rights reserved.
//
//

//  based on the work of David Owens II https://github.com/owensd/SwiftLib/
//

///
/// Creates a new type that is used to represent error information in Swift.
///
/// This is a new Swift-specific error type used to return error information. 
/// The primary usage of this object is to
/// return it as a `SFFailable` or `SFFailableOf<T>` from function that could fail.
///
/// Example:
///     `func readContentsOfFileAtPath(path: String) -> Failable<String>`
///
public struct SFError {
    /// A simple alias
    public typealias SFErrorInfoDictionary = Dictionary<String, Any>

    /// The error code used to differentiate between various error states.
    public let code: Int

    /// A string that is used to group errors into related error buckets.
    public let domain: String

    /// A place to store any custom information that needs to be passed along with the error instance.
    public let userInfo: SFErrorInfoDictionary

    ///
    /// Initializes a new `Error` instance.
    ///
    /// :param: code The error code
    /// :param: domain The error domain
    /// :param: userInfo Any neede user info
    ///
    /// :returns: A new SFError instance
    ///
    public init(code: Int, domain: String, userInfo: SFErrorInfoDictionary?) {
        self.code = code
        self.domain = domain
        
        if let info = userInfo {
            self.userInfo = info
            
        } else {
            self.userInfo = SFErrorInfoDictionary()
        }
    }
}
