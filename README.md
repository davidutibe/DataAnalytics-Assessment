# DataAnalytics-Assessment

## Assessment_Q1
The task was to help the business identify high value customers who have both a savings and an investment plan for cross-selling opportunities.

### My Approach
- I solved this with the use of CTEs, joins, and aggregate functions. My methods and thought process are highlighted in the bullet points below:
1. I created a CTE - plans_count to count using a case statement, the number of customers that fall within the savings and investment category; I also used a Having clause to avoid including case zero instances.
2. I created another CTE - deposits_per_customer to sum up total confirmed amount (i.e. deposits) per customer. I divided this amount by 100 in order to ensure the values were reported in Naira. I filtered out customers with zero total deposits.
3. I proceeded to join both CTEs to the users table in order to derive total deposit and count of plans in one view as required in the problem statement.

### Challenges
A challenge I encountered solving this question was in knowing which column was useful in solving the question, seeing it was the first question in the assessment. To overcome this, I exported a list of all the column names across tables using the Describe table_name function e.g "Describe savings_savingsaccount" syntax, I transfered this to a spreadsheet which enabled me acquaint myself with all the columns. This technique helped me all through the assessment.

## Assessment_Q2
The task was help the business understand how frequent customers transacted in order to enable customer clustering based on the frequency of purchase.

### My Approach
- I solved this with the use of subqueries, CTEs, aggregate functions and joins. My methods and thought process are highlighted in the bullet points below:
1. I started by writing a CTE and subquery which enabled me calculate the average number of transactions monthly per customer, which I further used to evaluate the overall number of orders monthly.
2. I proceeded to cluster the customers into High, Medium, and Low frequencies as required by the question. I did this with the use of case statement,and aggregate functions within in a CTE.
3. With the CTEs in 1 and 2 above, I was able to calculate the number of occurence of each CTE which I used to cluster the customers.

### Challenges
A challenge I encountered while solving this was the number of nested subqueries required to first breakdown the solution into monthly count, then to counting per customer, then cateorizing. To keep the query readable I adopted the approach to breakdown the problems into CTEs and embed the subqueries within the CTEs. This approach helped me maintain the ease of readbality in the queries.

## Assessment_Q3
The task was to help the business flag inactive accounts within a 1 year period.

### My Approach
- I solved this with the use of CTEs, conditional statements, and aggregate functions. My methods and thought process are highlighted in the bullet points below:
1. Similar to my approach in Assesment_Q1, I started by segmenting plan types into Savings or Investment plans with the use of case statements within a CTE.
2. I proceeded to writing a CTE which utilized the aggregate function - Max to retrieve customers' last transaction dates.
3. The final query calculated the number of days since the last transaction till date; I also filtered out cases above 365 days (1 year) using the Having clause.

### Challenges
A challenge I encountered in solving this question was in ensuring an that the query accurately classified the plan type into savings or investments. I overcame this by using creating a stand alone CTE to house this clause, and then filtering out cases of other plans using in an external CTE.

## Assessment_Q4
The task was to help the business estimate Customer Lifetime Value (CLV) based on account tenure (months since sign_up), and transaction volume (number of transactions)

### My Approach
- I solved this with the use of CTEs, aAggreagate functions, and joins. My methods and thought process are highlighted in the bullet points below:
1. I created a CTE to retrieve the number of months since sign_up for each customer id using the TIMESTAMPDIFF function.
2. I proceeded to retrive the total number of transactions and the average profit per transaction for each customer with the use of a CTE and aggregate function.
3. The final query joined both CTEs together, and calculated the estimated CTE based on the the calculated columns profit per transaction, and the total number of transactions in step 2 above.

### Challenges
A challenge I encountered here was in my initial approach of attempting to evaluate the average profit per transaction using the a stand alone query. While this was efficient for readability, it created reduncdancy in the query and slowed down performance. I overcame the query performance and reduncdancy challenge by embedding this column within an existing subquery - customer_transactions- which shortened the query length and improved performance.















