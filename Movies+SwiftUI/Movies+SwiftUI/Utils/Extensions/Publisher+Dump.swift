import Foundation
import Combine

extension Publisher {

    func dump() -> AnyPublisher<Self.Output, Self.Failure> {
        handleEvents(receiveOutput:  { value in
            Swift.dump(value)
        })
        .eraseToAnyPublisher()
    }
}
