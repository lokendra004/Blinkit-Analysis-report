--Full table view
select * from blinkit_ana

--total sales
select cast(sum(Sales)/ 1000000 as decimal(10 ,2)) as Total_sales_Millions
from blinkit_ana

--average sales
select cast(avg(Sales) as decimal(10,0)) as avg_sales 
from blinkit_ana

--no. of items
select count(*) as No_of_items from blinkit_ana

--total sales acc to year
select cast(sum(Sales)/ 1000000 as decimal(10 ,2)) as Total_sales_Millions
from blinkit_ana
where Outlet_Establishment_Year=2022

--average rating
select cast(avg(Rating)as decimal(10,2)) as Avg_rating from blinkit_ana

--sales acc to Item fat content
select Item_fat_content ,
 cast(sum(Sales) as decimal(10,2)) as Total_Sales
 from blinkit_ana
 where outlet_Establishment_year=2022
group by Item_Fat_Content
order by sum(sales) desc

--top 5 item_type
select top 5 Item_Type,
cast(sum(Sales) as decimal(10,2)) as Total_sales,
cast(avg(Sales) as decimal(10,1)) as Avg_sales,
count(*) as No_Of_Items,
cast(avg(Rating) as decimal(10,2)) as avg_rating
from blinkit_ana
group by Item_Type
order by Total_sales asc

--sales acc to outlet location type , fat content
select Outlet_Location_Type, Item_Fat_Content,
cast(sum(Sales) as decimal(10,2)) as Total_sales
from blinkit_ana
group by Outlet_Location_Type , Item_Fat_Content
order by Total_sales asc


--Fat content by Outlet for Total Sales
select outlet_Location_Type,
 isnull([Low Fat] , 0) as Low_Fat,
 isnull([Regular],0) as regular
 from
 (
    select Outlet_Location_Type , Item_Fat_Content,
    cast(sum(Sales) as decimal(10,2)) as total_sales
    from blinkit_ana
    group by Outlet_Location_Type,Item_Fat_Content) 
	as SourceTable
 PIVOT 
 (
   sum( total_sales)
   for Item_Fat_content in ([Low Fat] , [Regular]))
    as PivotTable
   order by Outlet_Location_Type;

--outlet establishment year
select Outlet_Establishment_Year,
cast(sum(Sales) as decimal(10,2)) as Total_sales
from blinkit_ana
group by Outlet_Establishment_Year
order by Outlet_Establishment_Year asc

--percentage of sales by outlet size
select 
    Outlet_Size,
    cast(sum(Sales) as decimal(10,2)) as Total_sales,
    cast(sum(Sales) * 100.0 / sum(sum(Sales)) over () as decimal(10,2)) as Sales_Percentage
from blinkit_ana
group by Outlet_Size
order by Total_sales desc;

--Sales by outlet location
select Outlet_Location_Type,
cast(sum(Sales) as decimal(10,2)) as Total_sales,
cast(avg(Sales) as decimal(10,1)) as Avg_sales,
count(*) as No_Of_Items,
cast(avg(Rating) as decimal(10,2)) as avg_rating
from blinkit_ana
group by Outlet_Location_Type
order by Total_sales desc

--all metrics by outlet type
select Outlet_Type,
cast(sum(Sales) as decimal(10,2)) as Total_sales,
cast(avg(Sales) as decimal(10,1)) as Avg_sales,
count(*) as No_Of_Items,
cast(avg(Rating) as decimal(10,2)) as avg_rating
from blinkit_ana
group by Outlet_Type
order by Total_sales desc

