import Foundation

private func get64LeastSignificantBitsForVersion1() -> Int64  {
    let random = Int64.random(in: 0...Int64.max)
    let random63BitLong = random & 0x3FFFFFFFFFFFFFFF
    let variant3BitFlag = Int64.min
    return random63BitLong | variant3BitFlag
}

private func get64MostSignificantBitsForVersion1() -> Int64  {
    let currentTimeMillis = Date().timeIntervalSince1970.timeInMillis
    let timeLow = (currentTimeMillis & 0x00000000FFFFFFFF) << 32
    let timeMid = ((currentTimeMillis >> 32 ) & 0xFFFF) << 16
    let version: Int64 = 1 << 12
    let timeHi = (currentTimeMillis >> 48) & 0x0FFF
    return timeLow | timeMid | version | timeHi
}

private func generateType1UUID() -> UUID {
    var most64SigBits = get64MostSignificantBitsForVersion1()
    var least64SigBits = get64LeastSignificantBitsForVersion1()
    let mostData = Data(bytes: &most64SigBits, count: MemoryLayout<Int64>.size)
    let leastData = Data(bytes: &least64SigBits, count: MemoryLayout<Int64>.size)
    let bytes = [UInt8](mostData) + [UInt8](leastData)
    let tuple: uuid_t = (bytes[7], bytes[6], bytes[5], bytes[4],
                         bytes[3], bytes[2], bytes[1], bytes[0],
                         bytes[15], bytes[14], bytes[13], bytes[12],
                         bytes[11], bytes[10], bytes[9], bytes[8])
    
    return UUID(uuid: tuple)
}

internal func generateUUID() -> UUID {
    return generateType1UUID()
}

extension String {
    func sign(_ type: SignType) -> String {
        if self.count < type.rawValue.count { return self }
        return dropLast(type.rawValue.count) + type.rawValue
    }

    func toFakeUUID() -> String {
        if self.isEmpty { return self }

        var baseString = self
        let uuidLength = 4*8

        while baseString.count < uuidLength {
            baseString += baseString
        }

        baseString = String(baseString.prefix(uuidLength))

        let idx1 = baseString.index(baseString.startIndex, offsetBy: 8)
        let idx2 = baseString.index(idx1, offsetBy: 4)
        let idx3 = baseString.index(idx2, offsetBy: 4)
        let idx4 = baseString.index(idx3, offsetBy: 4)
        let idx5 = baseString.index(idx4, offsetBy: 12)

        let uuid1 = String(baseString[baseString.startIndex..<idx1])
        let uuid2 = String(baseString[idx1..<idx2])
        let uuid3 = String(baseString[idx2..<idx3])
        let uuid4 = String(baseString[idx3..<idx4])
        let uuid5 = String(baseString[idx4..<idx5]) 

        return "\(uuid1)-\(uuid2)-\(uuid3)-\(uuid4)-\(uuid5)"
    }
}

enum SignType: String {
    case RANDOM = "00"
    case INSTALL_TIME = "01"
    case PERSISTENT = "02"
}
