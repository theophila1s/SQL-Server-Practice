use Theatre;

CREATE TABLE ShowSeat (
    show_seat_id INT IDENTITY(1,1) PRIMARY KEY,
    show_id INT,
    seat_id INT,
    is_available BIT,
    FOREIGN KEY (show_id) REFERENCES Show(show_id),
    FOREIGN KEY (seat_id) REFERENCES SEAT(seat_id)
);

select * from ShowSeat;

INSERT INTO ShowSeat (show_id, seat_id, is_available)
VALUES 
(3, 10, 1), 
(4, 10, 1),
(5, 11, 1),
(7, 14, 0), 
(3, 15, 1);


UPDATE ShowSeat
SET is_available = 0
WHERE show_seat_id = 10;

DELETE FROM ShowSeat
WHERE show_seat_id = 9;

SELECT * FROM ShowSeat
ORDER BY show_seat_id
OFFSET 2 ROWS
FETCH NEXT 2 ROWS ONLY;


