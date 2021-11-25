//
//  AsyncOperation.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 25.11.2021.
//

import Foundation

open class AsyncOperation: Operation {
    public enum State: String {
        case ready, executing, finished

        fileprivate var keyPath: String {
            "is" + rawValue.capitalized
        }
    }

    public var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
}

extension AsyncOperation {
    open override var isAsynchronous: Bool {
        true
    }

    open override var isReady: Bool {
        super.isReady && state == .ready
    }

    open override var isExecuting: Bool {
        state == .executing
    }

    open override var isFinished: Bool {
        state == .finished
    }

    open override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }

    open override func cancel() {
        super.cancel()
        state = .finished
    }
}

