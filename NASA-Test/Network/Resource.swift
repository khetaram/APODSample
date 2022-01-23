//
//  Resource.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 22/01/22.
//

import Foundation

/// This is an state machine of any task which has 3 possible states while execution
public enum ResourceState<T> {
    /// Loading case represent that network operation is happening
    case loading

    /// Success case return once it gets valid data
    case success(data: T)

    /// Error case is returned if task fails due to some reason
    case error(_ error: Error)
}
