import Foundation
import CommonCrypto

class StringToMD5Converter : Converter {
    private static let ALGORITHM_NAME = "MD5"
    
    typealias T = String
    typealias R = String
    
    /**
     * Convert [from] to md5
     *
     * @return value of md5
     */
    func convert(from: String) -> String  {
        return from.md5()
    }
}

extension Data {
    public func md5() -> String{
        return hexStringFromData(input: digest(input: self as NSData))
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_MD5(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
}

extension String {
    func md5() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.md5()
        }
        return ""
    }
}
