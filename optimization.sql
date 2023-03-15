-- Migration to optimize the searchability of an existing table by creating a table that joins by an id (int).
-- therefore is searchable by an id instead of name (string).

CREATE TABLE `new_table` (
`id` INT(11) unsigned NOT NULL AUTO_INCREMENT,
`name` varchar(255),
PRIMARY KEY (`id`)
);

-- POPULATES NEW TABLE WITH NAMES FROM table_one --

INSERT INTO new_table (name)
SELECT DISTINCT column FROM table_one;

-- CLEAN UP new_table ROWS --

DELETE FROM audit_reason 
WHERE name LIKE '%some name%';

-- DELETING ID COLUMN AND RE-ADDING IT TO AUTO INCREMENT  --

ALTER TABLE new_table
DROP COLUMN id;

ALTER TABLE new_table
ADD COLUMN id INT(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

-- RENAME COLUMN IN table_one --

ALTER TABLE table_one
RENAME COLUMN column to new_column;

-- UPDATES table_one COLUMN FROM NAME TO ID --

UPDATE table_one
JOIN new_table ON new_table.name = table_one.new_column
SET table_one.new_column = new_table.id
WHERE table_one.new_column = new_table.name;


-- UPDATES COLUMN DATA TYPE --

ALTER TABLE table_one
MODIFY COLUMN column INT(11); 
