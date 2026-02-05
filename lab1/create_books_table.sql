-- Lab 1: Books Read Tracker
-- Author: [Mohid]
-- Date: [05/02/2026]

CREATE TABLE IF NOT EXISTS books_read (
book_id SERIAL PRIMARY KEY,
title VARCHAR(200) NOT NULL,
author VARCHAR(100) NOT NULL,
category VARCHAR(50),
pages INTEGER CHECK (pages > 0),
date_finished DATE,
rating DECIMAL(3,1) CHECK (rating >= 0 AND rating <= 5.0),
notes TEXT
);

INSERT INTO books_read
(title, author, category, pages, date_finished, rating, notes)
VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 218, '2023-08-15', 4.5, 'Loved the writing style.'),
('1984', 'George Orwell', 'Dystopian', 328, '2023-09-10', 4.8, 'Very thought-provoking.'),
('To Kill a Mockingbird', 'Harper Lee', 'Classic', 281, '2023-10-05', 5.0, 'A timeless story about justice.'),
('Atomic Habits', 'James Clear', 'Self-help', 320, '2023-12-01', 4.7, 'Practical and easy to implement tips.');

