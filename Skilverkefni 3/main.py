from mysql.connector import MySQLConnection
from mysql.connector import Error
from config import *

class DbConnector:
    def __init__(self):
        self.status = ' '
        try:
            self.conn = MySQLConnection(user=USER,
										password=PASSWORD,
										host=HOST,
										database=DB,
										auth_plugin=AUTH)
            if self.conn.is_connected():
                self.status = 'connected'
            else:
                self.status = 'connection failed.'
        except Error as error:
            self.status = error

    def execute_function(self, func_header=None, argument_list=None):
        cursor = self.conn.cursor()
        try:
            if argument_list:
                func = func_header % argument_list
            else:
                func = func_header
            cursor.execute(func)
            result = cursor.fetchone()
        except Error as e:
            self.status = e
            result = None
        finally:
            cursor.close()
        return result[0]

    def execute_procedure(self, proc_name, argument_list=None):
        result_list = list()
        cursor = self.conn.cursor()
        try:
            if argument_list:
                cursor.callproc(proc_name, argument_list)
            else:
                cursor.callproc(proc_name)
            self.conn.commit()
            for result in cursor.stored_results():
                result_list = [list(elem) for elem in result.fetchall()]
        except Error as e:
            self.status = e
        finally:
            cursor.close()
        return result_list


class StudentDB(DbConnector):
    def __init__(self):
        DbConnector.__init__(self)

    def new_student(self, first_name, last_name, date_of_birth, starting_on):
        new_id = 0
        result = self.execute_procedure('NewStudent', [first_name, last_name, date_of_birth, starting_on])
        if result:
            new_id = int(result[0][0])
        return new_id

    def single_student(self, student_id):
        result = self.execute_procedure('SingleStudent', [student_id])
        if result:
            return result[0]
        else:
            return list()

    def list_student(self):
        result = self.execute_procedure('StudentList')
        if result:
            return result[0]
        else:
            return list()

    def update_student(self, student_id, first_name, last_name, date_of_birth, starting_on):
        rows_affected = 0
        result = self.execute_procedure('UpdateStudent', [student_id, first_name, last_name, date_of_birth, starting_on])
        if result:
            rows_affected = int(result[0][0])
        return rows_affected

    def delete_student(self, student_id):
        rows_affected = 0
        result = self.execute_procedure('DeleteStudents', [student_id])
        if result:
            rows_affected = int(result[0][0])
        return rows_affected
				

class SchoolDB(DbConnector):
    def __init__(self):
        DbConnector.__init__(self)

    def new_school(self, school_name):
        new_id = 0
        result = self.execute_procedure('NewSchool', [school_name])
        if result:
            new_id = int(result[0][0])
        return new_id

    def single_school(self, school_id):
        result = self.execute_procedure('SingleSchool', [school_id])
        if result:
            return result[0]
        else:
            return list()
	
    def list_school(self):
        result = self.execute_procedure('SchoolList')
        if result:
            return result[0]
        else:
            return list()

    def update_school(self, school_id, school_name):
        rows_affected = 0
        result = self.execute_procedure('UpdateSchool', [school_id, school_name])
        if result:
            rows_affected = int(result[0][0])
        return rows_affected

    def delete_school(self, school_id):
        rows_affected = 0
        result = self.execute_procedure('DeleteSchool', [school_id])
        if result:
            rows_affected = int(result[0][0])
        return rows_affected


class CourseDB(DbConnector):
    def __init__(self):
        DbConnector.__init__(self)

    def new_course(self, course_number, course_name, course_credits):
        new_id = 0
        result = self.execute_procedure('NewCourse', [course_number, course_name, course_credits])
        if result:
            new_id = int(result[0][0])
        return new_id

    def single_course(self, c_numb):
        result = self.execute_procedure('SingleCourse', [course_number])
        if result:
            return result[0]
        else:
            return list()

    def list_course(self):
        result = self.execute_procedure('CourseList')
        if result:
            return result[0]
        else:
            return list()

    def update_course(self, course_number, course_name, course_credits):
        rows_affected = 0
        result = self.execute_procedure('UpdateCourse', [course_number, course_name, course_credits])
        if result:
            rows_affected = int(result[0][0])
        return rows_affected

    def delete_course(self, course_number):
        rows_affected = 0
        result = self.execute_procedure('DeleteCourse', [course_number])
        if result:
            rows_affected = int(result[0][0])
        return rows_affected
    	
    def get_restrictors(self):
	result = self.execute_procedure('courseRestrictorList')
	if result:
	    return result
	else:
	    return list()
