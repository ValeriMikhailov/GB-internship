DELETE FROM person_page_rank;
DELETE FROM keywords;
DELETE FROM pages;
DELETE FROM persons;
DELETE FROM sites;
DELETE FROM users;
DELETE FROM user_roles;

INSERT INTO persons
VALUES(null,'Путин');
INSERT INTO persons
VALUES(null,'Медведев');

INSERT INTO sites
VALUES(null, 'somewhere1.com');
INSERT INTO sites
VALUES(null, 'somewhere2.com');

INSERT INTO keywords
VALUES
  (null, 'Путина', (select id from persons where persons.name = 'Путин'));

INSERT INTO keywords
VALUES
  (null, 'Путинy', (select id from persons where persons.name = 'Путин'));

INSERT INTO keywords
VALUES
  (null, 'Путиным', (select id from persons where persons.name = 'Путин'));

INSERT INTO keywords
VALUES
  (null, 'Путине',( select id from persons where persons.name = 'Путин'));

INSERT INTO keywords
VALUES
  (null, 'Медведева', (select id from persons where persons.name = 'Медведев'));

INSERT INTO keywords
VALUES
  (null, 'Медведеву', (select id from persons where persons.name = 'Медведев'));

INSERT INTO keywords
VALUES
  (null, 'Медведевым', (select id from persons where persons.name = 'Медведев'));

INSERT INTO keywords
VALUES
  (null, 'Медведеве', (select id from persons where persons.name = 'Медведев'));

INSERT INTO pages
VALUES
  (null, 'somewhere1/index','2017-03-10 11:00:00', '2017-03-10 11:05:00', (select id from sites where sites.name = 'somewhere1.com'));

INSERT INTO pages
VALUES
  (null, 'somewhere1/page1','2017-03-10 11:10:00', '2017-03-10 11:55:00', (select id from sites where sites.name = 'somewhere1.com'));

INSERT INTO pages
VALUES
  (null, 'somewhere2/index','2017-03-10 11:15:00', '2017-03-10 11:35:00', (select id from sites where sites.name = 'somewhere2.com'));

INSERT INTO pages
VALUES
  (null, 'somewhere2/page1','2017-03-10 11:25:00', '2017-03-10 11:45:00', (select id from sites where sites.name = 'somewhere2.com'));

INSERT INTO person_page_rank
VALUES((select id from persons where persons.name = 'Путин'), 1,2);
INSERT INTO person_page_rank
VALUES((select id from persons where persons.name = 'Путин'), 2,2);
INSERT INTO person_page_rank
VALUES((select id from persons where persons.name = 'Путин'), 3,3);
INSERT INTO person_page_rank
VALUES((select id from persons where persons.name = 'Путин'), 4,4);

INSERT INTO person_page_rank
VALUES((select id from persons where persons.name = 'Медведев'), 1,0);
INSERT INTO person_page_rank
VALUES((select id from persons where persons.name = 'Медведев'), 2,5);
INSERT INTO person_page_rank
VALUES((select id from persons where persons.name = 'Медведев'), 3,0);
INSERT INTO person_page_rank
VALUES((select id from persons where persons.name = 'Медведев'), 4,6);

INSERT INTO users(username,password)
VALUES ('admin@gmail.com','$2a$10$ItXzlyjMf3M6vYhaiNht2OKd9ATASrH8igKA5uVehVK7xucszJYC2');
INSERT INTO users(username,password)
VALUES ('user@gmail.com','$2a$10$08zBGWx0HshM0kIfGNwKtuCitB8PpEZOW5nJEz80O1FcsQlR.WmzC');

INSERT INTO user_roles (username, role)
VALUES ('admin@gmail.com', 'ROLE_USER');
INSERT INTO user_roles (username, role)
VALUES ('admin@gmail.com', 'ROLE_ADMIN');
INSERT INTO user_roles (username, role)
VALUES ('user@gmail.com', 'ROLE_USER');