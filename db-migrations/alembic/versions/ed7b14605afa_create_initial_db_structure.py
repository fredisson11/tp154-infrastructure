"""create initial db structure

Revision ID: ed7b14605afa
Revises: 
Create Date: 2025-04-10 10:36:46.137051

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'ed7b14605afa'
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    op.execute("""
    -- Створення типів ENUM
    CREATE TYPE teacher_lesson_status AS ENUM (
        'wait_approve',
        'approve',
        'canceled_by_teacher',
        'canceled_by_student',
        'done'
    );

    CREATE TYPE student_category AS ENUM (
        'preschooler',
        'grade_1-4',
        'grade_5-8',
        'grade_9-12',
        'adult'
    );

    -- Створення типу ENUM для днів тижня
    CREATE TYPE teacher_weekday AS ENUM (
        'mon',
        'tue',
        'wed',
        'thu',
        'fri',
        'sat',
        'sun'
    );

    -- Створення таблиці країни
    CREATE TABLE country (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL
    );

    -- Створення таблиці міста
    CREATE TABLE city (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        country_id INT NOT NULL REFERENCES country(id) ON DELETE CASCADE
    );

    -- Створення таблиці студентів
    CREATE TABLE student (
        id SERIAL PRIMARY KEY,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        birthday DATE,
        photo BYTEA,
        phone VARCHAR(50),
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        city_id INT NOT NULL REFERENCES city(id) ON DELETE SET NULL
    );

    -- Створення таблиці вчителів
    CREATE TABLE teacher (
        id SERIAL PRIMARY KEY,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        birthday DATE,
        photo BYTEA,
        phone VARCHAR(50),
        city_id INT NOT NULL REFERENCES city(id) ON DELETE SET NULL,
        bio TEXT,
        lesson_price DECIMAL(10, 2) NOT NULL,
        lesson_duration INT NOT NULL,
        hourly_price DECIMAL(10, 2) GENERATED ALWAYS AS (lesson_price / lesson_duration * 60) STORED,
        rating DECIMAL(3, 2) GENERATED ALWAYS AS (0) STORED,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        is_verify BOOLEAN NOT NULL DEFAULT FALSE
    );

    -- Створення таблиці предметів
    CREATE TABLE subject (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Створення таблиці уроків
    CREATE TABLE lesson (
        id SERIAL PRIMARY KEY,
        student_id INT NOT NULL REFERENCES student(id) ON DELETE CASCADE,
        teacher_id INT NOT NULL REFERENCES teacher(id) ON DELETE CASCADE,
        start_time TIMESTAMPTZ NOT NULL,
        status teacher_lesson_status DEFAULT 'wait_approve'::teacher_lesson_status NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        subject_id INT NOT NULL,
        homework TEXT
    );

    -- Створення таблиці відгуків
    CREATE TABLE review (
        id SERIAL PRIMARY KEY,
        student_id INT NOT NULL REFERENCES student(id) ON DELETE CASCADE,
        teacher_id INT NOT NULL REFERENCES teacher(id) ON DELETE CASCADE,
        rating INT CHECK (rating >= 1 AND rating <= 5) NOT NULL,
        comment TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Створення таблиці сповіщень
    CREATE TABLE notification (
        id SERIAL PRIMARY KEY,
        student_id INT NOT NULL REFERENCES student(id) ON DELETE CASCADE,
        teacher_id INT NOT NULL REFERENCES teacher(id) ON DELETE CASCADE,
        message JSONB NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        lesson_id INT NOT NULL REFERENCES lesson(id) ON DELETE CASCADE
    );

    -- Створення таблиці розкладу
    CREATE TABLE schedule (
        id SERIAL PRIMARY KEY,
        teacher_id INT NOT NULL REFERENCES teacher(id) ON DELETE CASCADE,
        weekday teacher_weekday NOT NULL,
        start_time TIME NOT NULL,
        end_time TIME NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Створення таблиці мов
    CREATE TABLE language (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Створення таблиці зв'язку вчителів та мов
    CREATE TABLE teacher_languages (
        id SERIAL PRIMARY KEY,
        teacher_id INT NOT NULL REFERENCES teacher(id) ON DELETE CASCADE,
        language_id INT NOT NULL REFERENCES language(id) ON DELETE CASCADE,
        is_active BOOLEAN NOT NULL DEFAULT TRUE,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Створення таблиці категорій студентів
    CREATE TABLE categories_of_students (
        id SERIAL PRIMARY KEY,
        name student_category NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Створення таблиці зв'язку вчителів та категорій студентів
    CREATE TABLE teacher_categories (
        id SERIAL PRIMARY KEY,
        teacher_id INT NOT NULL REFERENCES teacher(id) ON DELETE CASCADE,
        category_id INT NOT NULL REFERENCES categories_of_students(id) ON DELETE CASCADE,
        is_active BOOLEAN NOT NULL DEFAULT TRUE,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Створення таблиці зв'язку вчителів та предметів
    CREATE TABLE teacher_subjects (
        id SERIAL PRIMARY KEY,
        teacher_id INT NOT NULL REFERENCES teacher(id) ON DELETE CASCADE,
        subject_id INT NOT NULL REFERENCES subject(id) ON DELETE CASCADE,
        is_active BOOLEAN NOT NULL DEFAULT TRUE,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Індекси для фільтрації
    CREATE INDEX idx_teacher_city ON teacher(city_id);
    CREATE INDEX idx_teacher_is_verify ON teacher(is_verify);
    CREATE INDEX idx_teacher_lesson_price ON teacher(lesson_price);
    CREATE INDEX idx_teacher_rating ON teacher(rating);
    CREATE INDEX idx_teacher_language ON teacher_languages(language_id);
    CREATE INDEX idx_teacher_category ON teacher_categories(category_id);

    CREATE INDEX idx_student_city ON student(city_id);
    CREATE INDEX idx_student_email ON student(email);

    CREATE INDEX idx_lesson_status ON lesson(status);
    CREATE INDEX idx_lesson_teacher ON lesson(teacher_id);
    CREATE INDEX idx_lesson_student ON lesson(student_id);
    CREATE INDEX idx_lesson_subject ON lesson(subject_id);

    CREATE INDEX idx_review_teacher ON review(teacher_id);
    CREATE INDEX idx_review_student ON review(student_id);

    -- Додавання тригера для автоматичного оновлення рейтингу вчителя
    CREATE OR REPLACE FUNCTION update_teacher_rating() RETURNS TRIGGER AS $$
    BEGIN
        UPDATE teacher
        SET rating = (SELECT AVG(rating) FROM review WHERE teacher_id = NEW.teacher_id)
        WHERE id = NEW.teacher_id;
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER trigger_update_teacher_rating
    AFTER INSERT OR UPDATE OR DELETE ON review
    FOR EACH ROW EXECUTE FUNCTION update_teacher_rating();
    """)


def downgrade() -> None:
    """Downgrade schema."""
    op.execute("""
    -- Видалення тригера та функції оновлення рейтингу
    DROP TRIGGER IF EXISTS trigger_update_teacher_rating ON review;
    DROP FUNCTION IF EXISTS update_teacher_rating;

    -- Видалення індексів
    DROP INDEX IF EXISTS idx_review_student;
    DROP INDEX IF EXISTS idx_review_teacher;
    DROP INDEX IF EXISTS idx_lesson_subject;
    DROP INDEX IF EXISTS idx_lesson_student;
    DROP INDEX IF EXISTS idx_lesson_teacher;
    DROP INDEX IF EXISTS idx_lesson_status;
    DROP INDEX IF EXISTS idx_student_email;
    DROP INDEX IF EXISTS idx_student_city;
    DROP INDEX IF EXISTS idx_teacher_category;
    DROP INDEX IF EXISTS idx_teacher_language;
    DROP INDEX IF EXISTS idx_teacher_rating;
    DROP INDEX IF EXISTS idx_teacher_lesson_price;
    DROP INDEX IF EXISTS idx_teacher_is_verify;
    DROP INDEX IF EXISTS idx_teacher_city;

    -- Видалення таблиць зв'язку
    DROP TABLE IF EXISTS teacher_subjects;
    DROP TABLE IF EXISTS teacher_categories;
    DROP TABLE IF EXISTS categories_of_students;
    DROP TABLE IF EXISTS teacher_languages;
    DROP TABLE IF EXISTS language;
    DROP TABLE IF EXISTS schedule;
    DROP TABLE IF EXISTS notification;
    DROP TABLE IF EXISTS review;
    DROP TABLE IF EXISTS lesson;
    DROP TABLE IF EXISTS subject;
    DROP TABLE IF EXISTS teacher;
    DROP TABLE IF EXISTS student;
    DROP TABLE IF EXISTS city;
    DROP TABLE IF EXISTS country;

    -- Видалення ENUM типів
    DROP TYPE IF EXISTS teacher_weekday;
    DROP TYPE IF EXISTS student_category;
    DROP TYPE IF EXISTS teacher_lesson_status;
    """)
