import Foundation
import Combine

extension Publisher where Output == Void, Failure == Never {
    public func kickstart() -> AnyPublisher<Self.Output, Self.Failure> {
        self.prepend(()).eraseToAnyPublisher()
    }
}

extension Publisher {

    public func mapToVoid() -> AnyPublisher<Void, Self.Failure> {
        self.map { _ in return () }.eraseToAnyPublisher()
    }
}
