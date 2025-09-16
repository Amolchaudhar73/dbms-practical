BEGIN
for rec IN (select pid, price from product where price < 5000)
LOOP
update product
SET price = rec.price * 1.10 where pid = rec.pid;
END LOOP;

commit;
DBMS_OUTPUT.PUT_LINE('Prices updated.');
END;
/