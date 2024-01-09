
-- This is a data cleaning and EDA project of public healthcare facilities in Lagos State. 


Select * 
	From LagHealthcare

-- Removing NULL Columns from the table--

Alter Table LagHealthcare
	Drop column F11,F12,F13,F14,F15;


--Aligning Columns in the Table--
Select LGA_Name,Trim(LGA_Name) AlignedName
From LagHealthcare 

 Update LagHealthcare
 Set LGA_NAME = Trim(LGA_Name)

 Update LagHealthcare
 Set WARD  = Trim(WARD)

 Update LagHealthcare
  Set Facility_Name = Trim(Facility_Name)


 --- Showing the daily working ours of the healthcare facilities---
   --- There are four categories of Healthcare facilities working in different hours of the day.
Select Distinct FACILITY_TYPE
	From LagHealthcare

	-- I created a case to categorize the facilities based on the duration of opening hours according to facility type
Select Facility_Type,
	(CASE
	When FACILITY_TYPE = 'Primary Healthcare Centre' Then 12
	When FACILITY_TYPE = 'Secondary Health Facility' Then 24
	When FACILITY_TYPE = 'Comprehensive Primary Healthcare Centre' Then 24
	When FACILITY_TYPE = 'Tertiary Health Facility' Then 24 
	Else 0 
	End) As Daily_Working_Hours 
From LagHealthcare

 --I added a column 'Daily working hours' to the table and update it with results from the Case query
Alter Table LagHealthCare
  Add Daily_Working_Hours int

  Update LagHealthcare
  Set Daily_Working_Hours = CASE
							When FACILITY_TYPE = 'Primary Healthcare Centre' Then 12
							When FACILITY_TYPE = 'Secondary Health Facility' Then 24
							When FACILITY_TYPE = 'Comprehensive Primary Healthcare Centre' Then 24
							When FACILITY_TYPE = 'Tertiary Health Facility' Then 24 
							Else 0 
							End		

--Breakdown of total facility level across the whole Lagos sate--
Select Coalesce(FACILITY_LEVEL, 'SubTotal') FACILITY_LEVEL,Count(Facility_Level) 
	From LagHealthcare
	Group by Rollup(FACILITY_LEVEL)


--Showing numbers of healthcare faclities in each Local Government Area--
Select Distinct LGA_Name, Count(FACILITY_TYPE) FacilityCount
  From LagHealthcare
  Group by LGA_NAME
	Order by 2 Desc

Select  LGA_NAME,FACILITY_LEVEL, Count(facility_level) FacilitylevelCount 
	From LagHealthcare
	Group by LGA_NAME,FACILITY_LEVEL
	Order by 1 

Select *
	From LagHealthcare