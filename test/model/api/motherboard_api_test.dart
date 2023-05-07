import 'package:mini_project_mandor_pc/api/motherboard_api.dart';
import 'package:mini_project_mandor_pc/model/motherboard_model.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'motherboard_api_test.mocks.dart';

@GenerateMocks([ApiMotherboard])
void main() {
  ApiMotherboard apiMotherboard = MockApiMotherboard();
  test('get all motherboard return data', () async {
    when(apiMotherboard.getMobo()).thenAnswer((_) async => <MotherboardModel>[
          MotherboardModel(
              id: 1,
              title: 'asus',
              asin: 'sdsdsdada',
              link: 'www.com',
              categories: <CategoryElement>[
                CategoryElement(
                    name: CategoryEnum.COMPUTER_MOTHERBOARDS, id: '1')
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
    var mobo = await apiMotherboard.getMobo();
    expect(mobo.isNotEmpty, true);
  });
}
