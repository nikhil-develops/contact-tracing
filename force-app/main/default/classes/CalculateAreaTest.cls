@isTest
public class CalculateAreaTest {   
    @isTest
    public static void squareTest(){
        CalculateArea Area=new CalculateArea();
		System.assertEquals(225,Area.square(15),'Square is not correct');
        System.assertEquals(75,Area.rectangle(15,5),'rectangle is not correct');
        System.assertEquals(314,Area.circle(20),'rectangle is not correct');

    }
}