public class UnifiedListGenerator {
   
    public class UnifiedListItem {
        public String bom_pn { get; set; }
        public Decimal bom_qty { get; set; }
        public String disti_pn { get; set; }
        public Decimal disti_qty { get; set; }
        public Boolean errorFlag { get; set; }
        
        public UnifiedListItem(String bom_pn, Decimal bom_qty, String disti_pn, Decimal disti_qty, Boolean errorFlag) {
            this.bom_pn = bom_pn;
            this.bom_qty = bom_qty;
            this.disti_pn = disti_pn;
            this.disti_qty = disti_qty;
            this.errorFlag = errorFlag;
        }
    }
    
     public class bom_Item {
        public String bom_pn { get; set; }
        public Decimal bom_qty { get; set; }
       
        
        public bom_Item(String bom_pn, Decimal bom_qty ) {
            this.bom_pn = bom_pn;
            this.bom_qty = bom_qty;
        }
    }
    
     public class disti_Item {
        public String disti_pn { get; set; }
        public Decimal disti_qty { get; set; }
        
        public disti_Item(String disti_pn, Decimal disti_qty) {
            this.disti_pn = disti_pn;
            this.disti_qty = disti_qty;
        }
    }
    
    
    public static List<UnifiedListItem> prepareUnifiedList(List<bom_Item> BoM, List<disti_Item> disti) {
        List<UnifiedListItem> unifiedList = new List<UnifiedListItem>();
        Map<String,Decimal> distiMap = new Map<String,Decimal>();
        Map<String,Decimal> distiMapQuantityLeft = new Map<String,Decimal>();
        for(disti_Item distiItem : disti){
            distiMap.put(distiItem.disti_pn,distiItem.disti_qty);
            distiMapQuantityLeft.put(distiItem.disti_pn,distiItem.disti_qty);
        }
        //system.debug('distiMap ==> '+distiMap);
        
        for (bom_Item bomItem : BoM) {
              Boolean errorFlag = false;
              Decimal bom_qty = bomItem.bom_qty;
              Decimal disti_qty ;
              if (distiMap.containsKey(bomItem.bom_pn)) {
                  disti_qty = Math.min(bomItem.bom_qty, distiMapQuantityLeft.get(bomItem.bom_pn));
                  distiMapQuantityLeft.put(bomItem.bom_pn , distiMapQuantityLeft.get(bomItem.bom_pn) - disti_qty) ;
                  errorFlag = disti_qty < bomItem.bom_qty ?  true : false;
                  unifiedList.add(new UnifiedListItem(bomItem.bom_pn, bomItem.bom_qty, bomItem.bom_pn , disti_qty, errorFlag));
              }
            else{
                 errorFlag = true;
                 unifiedList.add(new UnifiedListItem(bomItem.bom_pn, bomItem.bom_qty, '' , null , errorFlag));
                }
            
           
            
        }
        
        //system.debug('distiMapQuantityLeft ==> '+distiMapQuantityLeft);
     
        
        for (String disti_pn : distiMapQuantityLeft.keySet()) {
            if (distiMapQuantityLeft.get(disti_pn) > 0 ) {
                 unifiedList.add(new UnifiedListItem(null , null , disti_pn, distiMapQuantityLeft.get(disti_pn), true));
            }
        }
        
        return unifiedList;
    }
}