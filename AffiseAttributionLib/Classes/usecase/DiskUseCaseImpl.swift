import Foundation

internal class DiskUseCaseImpl: DiskUseCase {

    private var fileSystemAttributes: [FileAttributeKey: Any]? {
        try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
    }

    func getTotalDisk() -> Int64? {
        return (fileSystemAttributes?[.systemSize] as? NSNumber)?.int64Value
    }

    func getFreeDisk() -> Int64? {
        return (fileSystemAttributes?[.systemFreeSize] as? NSNumber)?.int64Value
    }
}
