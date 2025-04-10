from datetime import datetime
from sqlalchemy import (
    create_engine, Column, Integer, String, Date, ForeignKey,
    Enum, Boolean, DECIMAL, Time, TIMESTAMP, JSON, UniqueConstraint, CheckConstraint, func
)
from sqlalchemy.dialects.postgresql import BYTEA
from sqlalchemy.orm import (
    DeclarativeBase, relationship, validates, Mapped, mapped_column
)
import enum

MAX_PHOTO_SIZE = 5 * 1024 * 1024  # 5MB

# Enums
class TeacherLessonStatus(enum.Enum):
    wait_approve = "wait_approve"
    approve = "approve"
    canceled_by_teacher = "canceled_by_teacher"
    canceled_by_student = "canceled_by_student"
    done = "done"

class StudentCategory(enum.Enum):
    preschooler = "preschooler"
    grade_1_4 = "grade_1-4"
    grade_5_8 = "grade_5-8"
    grade_9_12 = "grade_9-12"
    adult = "adult"

class TeacherWeekday(enum.Enum):
    mon = "mon"
    tue = "tue"
    wed = "wed"
    thu = "thu"
    fri = "fri"
    sat = "sat"
    sun = "sun"

# Base class
class Base(DeclarativeBase):
    pass

# Country
class Country(Base):
    __tablename__ = "country"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False)

    cities = relationship("City", back_populates="country")

# City
class City(Base):
    __tablename__ = "city"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    country_id: Mapped[int] = mapped_column(ForeignKey("country.id", ondelete="CASCADE"), nullable=False)

    country = relationship("Country", back_populates="cities")
    students = relationship("Student", back_populates="city")
    teachers = relationship("Teacher", back_populates="city")

# Student
class Student(Base):
    __tablename__ = "student"

    id: Mapped[int] = mapped_column(primary_key=True)
    first_name: Mapped[str] = mapped_column(String(255), nullable=False)
    last_name: Mapped[str] = mapped_column(String(255), nullable=False)
    email: Mapped[str] = mapped_column(String(255), nullable=False, unique=True)
    password: Mapped[str] = mapped_column(String(255), nullable=False)
    birthday: Mapped[Date] = mapped_column(nullable=True)
    photo: Mapped[bytes] = mapped_column(BYTEA, nullable=True)
    phone: Mapped[str] = mapped_column(String(50), nullable=True)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)
    city_id: Mapped[int] = mapped_column(ForeignKey("city.id", ondelete="SET NULL"), nullable=True)

    city = relationship("City", back_populates="students")

    @validates("photo")
    def validate_photo(self, key, value):
        if value and len(value) > MAX_PHOTO_SIZE:
            raise ValueError("Photo exceeds 5MB limit")
        return value

# Teacher
class Teacher(Base):
    __tablename__ = "teacher"

    id: Mapped[int] = mapped_column(primary_key=True)
    first_name: Mapped[str] = mapped_column(String(255), nullable=False)
    last_name: Mapped[str] = mapped_column(String(255), nullable=False)
    email: Mapped[str] = mapped_column(String(255), nullable=False, unique=True)
    password: Mapped[str] = mapped_column(String(255), nullable=False)
    birthday: Mapped[Date] = mapped_column(nullable=True)
    photo: Mapped[bytes] = mapped_column(BYTEA, nullable=True)
    phone: Mapped[str] = mapped_column(String(50), nullable=True)
    city_id: Mapped[int] = mapped_column(ForeignKey("city.id", ondelete="SET NULL"), nullable=True)
    bio: Mapped[str] = mapped_column(nullable=True)
    lesson_price: Mapped[float] = mapped_column(DECIMAL(10, 2), nullable=False)
    lesson_duration: Mapped[int] = mapped_column(nullable=False)  # in minutes
    hourly_price: Mapped[float] = mapped_column(DECIMAL(10, 2), nullable=False,
                                                  server_default="(lesson_price / lesson_duration * 60)")
    rating: Mapped[float] = mapped_column(DECIMAL(3, 2), nullable=False, default=0.00)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)
    is_verify: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)

    city = relationship("City", back_populates="teachers")

    @validates("photo")
    def validate_photo(self, key, value):
        if value and len(value) > MAX_PHOTO_SIZE:
            raise ValueError("Photo exceeds 5MB limit")
        return value

# Subject
class Subject(Base):
    __tablename__ = "subject"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)

# Lesson
class Lesson(Base):
    __tablename__ = "lesson"

    id: Mapped[int] = mapped_column(primary_key=True)
    student_id: Mapped[int] = mapped_column(ForeignKey("student.id", ondelete="CASCADE"), nullable=False)
    teacher_id: Mapped[int] = mapped_column(ForeignKey("teacher.id", ondelete="CASCADE"), nullable=False)
    start_time: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), nullable=False)
    status: Mapped[TeacherLessonStatus] = mapped_column(Enum(TeacherLessonStatus), nullable=False, default=TeacherLessonStatus.wait_approve)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)
    subject_id: Mapped[int] = mapped_column(ForeignKey("subject.id"), nullable=False)
    homework: Mapped[str] = mapped_column(nullable=True)

# Review
class Review(Base):
    __tablename__ = "review"

    id: Mapped[int] = mapped_column(primary_key=True)
    student_id: Mapped[int] = mapped_column(ForeignKey("student.id", ondelete="CASCADE"), nullable=False)
    teacher_id: Mapped[int] = mapped_column(ForeignKey("teacher.id", ondelete="CASCADE"), nullable=False)
    rating: Mapped[int] = mapped_column(Integer, CheckConstraint("rating >= 1 AND rating <= 5"), nullable=False)
    comment: Mapped[str] = mapped_column(nullable=True)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)

# Notification
class Notification(Base):
    __tablename__ = "notification"

    id: Mapped[int] = mapped_column(primary_key=True)
    student_id: Mapped[int] = mapped_column(ForeignKey("student.id", ondelete="CASCADE"), nullable=False)
    teacher_id: Mapped[int] = mapped_column(ForeignKey("teacher.id", ondelete="CASCADE"), nullable=False)
    message: Mapped[dict] = mapped_column(JSON, nullable=False)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)
    lesson_id: Mapped[int] = mapped_column(ForeignKey("lesson.id", ondelete="CASCADE"), nullable=False)

# Schedule
class Schedule(Base):
    __tablename__ = "schedule"

    id: Mapped[int] = mapped_column(primary_key=True)
    teacher_id: Mapped[int] = mapped_column(ForeignKey("teacher.id", ondelete="CASCADE"), nullable=False)
    weekday: Mapped[TeacherWeekday] = mapped_column(Enum(TeacherWeekday), nullable=False)
    start_time: Mapped[Time] = mapped_column(nullable=False)
    end_time: Mapped[Time] = mapped_column(nullable=False)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)

# Language
class Language(Base):
    __tablename__ = "language"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)

# TeacherLanguages
class TeacherLanguage(Base):
    __tablename__ = "teacher_languages"

    id: Mapped[int] = mapped_column(primary_key=True)
    teacher_id: Mapped[int] = mapped_column(ForeignKey("teacher.id", ondelete="CASCADE"), nullable=False)
    language_id: Mapped[int] = mapped_column(ForeignKey("language.id", ondelete="CASCADE"), nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)

    # Relationships (optional for easier access)
    teacher = relationship("Teacher", backref="languages")
    language = relationship("Language")

# Categories of Students
class CategoryOfStudent(Base):
    __tablename__ = "categories_of_students"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[StudentCategory] = mapped_column(Enum(StudentCategory), nullable=False)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)

# TeacherCategories
class TeacherCategory(Base):
    __tablename__ = "teacher_categories"

    id: Mapped[int] = mapped_column(primary_key=True)
    teacher_id: Mapped[int] = mapped_column(ForeignKey("teacher.id", ondelete="CASCADE"), nullable=False)
    category_id: Mapped[int] = mapped_column(ForeignKey("categories_of_students.id", ondelete="CASCADE"), nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)

    teacher = relationship("Teacher", backref="categories")
    category = relationship("CategoryOfStudent")

# TeacherSubjects
class TeacherSubject(Base):
    __tablename__ = "teacher_subjects"

    id: Mapped[int] = mapped_column(primary_key=True)
    teacher_id: Mapped[int] = mapped_column(ForeignKey("teacher.id", ondelete="CASCADE"), nullable=False)
    subject_id: Mapped[int] = mapped_column(ForeignKey("subject.id", ondelete="CASCADE"), nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    created_at: Mapped[datetime] = mapped_column(TIMESTAMP(timezone=True), default=func.now(), nullable=False)

    teacher = relationship("Teacher", backref="subjects")
    subject = relationship("Subject")

# Optional: Auto-update Teacher Rating (SQLAlchemy event version)
from sqlalchemy import event
from sqlalchemy.orm import Session

@event.listens_for(Review, "after_insert")
@event.listens_for(Review, "after_update")
@event.listens_for(Review, "after_delete")
def update_teacher_rating(mapper, connection, target):
    teacher_id = target.teacher_id
    stmt = (
        func.coalesce(func.avg(Review.rating), 0.0)
        .select()
        .where(Review.teacher_id == teacher_id)
    )

    avg_rating = connection.execute(stmt).scalar()
    connection.execute(
        Teacher.__table__.update()
        .where(Teacher.id == teacher_id)
        .values(rating=avg_rating)
    )

