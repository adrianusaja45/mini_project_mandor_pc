import 'package:mini_project_mandor_pc/api/case_api.dart';
import 'package:mini_project_mandor_pc/model/case_model.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'case_api_test.mocks.dart';

@GenerateMocks([ApiCase])
void main() {
  ApiCase apiCase = MockApiCase();
  test('get all case return data', () async {
    when(apiCase.getCase()).thenAnswer((_) async => <CaseModel>[
          CaseModel(
              id: 1,
              title: 'nzxt',
              asin: 'xads22',
              link: 'http://abc.com',
              categories: [Category(name: Name.COMPUTER_CASES, id: 'sdsdsds')],
              image: 'sdsdsdsd',
              rating: 4.8,
              ratingsTotal: 121233,
              price: Price(
                  symbol: Symbol.EMPTY,
                  value: 22.00,
                  currency: Currency.USD,
                  raw: '22.00'))
        ]);
    var cases = await apiCase.getCase();
    expect(cases.isNotEmpty, true);
  });
}
