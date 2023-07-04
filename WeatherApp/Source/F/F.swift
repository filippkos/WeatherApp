//
//  F.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 21.06.2023.
//

import Foundation

public enum F {

    typealias ResultHandler<T> = (Result<T, Error>) -> ()
    public typealias VoidFunc<T> = (T) -> ()
}
