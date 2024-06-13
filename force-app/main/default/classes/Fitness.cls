public class Fitness {
    @InvocableMethod
public static void annotationDemo(){
        System.debug('This is annotation Demo');
    }    
    public decimal calculateBMI(Decimal Weight,Decimal Height){
        Decimal bmi= (Weight*10000)/(Height*Height);
            return bmi;
    }
    public decimal calculatePace(Decimal Meters,Integer Minutes){
        
        Decimal Speed = (Meters*60)/(1000 * Minutes);
            return Speed;
    }
}