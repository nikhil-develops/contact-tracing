public class CalculateArea {
Final decimal PII=3.14;
   public decimal circle(decimal diameter){
        double radius=diameter/2;
       double area= PII * (Math.pow(radius,2));
       
       return (Decimal.valueOf(area)).setScale(2);
    }
    public decimal square(decimal side){
       decimal area= side*side;
       
       return area;
    }
    public decimal Rectangle(decimal length , decimal breadth){
       decimal area= length*breadth;
       
       return area;
    }
}