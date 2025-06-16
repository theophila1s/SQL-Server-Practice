use  Theatre;

create table Review (
review_id int identity primary key,
movie_id int,
content text,
review_date datetime,
reviewer_name varchar(100),
foreign key (movie_id) references Movie(movie_id)
);

select * from Review;

Insert into Review (movie_id, content, review_date, reviewer_name) values
(1, 'Amazing visuals and concept!', GETDATE(), 'John Doe'),
(2, 'A timeless love story.', GETDATE(), 'Jane Smith'),
(3, 'Superb action scenes!', GETDATE(), 'Alex Ray'),
(1, 'Mind-blowing plot twist.', GETDATE(), 'Chris Adams'),
(4, 'Dark but powerful performance.', GETDATE(), 'Emma Clark');


update Review set content = 'A visually stunning sci-fi masterpiece.'
where reviewer_name = 'John Doe';


SELECT * FROM Review
ORDER BY review_id
OFFSET 2 ROWS
FETCH NEXT 2 ROWS ONLY;
