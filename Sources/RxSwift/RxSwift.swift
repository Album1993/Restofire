//
//  RxSwift.swift
//  Restofire
//
//  Created by Rahul Katariya on 28/03/16.
//  Copyright © 2016 AarKay. All rights reserved.
//

import Alamofire
import RxSwift

public extension RequestType {
    
    public func executeTask<Model: Any>() -> Observable<Model> {

        return Observable.create { observer in
            self.executeTask({ (result: Result<Model, NSError>) in
                if let error = result.error {
                    observer.on(.Error(error))
                } else {
                    observer.on(.Next(result.value!))
                    observer.on(.Completed)
                }
            })
            
            return AnonymousDisposable {
                
            }
        }
        
    }
    
}