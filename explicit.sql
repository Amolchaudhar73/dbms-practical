DECLARE
CURSOR prod_cursor is select pid, pname, price from product;

v_id    product.pid%TYPE;
v_name  product.pname%TYPE;
v_price product.price%TYPE;
BEGIN
OPEN prod_cursor;
LOOP
FETCH prod_cursor into v_id, v_name, v_price;
EXIT when prod_cursor%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', Name: ' || v_name || ', Price: ' || v_price);
END LOOP;
CLOSE prod_cursor;
END;
/