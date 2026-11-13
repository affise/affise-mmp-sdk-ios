protocol RemarketingUseCase {
    
    var osAndVersion: String { get }
    var device: String? { get }
    var build: String? { get }
    
    func local() -> String
}
