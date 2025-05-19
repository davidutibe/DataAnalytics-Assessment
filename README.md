# DataAnalytics-Assessment

## Assessment_Q1
The task was to help the business identify high value customers who have both a savings and an investment plan for cross-selling opportunities.

### My Approach
I solved this by retrieving data from the users, savings, and plans tables.
- I solved this with the use of CTEs, joins, and aggregate functions. My methods and thought process are highlighted in the bullet points below:
1. I created a CTE - plans_count to count using a case statement, the number of customers that fall within the savings and investment category; I also used a Having clause to avoid including case zero instances.
2. I created another CTE - deposits_per_customer to sum up total confirmed 

