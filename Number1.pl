
myAppend([],L,L).
myAppend([H|T],L2,[H|R]):-
myAppend(T,L2,R).


myMember(X,[X|_]).
myMember(X,[_|T]):-
myMember(X,T).

theDigitsInWords(0,zero).
theDigitsInWords(1,one).
theDigitsInWords(2,two).
theDigitsInWords(3,three).
theDigitsInWords(4,four).
theDigitsInWords(5,five).
theDigitsInWords(6,six).
theDigitsInWords(7,seven).
theDigitsInWords(8,eight).
theDigitsInWords(9,nine).

%Task1
studentsInCourse(Course, Students):-
	studentsInCourse(Course, [], Students).
	
studentsInCourse(Course, Newlist, Students):-
	student(ID, Course, Grade),
	 \+(myMember([ID, Grade], Newlist)),!, 
	myAppend([[ID, Grade]], Newlist, Newlist2),
	studentsInCourse(Course, Newlist2, Students).
studentsInCourse(_, Students, Students).

%Task2
size([],0).
size([_|T],R):-
size(T,R1),
R is 1+R1.

numStudents(Course, Num):-
studentsInCourse(Course, [], Students),
size(Students, Num).

%Task3
studentGrade(ID, Grades):-
	studentGrade(ID, [], Grades).
	
studentGrade(ID, Newlist, Grades):-
	student(ID, _, Grade),
	\+(member(Grade, Newlist)),!, 
	myAppend([Grade], Newlist, Newlist2),
	studentGrade(_, Newlist2, Grades).
studentGrade(_, Grades, Grades).


maxElement([H|T],R):-
maxElement(T,H,R).

maxElement([],H,H).
maxElement([S|T],H,R):-
S >H
->
maxElement(T,S,R)
;
maxElement(T,H,R).

maxStudentGrade(ID, MaxGrade):-
studentGrade(ID, [], Grades),
maxElement(Grades,MaxGrade).

%Task4

gradeInWords(ID, Course, DigitsWords):-
student(ID, Course, Grade),
 X is (Grade mod (10)),
 Y is (Grade//10),
 theDigitsInWords(X,Ones),
 theDigitsInWords(Y,Tens),
 gradeInWords(ID, Course,[Tens,Ones], DigitsWords).
 gradeInWords(_, _, DigitsWords ,DigitsWords).
 
 
%Task5 
 
passTheCourse(ID,Course):-
 student(ID, Course, Grade),
 Grade>50 -> true; false.

myCourses(Course,MyList):-
    myCourses(Course,[],MyList).
	
myCourses(_,MyList,MyList).
myCourses(Course,AllList,MyList):-
     prerequisite(CoursesList,Course),
      myAppend([CoursesList],AllList,New),!,
     myCourses(CoursesList,New,MyList).

remainingCourses(ID,Course,Courses):-
   myCourses(Course,RESULT),
   [H|T] = RESULT,
   student(ID,H,_),
   passTheCourse(ID,H),!,
   myAppend([],T,Courses).




 