import Foundation

protocol ProcessInfoUseCase {
    func getCpuName() -> String
    func getCpuCores() -> Int64
}
