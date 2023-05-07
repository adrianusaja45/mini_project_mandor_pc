import 'package:mini_project_mandor_pc/api/gpu_api.dart';
import 'package:mini_project_mandor_pc/model/gpu_model.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'gpu_api_test.mocks.dart';

@GenerateMocks([ApiGpu])
void main() {
  ApiGpu apiGpu = MockApiGpu();
  test('get all gpu return data', () async {
    when(apiGpu.getGpu()).thenAnswer((_) async => <GpuModel>[
          GpuModel(
              id: 1,
              title: 'nvidia',
              asin: 'sdsdsdada',
              link: 'www.com',
              categories: <Category>[
                Category(name: Name.COMPUTER_GRAPHICS_CARDS, idCategory: '1')
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

    var gpus = await apiGpu.getGpu();
    expect(gpus.isNotEmpty, true);
  });
}
