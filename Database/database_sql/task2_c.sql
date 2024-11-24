CREATE OR REPLACE FUNCTION check_cashback (c_orderid IN INTEGER)
RETURN VARCHAR2
AS
  /*variable to store the order cost*/
  order_cost NUMBER(10,2);
  
 /*store the threshold for cashback*/
  cashback_threshold NUMBER(10,2) := 5; 
  
  /*store the threshold for delivery charges*/
  delivery_threshold NUMBER(10,2) := 1; 
BEGIN
  /*retrieve the total cost of the order by summing the prices of all the fillings, bread and delivery cost*/
  SELECT SUM(fill.gramprice * s_fill.quantity + br.loafprice) INTO order_cost
  FROM Ordertab ord
  JOIN Sandwichfilling s_fill ON ord.sandwichid = s_fill.sandwichid
  JOIN Filling fill ON s_fill.fillingid = fill.fillingid
  JOIN Bread br ON ord.breadid = br.breadid
  WHERE ord.orderid = c_orderid;


 /*check if the order cost is greater than the cashback threshold*/
  IF order_cost > cashback_threshold THEN
    RETURN 'Order qualifies for cashback and delivery charges';
  /*check if the order cost is greater than the delivery threshold*/
  ELSIF order_cost > delivery_threshold THEN
    RETURN 'Order qualifies for delivery charge';
     ELSE
    /*return 'Order does not qualify for cashback or delivery charges'*/
    RETURN 'Order does not qualify for cashback';
    END IF;

END;
/
