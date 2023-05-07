import 'package:mini_project_mandor_pc/api/cpu_api.dart';
import 'package:mini_project_mandor_pc/model/cpu_model.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'cpu_api_test.mocks.dart';

@GenerateMocks([ApiCpu])
void main() {
  ApiCpu apiCpu = MockApiCpu();
  test('get all cpu return data', () async {
    when(apiCpu.getCpu()).thenAnswer((_) async => <CpuModel>[
          CpuModel(
              id: 1,
              title: 'nzxt',
              asin: 'xads22',
              link: 'http://abc.com',
              categories: [
                Category(
                    name: CategoryName.COMPUTER_CPU_PROCESSORS, id: 'sdsdsds')
              ],
              image: 'sdsdsdsd',
              rating: 4.8,
              ratingsTotal: 121233,
              price: Price(
                  symbol: Symbol.EMPTY,
                  value: 22.00,
                  currency: Currency.USD,
                  raw: '22.00'))
        ]);
    var cpus = await apiCpu.getCpu();
    expect(cpus.isNotEmpty, true);
  });
}
