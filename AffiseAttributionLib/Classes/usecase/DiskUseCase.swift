import Foundation

protocol DiskUseCase {
    func getTotalDisk() -> Int64?

    func getFreeDisk() -> Int64?
}
