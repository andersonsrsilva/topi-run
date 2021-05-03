/**
 * @author: Eduardo - @ercarval
 */
@isTest
private class CriteriaTest {


    @isTest
    public static  void searchForAccountWithRestrictions() {

        DateTime now = DateTime.now();
        DateTime yesterday = now - 1;

        String expextedNowDateTime = now.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'', 'GMT');
        String expextedYesterdayDateTime = yesterday.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'', 'GMT');


        Criteria criteria = new Criteria( 'Select Name from Account')
        .add( Restriction.eq( new QueryMapping('name' , 'value')  ) )
        .add( Restriction.eq('name' , 'Value') )
        .add( Restriction.eqOrLike('name' , '34234*') )
        .add( Restriction.eqOrLike('name' , '34234') )
        .add( Restriction.isIn('name' , new String[] {'34234*', 'Val2', 'val3'}) )
        .add( Restriction.isIn('name' , '(\'1\',\'2\')' ) )
        .add( Restriction.isLike('name' , 'valuelike%') )
        .add( Restriction.ge('val2' , 'valuelike') )
        .add( Restriction.le('val2' , 'valuelike') )
        .add( Restriction.lt('val2' , 'valuelike') )
        .add( Restriction.gt('val2' , 'valuelike') )
        .add( Restriction.isNotNull('val2' )  )
        .add( Restriction.isNull('val2' ) )
        .add( Restriction.isNull( new QueryMapping( 'val2' ) ) )
        .add( Restriction.notEq('val2' , 'valuelike') )
        .add( Restriction.between('val2' , 'value1', 'val2') )
        .add( Restriction.between('val2' , 'value1', '') )
        .add( Restriction.between('val2' , now , yesterday ) )
        .orderingBy('name desc')
        .limitedBy(1);

        String expectedQuery = 'Select Name from Account where name = \'value\' and name = \'Value\' and name like \'34234%\' and name = \'34234\' and name in ( \'34234*\',\'Val2\',\'val3\' ) and name in (\'1\',\'2\') and name like \'valuelike%\' and val2 >= \'valuelike\' and val2 <= \'valuelike\' and val2 < \'valuelike\' and val2 > \'valuelike\' and val2 != null  and val2 = null  and val2 = null  and val2 != \'valuelike\' and val2 >= \'value1\' and val2 <= \'val2\' and val2 = \'value1\' and val2 >= ' + expextedNowDateTime + ' and val2 <= ' + expextedYesterdayDateTime + ' order by name desc limit 1';

        System.debug (criteria.toSoqlString());

        System.assertEquals(  expectedQuery , criteria.toSoqlString() ) ;

    }

    @isTest
    static  void searchAccountUsingJunction() {

        Criteria c = new Criteria('Select Name from Account ')
        .add ( Restriction.disjunction()
               .add(Restriction.isIn ( 'Name',  new String[] {'34234*', 'Val2', 'val3'} ) )
               .add(Restriction.isNull ( 'Name' ) )
             )
        .add( Restriction.eq ( 'Nome', '80054880' ) )
        .add( Restriction.conjunction()
               .add(Restriction.isNotNull ( 'Name' ) )
             )
        .addOr ( Restriction.isNull ( 'Name' ) )
        .limitedBy(1);

        String expectedQuery = 'Select Name from Account  where (Name in ( \'34234*\',\'Val2\',\'val3\' ) or Name = null ) ';
        expectedQuery += 'and Nome = \'80054880\' and (Name != null ) or Name = null  limit 1';

        System.debug (c.toSoqlString());

        System.assertEquals( expectedQuery, c.toSoqlString() ) ;

        // List<Account> acconts = (List<Account>) c.search ();
    }

    @isTest
    static  void searchFromAccountUsingInnerCriteria() {

        Criteria criteria = new Criteria(  'Select id, Name From Account ')
        .add ( Restriction.isIn('id',
                                new Criteria ('select AccountId from Contact')
                                .add( Restriction.eq('AccountId', '1') )))
        .add ( Restriction.isIn('id',
                                new Criteria ('select AccountId from Opportunity')
                                .add( Restriction.eq('AccountId', '1') )))

        .limitedBy(1);
        
        String expected = 'Select id, Name From Account  where id in (select AccountId from Contact where AccountId = \'1\') and id in (select AccountId from Opportunity where AccountId = \'1\') limit 1';

        System.assertEquals ( expected , criteria.toSoqlString());
    }


    public class CriteBuilderTest extends CriteriaBuilderTemplate {


        public CriteBuilderTest() {
            super();
        }

        public CriteBuilderTest(Map<String, String> request) {
            super(request);
        }

        //prepare data;
        override
        public void loadFields() {

            fieldsRepository.put ( 'salesOffice' , new QueryJsonListMapping ('EscritorioVendaLkp__c') );
            fieldsRepository.put ( 'priceGroup'  , new QueryJsonListMapping ('GrupoPrecoLkp__c') );
            fieldsRepository.put ( 'hiveOfActivity' , new QueryJsonListMapping ('RamoAtividadeTxt__c') );
            fieldsRepository.put ( 'activitySector' , new QueryJsonListMapping ('SetorAtividadeLkp__c') );
            fieldsRepository.put ( 'monthsWithOutSales', new QueryMapping ('MeseSemComprarLkp__c') );
            fieldsRepository.put ( 'city'  , new QueryMapping ('CidadeLkp__c') );
            fieldsRepository.put ( 'state' , new QueryMapping ('UFTxt__c') );
            fieldsRepository.put ( 'billingAverage'  , new QueryMapping ('MediaFaturamento__c') );
            fieldsRepository.put ( 'reachedPercentage' , new QueryMapping ('PercentualAtingido__c') );
            fieldsRepository.put ( 'customer'      , new QueryMapping ('ContaLkp__c') );
            fieldsRepository.put ( 'productId', new QueryMapping ('id') );

        }

        override
        public List<SObject> search () {
            return null;
        }

    }

    @isTest
    public static void givenArrayInQueryWithNullValueSkipThis () {

        String[] values = new String[] {'1', null, '2'};
        String expectedValues = '( ' + Restriction.addStringInQuery('1') + ',' + Restriction.addStringInQuery('2') + ' )';

        String inElement = Restriction.convertArrayStringIntoInClause(values);

        System.assertEquals(expectedValues, inElement);

    }


    @isTest
    public static void givenSavedAccountWhenSearchReturnSomeRecords () {

        Account account  = AccountFixtureFactory.createAccount(Random.generateString(10, CharacterSet.ALPHA));

        List<Account> accounts =  ( List<Account> )  new Criteria('Select Id, Name FROM Account')
            .add(Restriction.eq('Id', account.Id))
            .search();

        System.assertEquals(1, accounts.size());
        
        Account storedAccount =  ( Account ) new Criteria('Select Id, Name FROM Account')
                .add(Restriction.eq('Id', account.Id))
                .searchFirstResult();
        
        System.assertEquals(account.Id, storedAccount.Id);
        
    }


}