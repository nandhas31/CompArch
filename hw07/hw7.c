/**
 * @file hw7.c
 * @author YOUR NAME HERE
 * @brief structs, pointers, pointer arithmetic, arrays, strings, and macros
 * @date 2021-03-xx
 */

// DO NOT MODIFY THE INCLUDE(S) LIST
#include <stdio.h>
#include "hw7.h"
#include "my_string.h"

// Global array of student structs
struct student class[MAX_CLASS_SIZE];

int size = 0;

/** addStudent
 *
 * @brief creates a new student struct and adds it to the array of student structs, "class"
 *
 *
 * @param "name" name of the student being created and added
 *               NOTE: if the length of name (including the null terminating character)
 *               is above MAX_NAME_SIZE, truncate name to MAX_NAME_SIZE
 * @param "age" age of the student being created and added
 * @param "gpa" gpa of the student being created and added
 * @param "id" id of the student being created and added
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the length of "id" is less than MIN_ID_SIZE
 *         (2) a student with the name "name" already exits in the array "class"
 *         (3) adding the new student would cause the size of the array "class" to
 *             exceed MAX_CLASS_SIZE
 */
int addStudent(const char *name, int age, double gpa, const char *id)
{
  if (size == MAX_CLASS_SIZE || my_strlen(id) < MIN_ID_SIZE)
  {
    return FAILURE;
  }
  char newName[10];
  if (my_strlen(name) >= MAX_NAME_SIZE)
  {
    my_strncpy(newName, name, 9);
    newName[9] = '\0';
    name = newName;
  }
  int i = size;
  while (i > 0)
  {
    i--;
    if (my_strncmp(class[i].name, name, my_strlen(name)) == 0)
    {
      return FAILURE;
    }
  }

  my_strncpy(class[size].name, name, MAX_NAME_SIZE - 1);
  class[size].age = age;
  class[size].gpa = gpa;
  my_strncpy(class[size].id, id, MAX_ID_SIZE - 1);

  size++;
  return SUCCESS;
}

/** updateStudentName
 *
 * @brief updates the name of an existing student in the array of student structs, "class"
 *
 * @param "s" student struct that exists in the array "class"
 * @param "name" new name of student "s"
 *               NOTE: if the length of name (including the null terminating character)
 *               is above MAX_NAME_SIZE, truncate name to MAX_NAME_SIZE
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the student struct "s" can not be found in the array "class"
 */
int updateStudentName(struct student s, const char *name)
{
  int i = 0;
  char newName[10];
  if (my_strlen(name) >= MAX_NAME_SIZE)
  {
    my_strncpy(newName, name, 9);
    newName[9] = '\0';
    name = newName;
  }
  while (i < size)
  {
    if (my_strncmp(class[i].name, s.name, my_strlen(s.name)) == 0)
    {
      my_strncpy(class[i].name, name, MAX_NAME_SIZE - 1);
      return SUCCESS;
    }
    i++;
  }
  return FAILURE;
}

/** swapStudents
 *
 * @brief swaps the position of two student structs in the array of student structs, "class"
 *
 * @param "index1" index of the first student struct in the array "class"
 * @param "index2" index of the second student struct in the array "class"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "index1" and/or "index2" are negative numbers
 *         (2) "index1" and/or "index2" are out of bounds of the array "class"
 */
int swapStudents(int index1, int index2)
{
  if (index1 >= size || index2 >= size || index1 < 0 || index2 < 0)
  {
    return FAILURE;
  }
  struct student temp = class[index1];
  class[index1] = class[index2];
  class[index2] = temp;

  return SUCCESS;
}

/** removeStudent
 *
 * @brief removes an existing student in the array of student structs, "class"
 *
 * @param "s" student struct that exists in the array "class"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the student struct "s" can not be found in the array "class"
 */
int removeStudent(struct student s)
{
  for (int i = 0; i < size; i++){
    if (my_strncmp(s.name, class[i].name, my_strlen(s.name)) == 0){
      for (int j = i; j < size-1; j++){
        class[j] = class[j+1];
      }
      size--;
      return SUCCESS;
    }
  }

  return FAILURE;
}

/** compareStudentID
 *
 * @brief using ASCII, compares the last three characters (not including the NULL
 * terminating character) of two students' IDs
 *
 * @param "s1" student struct that exists in the array "class"
 * @param "s2" student struct that exists in the array "class"
 * @return negative number if s1 is less than s2, positive number if s1 is greater
 *         than s2, and 0 if s1 is equal to s2
 */
int compareStudentID(struct student s1, struct student s2)
{
  char *str1 = s1.id;
  char *str2 = s2.id;
  str1 += (my_strlen(s1.id)-4);
  str2 += (my_strlen(s2.id)-4);
  return my_strncmp(str1, str2, 3);
}

/** sortStudents
 *
 * @brief using the compareStudentID function, sort the students in the array of
 * student structs, "class," by the last three characters of their student IDs
 *
 * @param void
 * @return void
 */
void sortStudents(void)
{
    int y = size - 1;
    while(y > 0) {
       int x = 0;
       while(x < y) {
             // if compare returns 1, swap
             if (compareStudentID(class[x], class[x+1]) > 0) {
                 struct student temp = class[x];
                 class[x] = class[x+1];
                 class[x+1] = temp;
             }
             x++;
         }
         y--;
     }
 }

