select SUM(NumWebPurchases), SUM(NumWebVisitsMonth), Year(Dt_Customer), Month(Dt_Customer) as months  from marketing
group by Year(Dt_Customer), Month(Dt_Customer) 
order by Year(Dt_Customer), Month(Dt_Customer)

select * from marketing 

select  SUM(NumWebVisitsMonth), Month(Dt_Customer) as months  from marketing
group by Month(Dt_Customer) 





-- here

--create temporary table1 for easy to extract 


with table1 as(
select Year(Dt_Customer) as years, Month(Dt_Customer) as months,  sum(n_purchases) as Total, count(ID) as num_user, sum(NumWebVisitsMonth) as numvisit
, sum(NumWebPurchases) as Numwebpurchases, sum(NumCatalogPurchases) as Numcatalogpurchases, sum(NumstorePurchases) as Numstorepurchases, cast((cast(sum(NumWebPurchases) as decimal(10,2))/(cast(sum(NumWebVisitsMonth) as decimal(10,2))+cast(sum(NumWebPurchases) as decimal(10,2)))*100) as DECIMAL(10, 2)) as conversion_rate,
sum(MntWines) as wine, sum(MntFruits) as fruits, sum(MntMeatProducts) as meat, sum(MntFishProducts) as fish, sum(MntSweetProducts) as sweet, sum(NumDealsPurchases) as num_deal_purchases, (cast(sum(NumDealsPurchases) as decimal(10,2))/cast(sum(n_purchases) as decimal(10,2)))*100 as khuyen_mai  
, row_number() over( order by Year(Dt_Customer), Month(Dt_Customer)) row_num  
from marketing
group by Year(Dt_Customer), Month(Dt_Customer) 

)

--calculation on table1 to find insight 

select top 1 row_num,
years as years,
months as months,
(Total) as tong_don,
(lag(Total) over(order by years, months )) as tong_don_thang_truoc,
cast(((cast(Total as decimal(10,2))-cast(lag(Total) over(order by years, months ) as decimal(10,2)))/cast(lag(Total) over(order by years, months ) as decimal(10,2))) as decimal(10,2)) as cung_ky_ddh, 
num_user as so_kh,
(lag(num_user) over(order by years, months )) as so_kh_thang_truoc,
cast(((cast(num_user as decimal(10,2))-cast(lag(num_user) over(order by years, months ) as decimal(10,2)))/cast(lag(num_user) over(order by years, months ) as decimal(10,2))) as decimal(10,2)) as cung_ky_so_kh, 
numvisit,
(lag(numvisit) over(order by years, months )) as num_visit_thang_truoc,
cast(((cast(numvisit as decimal(10,2))-cast(lag(numvisit) over(order by years, months ) as decimal(10,2)))/cast(lag(numvisit) over(order by years, months ) as decimal(10,2))) as decimal(10,2)) as cung_ky_so_visit,
conversion_rate,
(lag(conversion_rate) over(order by years, months )) as conversion_rate_thang_truoc,
cast(((cast(conversion_rate as decimal(10,2))-cast(lag(conversion_rate) over(order by years, months ) as decimal(10,2)))/cast(lag(conversion_rate) over(order by years, months ) as decimal(10,2))) as decimal(10,2)) as cung_ky_conversion_rate

from table1 
--where row_num = select(max(row_num) from table1)
order by row_num desc 



select * from table1
 



