//
//  ZipFunc.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 06.02.23.
//

import Foundation

struct Zip6Sequence<E1, E2, E3, E4, E5, E6>: Sequence, IteratorProtocol {
    private let _next: () -> (E1, E2, E3, E4, E5, E6)?
    
    init<S1: Sequence,
         S2: Sequence,
         S3: Sequence,
         S4: Sequence,
         S5: Sequence,
         S6: Sequence>(_ s1: S1,
                       _ s2: S2,
                       _ s3: S3,
                       _ s4: S4,
                       _ s5: S5,
                       _ s6: S6) where S1.Element == E1, S2.Element == E2, S3.Element == E3, S4.Element == E4, S5.Element == E5, S6.Element == E6 {
        
        var it1 = s1.makeIterator()
        var it2 = s2.makeIterator()
        var it3 = s3.makeIterator()
        var it4 = s4.makeIterator()
        var it5 = s5.makeIterator()
        var it6 = s6.makeIterator()
        _next = {
            guard let e1 = it1.next(), let e2 = it2.next(), let e3 = it3.next(), let e4 = it4.next(), let e5 = it5.next(), let e6 = it6.next() else { return nil }
            return (e1, e2, e3, e4, e5, e6)
        }
    }
    
    mutating func next() -> (E1, E2, E3, E4, E5, E6)? {
        return _next()
    }
}

struct Zip3Sequence<E1, E2, E3>: Sequence, IteratorProtocol {
    private let _next: () -> (E1, E2, E3)?
    
    init<S1: Sequence,
         S2: Sequence,
         S3: Sequence>(_ s1: S1,
                       _ s2: S2,
                       _ s3: S3) where S1.Element == E1, S2.Element == E2, S3.Element == E3 {
        
        var it1 = s1.makeIterator()
        var it2 = s2.makeIterator()
        var it3 = s3.makeIterator()

        _next = {
            guard let e1 = it1.next(), let e2 = it2.next(), let e3 = it3.next() else { return nil }
            return (e1, e2, e3)
        }
    }
    
    mutating func next() -> (E1, E2, E3)? {
        return _next()
    }
}


func zip6<S1: Sequence,
          S2: Sequence,
          S3: Sequence,
          S4: Sequence,
          S5: Sequence,
          S6: Sequence>(_ s1: S1,
                        _ s2: S2,
                        _ s3: S3,
                        _ s4: S4,
                        _ s5: S5,
                        _ s6: S6) -> Zip6Sequence<S1.Element, S2.Element, S3.Element, S4.Element, S5.Element, S6.Element> {
    return Zip6Sequence(s1, s2, s3, s4, s5, s6)
}

func zip3<S1: Sequence,
          S2: Sequence,
          S3: Sequence>(_ s1: S1,
                        _ s2: S2,
                        _ s3: S3) -> Zip3Sequence<S1.Element, S2.Element, S3.Element> {
    return Zip3Sequence(s1, s2, s3)
}
