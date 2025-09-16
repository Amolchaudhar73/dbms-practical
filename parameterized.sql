DECLARE
CURSOR price_cursor(p_min_price NUMBER) is select pid, pname, price from product where price > p_min_price;

v_id    product.pid%TYPE;
v_name  product.pname%TYPE;
v_price product.price%TYPE;

BEGIN
OPEN price_cursor(10000);
LOOP
FETCH price_cursor INTO v_id, v_name, v_price;
EXIT WHEN price_cursor%NOTFOUND;

DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', Name: ' || v_name || ', Price: ' || v_price);
END LOOP;
CLOSE price_cursor;
END;
/