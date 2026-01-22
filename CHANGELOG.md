# Changelog

## [1.6.59] - 2026-01-22

### Added

- Api `Affise.getRandomUserId` added new algorithm for id generation
- Api `Affise.getRandomDeviceId` added new algorithm for id generation
- Error value for `AffiseError.UUID_NO_VALID_METHOD` is `22222222-2222-2222-2222-222222222222`
- Error value for `AffiseError.UUID_NOT_INITIALIZED` is `11111111-1111-1111-1111-111111111111`

### Changed

- Update Api `Affise.getRandomUserId` return `AffiseError.UUID_NOT_INITIALIZED` if SDK not initialized
- Update Api `Affise.getRandomUserId` return `AffiseError.UUID_NO_VALID_METHOD` if no valid methods to retrieve id
- Update Api `Affise.getRandomDeviceId` return `AffiseError.UUID_NOT_INITIALIZED` if SDK not initialized
- Update Api `Affise.getRandomDeviceId` return `AffiseError.UUID_NO_VALID_METHOD` if no valid methods to retrieve id

## [1.6.58] - 2025-11-21

### Fixed

- Fix `AffiseError` parsing

## [1.6.57] - 2025-10-22

### Fixed

- Fix `Affise.getDeferredDeeplinkValue`

## [1.6.56] - 2025-10-01

### Added

- Error `SDK is already initialized` to `Affise.settings.setOnInitError`

## [1.6.55] - 2025-09-11

### Added

- Api `Affise.settings.setDisableModules`

### Removed

- Api `Affise.Module.moduleStart`
  
## [1.6.54] - 2025-08-13

### Added

- New module `TikTok`.
- Api `Affise.Module.TikTok.sendEvent`.

## [1.6.53] - 2025-07-23

### Added

- New module `AdServices`
- Provider `AD_SERVICE_ATTRIBUTION`
  
## [1.6.52] - 2025-07-10

### Added

- Provider `PUSHTOKEN_SERVICE`

## [1.6.51] - 2025-06-18

### Added

- Api `Affise.Module.AppsFlyer.hasModule`
- Api `Affise.Module.Link.hasModule`
- Api `Affise.Module.Subscription.hasModule`
  
## [1.6.50] - 2025-05-21

### Added

- New module `AppsFlyer`
- Api `Affise.Module.AppsFlyer.logEvent`

### Changed

- Api `Affise.Module.linkResolve` moved to `Affise.Module.Link.resolve`
- Api `Affise.Module.fetchProducts` moved to `Affise.Module.Subscription.fetchProducts`
- Api `Affise.Module.purchase` moved to `Affise.Module.Subscription.purchase`

## [1.6.49] - 2025-04-14

### Removed

- Remove code support for `iOS` version lesser then `12`

### Changed

- Update EventsManager scheduler

## [1.6.48] - 2025-03-25

### Added

- Api `Affise.settings.setOnInitSuccess`
- Api `Affise.settings.setOnInitError`
- Api `Affise.Debug.version`

## [1.6.47] - 2025-03-12

### Fixed

- Fix `CI/CD`

## [1.6.46] - 2025-03-11

### Changed

- Api `Affise.getReferrerOnServer` moved to `Affise.getDeferredDeeplink`
- Api `Affise.getReferrerOnServerValue` moved to `Affise.getDeferredDeeplinkValue`

## [1.6.45] - 2025-02-25

### Added

- New module `Persistent`
  
## [1.6.44] - 2025-02-19

### Added

- Persistent `AFFISE_DEVICE_ID`

## [1.6.43] - 2025-02-07

### Added

- New event index `affise_event_id_index`
- New postback index `uuid_index`

### Fixed

- Fix `ProviderType.INSTALL_FIRST_EVENT`

## [1.6.42] - 2024-10-03

### Fixed

- Fix `Affise.Module.getStatus` timing retry

## [1.6.41] - 2024-10-01

### Added

- Module `Subscription` StoreKit2 support

## [1.6.40] - 2024-09-03

### Fixed

- Module `Subscription`

### Changed

- Update `internal` library for crossplatform

## [1.6.39] - 2024-08-16

### Added

- New internal events

## [1.6.38] - 2024-08-06

### Added

- Api `Affise.getReferrerUrl`
- Api `Affise.getReferrerUrlValue`
- Api `Affise.getReferrerOnServer`
- Api `Affise.getReferrerOnServerValue`

### Removed

- Api `Affise.getReferrer`
- Api `Affise.getReferrerValue`

## [1.6.37] - 2024-08-05

### Added

- Add `NSUserActivity.referrerURL` for `Affise.getReferrer` and `Affise.getReferrerValue`

## [1.6.36] - 2024-07-30

### Fixed

- Fix `unsafe build flags`

## [1.6.35] - 2024-07-29

### Fixed

- Api `Affise.Module.getStatus`

## [1.6.34] - 2024-07-26

### Added

- Modules compatibility check

## [1.6.33] - 2024-06-28

### Added

- New module `Link`

### Changed

- Update `registerDeeplinkCallback` change uri to convenient values
- Api `Affise.getStatus` moved to `Affise.Module.getStatus`
- Api `Affise.moduleStart` moved to `Affise.Module.moduleStart`
- Api `Affise.getModulesInstalled` moved to `Affise.Module.getModulesInstalled`

## [1.6.32] - 2024-05-28

### Removed

- Result for failed `sendNow`

### Changed

- Update `internal` library for crossplatform
  
## [1.6.31] - 2024-05-17

### Fixed

- CI/CD

## [1.6.30] - 2024-05-16

### Fixed

- Json serialization

## [1.6.29] - 2024-04-24

### Added

- Event api `sendNow`

### Removed

- Event api `sendEvents`

### Changed

- Fix typos in `Subscription` module

## [1.6.28] - 2024-04-01

### Added

- New module `Subscription`
- New event `FailedPurchaseEvent`
- New values in `PredefinedString`

### Changed

- Improve `AffiseModuleManager`
- Update for demo app
  
[1.6.59]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.58...1.6.59
[1.6.58]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.57...1.6.58
[1.6.57]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.56...1.6.57
[1.6.56]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.55...1.6.56
[1.6.55]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.54...1.6.55
[1.6.54]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.53...1.6.54
[1.6.53]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.52...1.6.53
[1.6.52]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.51...1.6.52
[1.6.51]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.50...1.6.51
[1.6.50]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.49...1.6.50
[1.6.49]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.48...1.6.49
[1.6.48]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.47...1.6.48
[1.6.47]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.46...1.6.47
[1.6.46]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.45...1.6.46
[1.6.45]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.44...1.6.45
[1.6.44]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.43...1.6.44
[1.6.43]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.42...1.6.43
[1.6.42]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.41...1.6.42
[1.6.41]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.40...1.6.41
[1.6.40]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.39...1.6.40
[1.6.39]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.38...1.6.39
[1.6.38]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.37...1.6.38
[1.6.37]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.36...1.6.37
[1.6.36]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.35...1.6.36
[1.6.35]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.34...1.6.35
[1.6.34]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.33...1.6.34
[1.6.33]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.32...1.6.33
[1.6.32]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.31...1.6.32
[1.6.31]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.30...1.6.31
[1.6.30]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.29...1.6.30
[1.6.29]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.28...1.6.29
[1.6.28]: https://github.com/affise/affise-mmp-sdk-ios/compare/1.6.27...1.6.28
