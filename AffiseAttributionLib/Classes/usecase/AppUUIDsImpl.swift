import Foundation


internal class AppUUIDsImpl : AppUUIDs {

    
    private let queue = DispatchQueue(label: "com.affise.AppUUIDs")

    private let preferences: UserDefaults
    private let packageInfoUseCase: PackageInfoUseCase
    private let persistentUseCase: PersistentUseCase
    private let md5Converter: StringToMD5Converter
    
    init(
        preferences: UserDefaults,
        packageInfoUseCase: PackageInfoUseCase,
        persistentUseCase: PersistentUseCase,
        md5Converter: StringToMD5Converter
    ) {
        self.preferences = preferences
        self.packageInfoUseCase = packageInfoUseCase
        self.persistentUseCase = persistentUseCase
        self.md5Converter = md5Converter
    }

    func getAffiseDeviseId() -> String? {
        queue.sync {
            let prefDeviseId = preferences.string(forKey: AppUUIDsConstants.AFF_DEVICE_ID)
            if prefDeviseId?.isBlank == false {
                return prefDeviseId
            }

            let affDeviceId = persistentUseCase.getAffDeviceId()?.sign(.PERSISTENT)

            if affDeviceId?.isBlank == false {
                return affDeviceId
            }

            let genUUID = generateUUID().uuidString.lowercased()
                .sign(SignType.RANDOM)

            preferences.set(genUUID, forKey: AppUUIDsConstants.AFF_DEVICE_ID)
            return preferences.string(forKey: AppUUIDsConstants.AFF_DEVICE_ID) ?? AffiseError.UUID_NO_VALID_METHOD
        }
    }

    func getAffiseAltDeviseId() -> String? {
        queue.sync {
            let prefAltDeviseId = preferences.string(forKey: AppUUIDsConstants.AFF_ALT_DEVICE_ID)
            if prefAltDeviseId?.isBlank == false {
                return prefAltDeviseId
            }

            let genUUID = generateUUID().uuidString.lowercased()
                .sign(SignType.RANDOM)

            preferences.set(genUUID, forKey: AppUUIDsConstants.AFF_ALT_DEVICE_ID)
            return preferences.string(forKey: AppUUIDsConstants.AFF_ALT_DEVICE_ID) ?? AffiseError.UUID_NO_VALID_METHOD
        }
    }

    func getRandomUserId() -> String? {
        queue.sync {
            let prefUserId = preferences.string(forKey: AppUUIDsConstants.RANDOM_USER_ID)
            if prefUserId?.isBlank == false {
                return prefUserId
            }

            let installTime = packageInfoUseCase.getFirstInstallTime()?.timeInMillis
            var affUserId: String? = nil
            if let timeString = installTime?.description {
                affUserId = md5Converter.convert(from: timeString)
                    .toFakeUUID()
                    .sign(SignType.INSTALL_TIME)
            }
        
            if affUserId?.isBlank == false {
                return affUserId
            }

            let genUUID = generateUUID().uuidString.lowercased()
                .sign(SignType.RANDOM)

            preferences.set(genUUID, forKey: AppUUIDsConstants.RANDOM_USER_ID)
            return preferences.string(forKey: AppUUIDsConstants.RANDOM_USER_ID) ?? AffiseError.UUID_NO_VALID_METHOD
        }
    }
}
