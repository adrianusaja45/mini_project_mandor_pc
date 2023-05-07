import 'package:mini_project_mandor_pc/api/cpu_cooler_api.dart';
import 'package:mini_project_mandor_pc/model/cpu_cooler_model.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'cpu_cooler_api_test.mocks.dart';

@GenerateMocks([ApiCooler])
void main() {
  ApiCooler apiCooler = MockApiCooler();
  test('get all cpu cooler return data', () async {
    when(apiCooler.getCpuCooler()).thenAnswer((_) async => <CpuCoolerModel>[
          CpuCoolerModel(
              id: 1,
              title: 'noctua',
              asin: 'sdsdsdada',
              link: 'www.com',
              categories: <Category>[
                Category(name: Name.COMPUTER_CPU_COOLING_FANS, id: '1')
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
    var cpuCoolers = await apiCooler.getCpuCooler();
    expect(cpuCoolers.isNotEmpty, true);
  });
}
