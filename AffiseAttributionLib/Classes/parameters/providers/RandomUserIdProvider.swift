import Foundation

/**
 * Provider for parameter [ProviderType.RANDOM_USER_ID]
 *
 * @property useCase to retrieve random user id
 */
public class RandomUserIdProvider: StringPropertyProvider {
    private let useCase: AppUUIDs
    
    init(useCase: AppUUIDs) {
        self.useCase = useCase
    }
    
    public override func provide() -> String? {
        return useCase.getRandomUserId()
    }
    
    public override func getOrder() -> Float {
        49.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.RANDOM_USER_ID
    }
}
