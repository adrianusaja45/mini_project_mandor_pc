import 'package:mini_project_mandor_pc/api/storage_api.dart';
import 'package:mini_project_mandor_pc/model/storage_model.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'storage_api_test.mocks.dart';

@GenerateMocks([ApiStorage])
void main() {
  ApiStorage apiStorage = MockApiStorage();
  test('get all storage return data', () async {
    when(apiStorage.getStorage()).thenAnswer((_) async => <StorageModel>[
          StorageModel(
              id: 1,
              title: 'asus',
              link: 'www.com',
              asin: 'sdsdsds',
              categories: <Category>[
                Category(name: Name.DATA_STORAGE, id: '1')
              ],
              image: 'sdsdsds',
              rating: 4,
              ratingsTotal: 4,
              price: Price(
                  symbol: Symbol.EMPTY,
                  value: 4,
                  currency: Currency.USD,
                  raw: '4'))
        ]);
    var storage = await apiStorage.getStorage();
    expect(storage.isNotEmpty, true);
  });
}
