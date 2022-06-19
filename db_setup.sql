CREATE DATABASE antonibook_db;
USE antonibook_db;

/* Create new user and set permissions */
CREATE USER dev@localhost IDENTIFIED BY 'password123';
GRANT ALL ON antonibook_db.* TO dev@localhost;
GRANT EXECUTE ON antonibook_db.* TO dev@localhost;
SET DEFAULT ROLE ALL TO dev@localhost;
SHOW GRANTS FOR dev@localhost;

/* Users table */
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT,
    email VARCHAR(128) UNIQUE NOT NULL,
    first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128) NOT NULL,
    active BOOL DEFAULT TRUE,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT,
    to_id INT NOT NULL,
    from_id INT NOT NULL,
    message TEXT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (to_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
        /* CASCADE keyword will update to_id value if users.id changes */
);

CREATE TABLE IF NOT EXISTS followings (
    follower INT NOT NULL,
    folowee INT NOT NULL,
    PRIMARY KEY (follower, folowee),
    FOREIGN KEY (follower) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
    FOREIGN KEY (folowee) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);