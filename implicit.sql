BEGIN
insert into product (pid, pname, price) values (3, 'tablet', 18000.00);

DBMS_OUTPUT.PUT_LINE('Rows inserted: ' || SQL%ROWCOUNT);
END;
/