select * from project.dbo.Data1;

select * from project.dbo.Data2;

--deleting null rows

DELETE from project..Data1 WHERE state IS NULL ;

DELETE from project..Data2 WHERE state IS NULL ;

--number of rows in our dataset

select count(*) as count_rows from project..Data1;

select count(*) as count_rows from project..Data2;

-- dataset from jharkand and bihar

select * from project..Data1
where state in ('Jharkand', 'Bihar') ;

-- Population of India

select sum(population) as population_sum from project..Data2 ;

-- avg growth

select avg(growth)*100 avg_growth from project..Data1 ;

select state,avg(growth)*100 avg_growth from project..Data1
group by state ;

--avg sex ratio 

select state,round(avg(sex_ratio),0) avg_sex_ratio from project..Data1
group by state ;

select state,round(avg(sex_ratio),0) avg_sex_ratio from project..Data1
group by state order by avg_sex_ratio desc ;

--avg literacy rate

select state,round(avg(literacy),0) avg_literacy_ratio from project..Data1
group by state order by avg_literacy_ratio desc ;

select state,round(avg(literacy),0) avg_literacy_ratio from project..Data1
group by state having round(avg(literacy), 0) > 90
order by avg_literacy_ratio desc ;

--top 3 state showing highest growth ratio

select top 3 state,avg(growth)*100 avg_growth from project..Data1
group by state order by avg_growth desc ;

select state,avg(growth)*100 avg_growth from project..Data1
group by state
order by avg_growth desc limit 3;

--bottom 3 state showing lowest sex ratio

select top 3 state, round(avg(sex_ratio),0) avg_sex_ratio from project..Data1
group by state 
order by avg_sex_ratio ;

--top 3 and bottom 3 in literacy state

create table #topstates
(state nvarchar(255),
 topstate float
 )
 insert into #topstates
 select state, round(avg(literacy),0) avg_literacy_ratio from project..Data1
 group by state 
 order by avg_literacy_ratio desc; 

 select * from #topstates

--states starting with letter a and b

select distinct state from project..data1
where lower(state) like 'a%' or lower(state) like 'b%' 

--states starting with letter a and m

select distinct state from project..data1
where lower(state) like 'a%' or lower(state) like 'm%' 

--joining both tables

select a.district,a.state,a.sex_ratio ,b.population from 
project..data1 a inner join project..data2 b on a.district=b.district

select c.district,c.state,round((c.population/(c.sex_ratio+1)),0) males, round(((c.population*c.sex_ratio)/(c.sex_ratio+1)),0) females from
(select a.district,a.state,a.sex_ratio ,b.population from
project..data1 a inner join project..data2 b on a.district=b.district) c
