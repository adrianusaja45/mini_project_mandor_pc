import 'package:mini_project_mandor_pc/api/ram_api.dart';
import 'package:mini_project_mandor_pc/model/ram_model.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'ram_api_test.mocks.dart';

@GenerateMocks([ApiRam])
void main() {
  ApiRam apiRam = MockApiRam();
  test('get all ram return data', () async {
    when(apiRam.getRam()).thenAnswer((_) async => <RamModel>[
          RamModel(
              id: 1,
              title: 'asus',
              link: 'www.com',
              asin: 'sdsdsdada',
              categories: <Category>[
                Category(name: Name.COMPUTER_MEMORY, id: 'sdsds')
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
    var ram = await apiRam.getRam();
    expect(ram.isNotEmpty, true);
  });
}
