import 'package:mini_project_mandor_pc/api/psu_api.dart';
import 'package:mini_project_mandor_pc/model/psu_model.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'psu_api_test.mocks.dart';

@GenerateMocks([ApiPsu])
void main() {
  ApiPsu apiPsu = MockApiPsu();
  test('get all psu return data', () async {
    when(apiPsu.getPsu()).thenAnswer((_) async => <PsuModel>[
          PsuModel(
              id: 1,
              title: 'asus',
              link: 'www.com',
              categories: <Category>[
                Category(name: Name.ALL_DEPARTMENTS, id: Id.APS)
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
    var psu = await apiPsu.getPsu();
    expect(psu.isNotEmpty, true);
  });
}
