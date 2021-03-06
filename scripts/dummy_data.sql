/* Use $$ as delimiter as procedure must be passed to server as single stmt */
DELIMITER $$

/* SeedUsers procedure -> Add dummy users to users table */
CREATE PROCEDURE SeedUsers(IN num_users INT)
BEGIN
    DECLARE next_id INT; /* store next user's id */
    DECLARE i INT DEFAULT 0;

    IF (SELECT COUNT(id) FROM users) = 0 THEN
        SET next_id = 1;
    ELSE
        SET next_id = (SELECT MAX(id) FROM users) + 1;
    END IF;

    insert_user_loop: LOOP

        IF i = num_users THEN
            LEAVE insert_user_loop;
        END IF;

        /* insert Antonio User_i into table */
        INSERT INTO users(first_name, last_name, email)
            VALUES('Antonio',
                    CONCAT('User_', next_id),
                    CONCAT('antonio.user_', next_id, '@antonibook.com'));
        
        SET i = i + 1;
        SET next_id = next_id + 1;
    
    END LOOP;
END $$

/* FindUserIDs -> Return two randomdly selected IDs from users table */
CREATE PROCEDURE FindUserIDs(OUT first_user INT, OUT second_user INT)
BEGIN
    /* find highest id value in users table */
    DECLARE max_id INT;
    SET max_id = (SELECT MAX(id) FROM users);

    /* set first and second user to random int between 1 and max_id */
    SET first_user = FLOOR(RAND() * (max_id) + (1));
    SET second_user = FLOOR(RAND() * (max_id) + (1));

    /* generate new second_user if IDs are the same */
    WHILE first_user = second_user DO
        SET second_user = FLOOR(RAND() * (max_id) + (1));
    END WHILE;
END $$

/* SeedNetwork -> Create relations between users and insert into network table */
CREATE PROCEDURE SeedNetwork(IN num_relations INT)
BEGIN
    DECLARE first_user INT;
    DECLARE second_user INT;
    DECLARE i INT DEFAULT 0;

    outer_while: WHILE i < num_relations DO
        REPEAT
            CALL FindUserIDs(first_user, second_user);
            /* ensure user ids exist, re-call FindUserIDs if not */
            inner_while: WHILE((SELECT COUNT(id) FROM users WHERE id=first_user) = 0 OR
                               (SELECT COUNT(id) FROM users WHERE id=second_user) = 0)
                               DO
                                CALL FindUserIDs(first_user, second_user);
            END WHILE inner_while;
        /* repeat until new network relation is unique */
        UNTIL ((SELECT COUNT(*) FROM network 
                WHERE follower=first_user AND followee=second_user) = 0)
        END REPEAT;

        INSERT INTO network(follower, followee) VALUES(first_user, second_user);

        SET i = i + 1;

        SELECT first_user, second_user;

    END WHILE outer_while;
END $$

DELIMITER ;