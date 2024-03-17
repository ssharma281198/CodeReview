@IsTest
public class UnifiedListGeneratorTest {
    
    @IsTest
    public static void testprepareUnifiedList() {

        List<UnifiedListGenerator.bom_Item> BoM = new List<UnifiedListGenerator.bom_Item>();
        BoM.add(new UnifiedListGenerator.bom_Item('ABC',2));
        BoM.add(new UnifiedListGenerator.bom_Item('XYZ',1));
        BoM.add(new UnifiedListGenerator.bom_Item('IJK',1));
        BoM.add(new UnifiedListGenerator.bom_Item('ABC',1));
        BoM.add(new UnifiedListGenerator.bom_Item('IJK',1));
        BoM.add(new UnifiedListGenerator.bom_Item('XYZ',2));
        BoM.add(new UnifiedListGenerator.bom_Item('DEF',2));
        
        //system.debug('BoM ==> '+BoM);
                
        List<UnifiedListGenerator.disti_Item> disti = new List<UnifiedListGenerator.disti_Item>();
        disti.add(new UnifiedListGenerator.disti_Item('XYZ',2));
        disti.add(new UnifiedListGenerator.disti_Item('GEF',2));
        disti.add(new UnifiedListGenerator.disti_Item('ABC',4));
        disti.add(new UnifiedListGenerator.disti_Item('IJK',2));
        
        //system.debug('disti ==> '+disti);
        
        
        List<UnifiedListGenerator.UnifiedListItem> unifiedList = UnifiedListGenerator.prepareUnifiedList(BoM, disti);
        
        System.debug('Unified List');
        System.debug('BoM PN\tBoM Qty\tDisti PN\tDisti Qty\tError Flag');
        for (UnifiedListGenerator.UnifiedListItem item : unifiedList) {
            System.debug(item.bom_pn + '\t' + item.bom_qty + '\t' + item.disti_pn + '\t' + item.disti_qty + '\t' + item.errorFlag);
        }
    }   
}