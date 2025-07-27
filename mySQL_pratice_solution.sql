### 이희만 강사님이 주신 SQL 연습문제 풀이 ! 
use newhr;  
## 1번 문제 커미션을 받는 사원은 어떤 사원들인가?
# sol) 1-1. is not null 사용하여 출력
select *
from employees
where commission_pct is not NULL;

# sol) 1-2. null은 boolean이므로 값을 비교하여 출력
select *
from employees
where (commission_pct is NULL) = False;

## 2번 문제 사번 200 사원의 커미션은 얼마인가?
# sol) 2-1. where절에서 사번을 200으로 검색하여 커미션이 얼마인지 확인 -> null로 나옴
select *, commission_pct
from employees
where employee_id = 200;

### 3번 문제 BOSTON이나 DALLAS 에 위치한 부서를 출력하시오.
# sol) 3-1. departments, locations 테이블을 join시켜서 쿼리문 작성
select distinct d.department_name
from departments d 
join locations l on d.location_id = l.location_id
where l.city in ('BOSTON' , 'DALLAS');

## 4번 문제 30, 40번 부서에 속하지 않는 사원들을 출력하시오.
# sol) 4-1. Grant라는 사람의 부서가 존재하지 않기때문에 department_id에는 null이 존재함
# where절에서 걸려있는 조건이 2개이기 때문에 = 을 사용하지 못해서 in을 사용하여 조건을 검색함
# in의 반대가 출력되어야하기 때문에 맨 앞에 not을 붙임 ! 또한 or ~ is null을 사용
select *
from employees
where department_id not IN ('30', '40') or department_id is null;

## 5번 문제 이름이 A 로 시작되는 사원을 출력하시오.
# sol) 5-1. 특정 문자로 시작되는 또는 끝나는 내용은 like를 이용하여 시작되는 (ㅁ%) 또는 끝나는 (%ㅁ) 로 검색
select *
from employees
where last_name like ('A%') or first_name like ('A%');

## 6번 문제 사번이 8번으로 끝나는 사원을 출력하시오.
# sol) 6-1. 5번문제와 동일하게 진행
select *
from employees
where employee_id like ('%8');

## 7번 문제 2010년도에 입사한 사원을 출력하시오.
# sol) 7-1. hire_date에 year를 입혀서 검색
select *
from employees
where year(hire_date) = 2010;

## 8번 문제 커미션 지급 대상인 사원을 출력하시오.
# sol) 8-1. 1번 문제와 동일
select *
from employees
where commission_pct is not NULL;

## 9번 문제 급여가 8000 이 넘는 직종을 출력하시오.
# sol) 9-1. where절에서 salary > 8000인 애들 중에서 직종(job_id)를 검색해야하지만 distinct를 추가하여 그 직종들이 나오게 만듦
select distinct job_id
from employees
where salary > 8000;

## 10번 문제 10번 부서와 20번 부서에 속한 사원을 출력하시오.
# sol) 10-1. in을 이용하여 
select *
from employees
where department_id in ('10', '20');

## 11번 문제 10번과 20번 부서에 속하지 않는 사원의 이름과 부서번호를 출력하시오.
# sol) 11-1. 10번 문제에서 not을 추가
select first_name, last_name, department_id
from employees
where department_id not in ('10','20')
order by department_id ASC;

## 12번 문제 급여가 5000에서 8000 사이인 사원을 출력하시오.
# sol) 12-1. 5000 < salary < 8000 해결방법
# 조건을 하나하나 따로 해주어야함 between을 사용하면 5000 <= salary <= 8000이 됨
select *
from employees
where salary < 8000 and salary > 5000
order by salary ASC;

select *
from employees
where salary between 5000 and 8000
order by salary ASC;

## 13번 문제 급여가 적은 사원부터 출력하시오.
# sol) 13-1. ASC DESC 활용
select *
from employees
order by salary ASC;

## 14번 문제 급여가 많은 사원부터 출력하시오.
# sol) 14-1. 13번의 반대 ! 
select *
from employees
order by salary DESC;

## 15번 문제 급여가 많은 사원부터 출력하되 급여가 같은 경우 이름 순서대로 출력하시오.
# sol) 15-1. where절에서 order by에 ,를 이용하여 조건을 추가할수있음
select *
from employees
order by salary DESC, first_name ASC;

# 조건을 반대로 주면 앞에부터 정렬을 시작해줌 이름 전체를 이용하여 진행하기 때문에 아래처럼 이름이 완전히 같아야 급여도 DESC로 정렬됨
select *
from employees
order by first_name ASC, salary DESC;
# David	Bernstein	DBERNSTE	44.1632.960006	2015-03-24 00:00:00	SA_REP	9500.00
# David	Lee	DLEE	44.1632.960020	2018-02-23 00:00:00	SA_REP	6800.00
# David	Williams	DWILLIAMS	1.590.555.0105	2015-06-25 00:00:00	IT_PROG	4800.00

## 16번 문제 사원들의 입사일을 출력하시오.
# sol)
select hire_date
from employees;

## 17번 문제 사원들 입사일의 월을 알파벳 전체 이름으로 출력하시오.
# sol) 17-1. 
# month(hire_date)     = 6
# monthname(hire_date) = June
select monthname(hire_date)
from employees;

## 18번 문제
## 각 부서별로 실적에 따라 급여를 다르게 인상하고자 한다.  
## 10번과 20번 부서는 각각 10%, 20% 인상을 하고 
## 나머지 부서는 동결할 경우의 급여를 CASE를 써서 출력하시오.
# sol) 18-1. case구문은 select에 사용할 수 있고 case - when ~ then ~ when ~ then ~ end 로 구성
select *,
(case when department_id = 10 then salary*1.1
	 when department_id = 20 then salary*1.2
else salary
end) AS 급여조정결과
from employees;

#### join
## 19번 문제 20번 부서의 이름과 그 부서에 근무하는 사원의 이름을 출력하시오.
# sol) 19-1. employees, departments 테이블은 department_id가 같기때문에 2개의 테이블을 1개의 조건으로 join시킬 수 있음
# 두개의 섬이 있는데 서로 연결을 시키려면 최소한 1개의 다리가 있어야 연결될 수 있는 것과 같은 맥락
select e.*, d.department_name
from employees e join departments d on e.department_id = d.department_id
where e.department_id = 10;

## 20번 문제 1400,1500 번 위치의 도시 이름과 그곳에 있는 부서의 이름을 출력하시오.
# sol) 20-1. departments, location이 location_id로 묶여있음 19번과 동일한 흐름
# 1400, 1500번의 위치(location_id)를 in 조건을 이용하여 1400 또는 1500에 있는 애들만 가져올 것임
# 가져오긴할건데 뭐를 select할지? -> 도시이름(l.city)과 부서의 이름(d.department_name)을 가져올것이다.
select l.city, d.department_name
from departments d join locations l on d.location_id = l.location_id
where l.location_id in (1500, 1400);

#### Aggregation
## 21번 문제 직종별 최고 급여를 급여가 많은 직종부터 출력하시오.
# sol) 21-1. 21번부터 해야함

## 22번 문제 직종별 최고 급여를 급여가 많은 직종부터 출력하시오. (단, 직원이 2명 이상인 경우만)
# HAVING 사용법
#### subquery
# EXISTS 연산자 
## 23번 문제 사원이 한명이라도 있는 부서명을 출력하시오. 

## Subquery의 종류

## 24번 문제 각 부서별로 최고급여를 받는 사원을 출력하시오. 
# Nested Query
# Correlated Query

# TOP-K 질의
## 25번 문제 급여를 많이 받는 순서대로 상위 3명을 출력하시오.