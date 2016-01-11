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
//  SFErrors : SFFailable.swift
//
//  Created by Samuel Grau on 01/03/2015.
//  Copyright (c) 2015 Samuel Grau. All rights reserved.
//
//

//  based on the work of David Owens II https://github.com/owensd/SwiftLib/
//

///
/// A `SFFailable` should be returned from functions that need to return 
/// success or failure information but has no other
/// meaning information to return. 
/// Functions that need to also return a value on success should 
/// use `SFFailableOf<T>`.
///
public enum SFFailable {
    case Success
    case Failure(SFError)

    init() {
        self = .Success
    }

    init(_ error: SFError) {
        self = .Failure(error)
    }

    /// A property maintaining information about the failed state
    public var failed: Bool {
        switch self {
        case .Failure( _):
            return true

        default:
            return false
        }
    }

    /// The error if any.
    public var error: SFError? {
        switch self {
        case .Failure(let error):
            return error

        default:
            return nil
        }
    }
}

///
/// A `SFFailableOf<T>` should be returned from functions that need to 
/// return success or failure information and some
/// corresponding data back upon a successful function call.
///
public enum SFFailableOf<T> {
    case Success(SFFailableValueWrapper<T>)
    case Failure(SFError)

    public init(_ value: T) {
        self = .Success(SFFailableValueWrapper(value))
    }

    public init(_ error: SFError) {
        self = .Failure(error)
    }

    public var failed: Bool {
        switch self {
        case .Failure( _):
            return true

        default:
            return false
        }
    }

    public var error: SFError? {
        switch self {
        case .Failure(let error):
            return error

        default:
            return nil
        }
    }

    public var value: T? {
        switch self {
        case .Success(let wrapper):
            return wrapper.value

        default:
            return nil
        }
    }
}

/// 
/// This is a workaround-wrapper class for a bug in the Swift compiler. 
/// DO NOT USE THIS CLASS!!
///
public class SFFailableValueWrapper<T> {
    /// The value
    public let value: T
    
    /// - parameter value: The value to store
    public init(_ value: T) { self.value = value }
}

