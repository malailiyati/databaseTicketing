-- login
select id, email, password, role from users
where email = 'user1@gmail.com' and password = 'Password!';

-- register
insert into users(email, password, role, created_at, update_at) values
values ('admin2@gmail.com', 'Password3!', 'admin', current_timestamp, current_timestamp);

-- get upcoming movie
select m.id, m.title, m.poster,m.releaseDate, string_agg(g.name, ',') as genres from movies m
left join movie_genre mg on mg.movie_id = m.id
left join genres g on g.id = mg.genre_id
where m.releaseDate > current_date
group by m.id
order by m.releaseDate asc, m.id;

-- get popular movie
select id, title, poster, popularity from movies
order by popularity desc;

-- get movie with pagination
select m.id, m.title, m.poster, string_agg(g.name, ',') as genres from movies m
left join movie_genre mg on mg.movie_id = m.id
left join genres g on g.id = mg.genre_id
group by m.id
order by m.title asc
limit 20 offset 0;

-- fillter movie by name and genre with pagination
select distinct m.id, m.title, m.poster, string_agg(g.name, ',') as genres from movies m
left join movie_genre mg on mg.movie_id = m.id
left join genres g on g.id = mg.genre_id
where m.title ilike '%title%' and g.name ilike '%genre%'
group by m.id
limit 20 offset 20;

-- get schedule
select s.id, s.movie_id, s.date, t.time, l.location, c.name, c.price from schedule s
join time t on t.id = s.time_id
join location l on l.id = s.location_id
join cinema c on c.id = s.cinema_id
inner join movies mv on mv.id = s.movie_id
 where mv.id = 2;

-- get seat sold
select se.seat_number from order_seat os
join orders o on o.id = os.order_id
join seats se on se.id = os.seat_id
where os.order_id = 1;


-- get movie detail
select m.id, m.title, m.poster, m.background_poster, m.releaseDate, m.duration, m.synopsis,d.name as director,
string_agg(distinct g.name, ', ') as genres,
string_agg(distinct c.name, ', ') as casts
from movies m
left join director d on d.id = m.director_id
left join movie_genre mg on mg.movie_id = m.id
left join genres g on g.id = mg.genre_id
left join movie_cast mc on mc.movie_id = m.id
left join casts c on c.id = mc.cast_id
where m.id = 1
group by m.id, m.title, m.poster, m.background_poster, m.releaseDate, m.duration, m.synopsis, d.name;

-- create order
insert into orders (users_id, schedule_id, payment_id, totalPrice, fullName, email, phone, isPaid, qr_code, created_at, updated_at)
values (1, 1, 1, 70000, 'Alya Putri', 'user1@example.com', '081234567890', TRUE, 'QR-1111', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
insert into order_seat (order_id, seat_id) VALUES (1, 1), (1, 2);

-- get profile
select u.id as user_id, u.email, u.role, p.firstName, p.lastName, p.phone, p.created_at, p.updated_at from users u
left join profile p on p.users_id = u.id
where u.id = 1;

-- get history
select o.id as order_id, o.created_at, o.isPaid, o.totalPrice,m.title,s.date, t.time,c.name, c.price,array_agg(se.seat_number order by se.seat_number) as seats from orders o
join schedule s on s.id = o.schedule_id
join time t on t.id = s.time_id
join cinema c on c.id = s.cinema_id
join movies m on m.id = s.movie_id
left join order_seat os on os.order_id = o.id
left join seats se on se.id = os.seat_id
where o.users_id = 1
group by o.id, m.title, s.date, t.time, c.name, c.price;

-- edit profile
update profile
set firstName = coalesce('Ayu', firstName),
lastName = coalesce(null, lastName),
phone = coalesce(null, phone),
updated_at = current_timestamp
where users_id = 1;

-- get all movie
select  m.id, m.title, m.poster, m.releaseDate, m.created_at from movies m
join users u on u.id = 3  --id user yang sedang login
where u.role = 'admin'
order by created_at desc;

-- delate movie
delete from movie_genre where movie_id = 6;
delate from movie_cast where movie_id = 6;
delete from movies m
using users u
where m.id = 6 and u.id = 2 --id user yang sedang login
and u.role = 'admin';

-- edit movies
update movies m
set title = coalesce(null, m.title),
director_id = coalesce(null, m.director_id),
poster = coalesce('reruntuhan.jpg', poster),
background_poster = coalesce('bg_reruntuhan.jpg', m.background_poster),
releaseDate = coalesce(null, m.releaseDate),
duration = coalesce(null, m.duration),
synopsis = coalesce(null, m.synopsis),
updated_at = current_timestamp
from users u
where m.id = 6 and u.id = 3 and u.role = 'admin';


