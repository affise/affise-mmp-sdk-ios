import SwiftUI
import AffiseAttributionLib
import StoreKit


struct Product {
    static let all: [AffiseProductType: [String]] = [
        AffiseProductType.CONSUMABLE : [
            "com.testapp.consum_1",
            "com.testapp.consum_2",
            "com.testapp.invalid"
        ],
        AffiseProductType.NON_CONSUMABLE : [
            "com.testapp.non_consum_1",
            "com.testapp.non_consum_2"
        ],
        AffiseProductType.NON_RENEWABLE_SUBSCRIPTION : [
            "com.testapp.subs_1",
            "com.testapp.subs_2"
        ],
        AffiseProductType.RENEWABLE_SUBSCRIPTION : [
            "com.testapp.auto_subs_week",
            "com.testapp.auto_subs_month",
            "com.testapp.auto_subs_year"
        ],
    ]
    
    static var allIds: [String] {
        all.values.flatMap { $0 }
    }
    
    static func getType(_ id: String?) -> AffiseProductType? {
        guard let id = id else {
            return nil
        }
        return all.first { $0.value.contains(id) }?.key
    }
}

func titleByType(_ type: AffiseProductType) -> String {
    switch type {
    case .CONSUMABLE: return "CONSUMABLE"
    case .NON_CONSUMABLE: return "NON CONSUMABLE "
    case .RENEWABLE_SUBSCRIPTION: return "Auto renew SUBSCRIPTION"
    case .NON_RENEWABLE_SUBSCRIPTION: return "SUBSCRIPTION"
    }
}

@available(iOS 13.0, *)
struct StoreView: View {
    
    @State var hasSubscriptionModule: Bool = Affise.Module.Subscription.hasModule()
       
    var body: some View {
        VStack {
            if hasSubscriptionModule {
                Products()
            } else {
               Text("No Subscription Module")
            }
        }
    }
}

@available(iOS 13.0, *)
struct Products: View {
    
    @State var products: [AffiseProduct] = []
    
    func typeMatch(_ product: AffiseProduct, _ type: AffiseProductType) -> Bool {
        return Product.all[type]?.contains(product.productId ) ?? false
    }
       
    var body: some View {
        VStack {
            ForEach(Array(Product.all.keys.sorted { $0.rawValue < $1.rawValue }), id: \.self) { type in
                List {
                    Section {
                        ForEach(products, id: \.productId) { product in
                            if typeMatch(product, type) {
                                ProductRowView(product: product)
                            }
                        }
                    } header: {
                        Text(titleByType(type))
                            .font(.headline)
                    }
                }
                .frame(maxWidth:.infinity)
                .edgesIgnoringSafeArea(.all)
                .listStyle(.automatic)
            }
            
            Button("Fetch Products") {
                initProducts()
            }
        }
        .onAppear {
            initProducts()
        }
    }
    
    func initProducts() {
        Affise.Module.Subscription.fetchProducts(Product.allIds) { result in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success(let result):
                products = result.products
                    .sorted { $0.price?.value ?? 0 < $1.price?.value ?? 0 }

                // print("invalid ids: [\(result.invalidIds.joined(separator: ", "))]")
            }
        }
    }
}

@available(iOS 13.0, *)
struct ProductRowView: View {
    
    var product: AffiseProduct
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    func price(_ amount: Decimal?, _ local: Locale?) -> String? {
        guard let amount = amount else {
            return nil
        }

        currencyFormatter.locale = local
        return currencyFormatter.string(from: amount as NSNumber)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.body)
                Text(product.productDescription)
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                
                if let subscription = product.subscription {
                    Text("\(subscription.numberOfUnits) \(subscription.timeUnit.description)")
                        .font(.footnote)
                }
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            
            Text(
                product.price?.formattedPrice ?? "-"
            )
            
            Button("Buy") {
                purchase(product)
            }
        }
        .padding([.leading, .trailing], 0)
        .frame(maxWidth:.infinity, alignment: .leading)
        .listRowBackground(Color.gray.opacity(0.2))
    }
    
    func purchase(_ product: AffiseProduct) {
        Affise.Module.Subscription.purchase(product, Product.getType(product.productId)) { result in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success(let purchasedInfo):
                print("\(purchasedInfo)")
            }
        }
    }
}

#if targetEnvironment(simulator)
@available(iOS 13.0, *)
struct Products_Previews: PreviewProvider {

    static let products: [AffiseProduct] = [
        AffiseProduct("Preview product 1", 0.01, "Test"),
        AffiseProduct("Preview product 2", 0.02, "Test"),
    ]
    
    static var previews: some View {
        Products(products: products)
    }
}

extension AffiseProduct {
    convenience init(_ title: String, _ price: Decimal, _ productDescription: String? = nil) {
        self.init(
            productId: "test",
            title: title,
            productDescription: productDescription ?? "",
            productType: nil,
            price: AffiseProductPrice(value: price),
            subscription: nil,
            productDetails: nil
        )
    }
}
#endif
