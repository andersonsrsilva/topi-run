/**
 *
 * @author rodrigo pereira - topi
 */
@isTest
private class CriteriaBuilderTemplateTest {

    @isTest
    static void givenRequestThenFillCriteria() {
        Map<String, String> request = new Map<String, String> {'a' => 'a1', 'b' => 'b1'};

        Test.startTest();

        CriteriaBuilderTemplateImpl builder = new CriteriaBuilderTemplateImpl(request);

        Test.stopTest();

        System.assert(builder.fieldsRepository != null);
        System.assert(builder.fieldsRepository.get('a').value == 'a1');
        System.assert(builder.fieldsRepository.get('b').value == 'b1');
        System.assert(builder.fieldsRepository.get('c').value == '');
    }

    @isTest
    static void givenQueryListMappingThenFillCriteria() {
        QueryMapping mapping = new QueryMapping('c');
        mapping.value = 'c1';
        QueryListMapping listMapping = new QueryListMapping('d');
        listMapping.setValues(new List<String> {'1', '2', '3'});

        Test.startTest();

        CriteriaBuilderTemplateImpl builder = new CriteriaBuilderTemplateImpl();
        builder.mapField('c', mapping)
        .mapField('d', listMapping);

        System.assert(builder.get('c').value == 'c1');
        System.assert(builder.getList('d').getValues().size() == 3);
        System.assert(builder.getList('d').getValues().get(0) == '1');
        System.assert(builder.getList('d').getValues().get(1) == '2');
        System.assert(builder.getList('d').getValues().get(2) == '3');

        builder.usingField('c', 'c2');
        builder.usingField('d', new List<String> {'4', '5'});

        System.assert(builder.get('c').value == 'c2');
        System.assert(builder.getList('d').getValues().size() == 2);
        System.assert(builder.getList('d').getValues().get(0) == '4');
        System.assert(builder.getList('d').getValues().get(1) == '5');

        builder.usingField('d', new Set<String> {'6', '7', '8', '9'});

        System.assert(builder.getList('d').getValues().size() == 4);
        System.assert(builder.getList('d').getValues().get(0) == '6');
        System.assert(builder.getList('d').getValues().get(1) == '7');
        System.assert(builder.getList('d').getValues().get(2) == '8');
        System.assert(builder.getList('d').getValues().get(3) == '9');

        Test.stopTest();

        System.assert(builder.fieldsRepository != null);
        System.assert(builder.fieldsRepository.get('a').value == '');
        System.assert(builder.fieldsRepository.get('b').value == '');
        System.assert(builder.fieldsRepository.get('c').value == 'c2');
        System.assert(builder.fieldsListRepository.get('d').getValues().size() == 4);
    }

    class CriteriaBuilderTemplateImpl extends CriteriaBuilderTemplate {

        public CriteriaBuilderTemplateImpl () {
            super();
        }

        public CriteriaBuilderTemplateImpl (Map<String, String> request) {
            super(request);
        }

        override
        public void loadFields() {
            this.fieldsRepository.put('a', new QueryMapping('a') );
            this.fieldsRepository.put('b', new QueryMapping('b') );
            this.fieldsRepository.put('c', new QueryMapping('c') );
        }

        override
        public List<SObject> search () {
            return new List<SObject>();
        }
    }

}