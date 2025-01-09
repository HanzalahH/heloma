# Broken Object  Level Authorization
#IDOR

**What is Broken Object Level Authorization?**
```
Broken Object Level Authorization (BOLA) occurs when an application doesn't properly enforce authorization checks for accessing sensitive information or actions related to objects or resources. This means that a user might be able to access or modify data or perform actions that they shouldn't be allowed to, simply by manipulating request parameters or directly accessing resources that belong to other users.
```

**How to find it?**
```
- **Identify Object References:**
   
Look for identifiers in URLs, form fields, or API parameters that represent objects (e.g., user IDs, document IDs).

**Enumerate Object References:**
  
Try changing these identifiers to see if you can access or modify other users' data. For instance, if you see a URL like `example.com/user/123`, try changing `123` to other numbers to see if you can access different user profiles.

**Check Access Controls:**
   
Ensure that the application performs proper authorization checks for each request. For example, when you try to access or modify a resource, the application should verify that you have the appropriate permissions.
```

# Broken Authentication
#Account-Takeover 
**What is Broken Authentication On API's?**
```
Broken authentication on APIs occurs when an API's authentication mechanisms are improperly implemented, allowing attackers to bypass or misuse them. This can lead to unauthorized access to accounts, sensitive data, or functionalities that should be restricted.
```

 **Practical Example:**

```
Imagine an API that allows users to log in with a username and password. If the API does not properly check for account lockout after several failed login attempts, an attacker could use a brute-force attack to try different password combinations until they find the correct one, leading to unauthorized access.
```


**Common Causes of Broken Authentication:**

1. **Weak Password Policies:** `Allowing simple or common passwords increases the risk of account compromise.`
2. **Lack of Multi-Factor Authentication (MFA):** `Relying solely on passwords without an additional layer of security makes it easier for attackers to gain access.`
3. **Exposed API Keys:**` If API keys are hard-coded in applications or shared insecurely, they can be easily stolen.`
4. **Improper Session Handling:** `Issues like session IDs not being invalidated after logout or session fixation can lead to session hijacking.`
5. **No Rate Limiting:** `Not limiting the number of login attempts allows brute-force attacks to succeed.`

# Broken Object Property Level Authorization
#information-disclosure

**What is Broken Object Property Level Authorization?**
```
**Broken Object Property Level Authorization (BOPLA)** is a security vulnerability that occurs when an application fails to properly enforce access controls at the property level of an object. This means that a user can access or manipulate properties of an object that they shouldn't be allowed to.
```

**Example Scenario:**

- **Object**: A product in an e-commerce system.
- **Properties**:
    - `productName`: "Wireless Headphones"
    - `price`: 29.99
    - `stockQuantity`: 100
    - `discountedPrice`: 19.99 (if a discount is applied)

```
If you, as a regular user, are able to send a request that changes the `price` property from 29.99 to 19.99 and successfully purchase the product at this unauthorized price, it indicates a BOPLA vulnerability. The system should have validated whether you have the necessary permissions to modify the price property, and if it didn’t, that’s a security flaw.
```

# Unrestricted Resource Consumption
#DOS

**What is Unrestricted Resource Consumption:**
```
Unrestricted Resource Consumption refers to a situation where an application, service, or API allows users to consume resources without enforcing proper limits. This can lead to overuse of system resources, such as CPU, memory, bandwidth, or database connections, which can degrade performance, cause service interruptions, or even lead to a complete denial of service (DoS).
```

**Examples of Unrestricted Resource Consumption:**

API Rate Limiting: ```
```
If an API doesn't implement rate limiting, a user could flood the server with requests, consuming all available bandwidth and CPU, making the service unavailable to others.
```
  
File Uploads: 
```
An application that allows users to upload files without size restrictions could face issues if someone uploads excessively large files, consuming disk space and potentially crashing the server.
```

Database Queries: 
```
If an API allows users to request large amounts of data in a single query without pagination, it could lead to high memory usage and slow database performance.
```

# Broken Function Level Authorization
#Privilege-Escalation

**What is Broken Function Level Authorization?**
```
Broken Function Level Authorization is a security vulnerability that occurs when an application fails to properly enforce authorization checks for its functions or actions, allowing unauthorized users to execute functions they should not have access to. This can lead to unauthorized access, privilege escalation, or unintended modifications within the application.
```
![[Screenshot from 2024-08-18 01-03-23.png]]

**Simple Explanation:**
```
In Broken Function Level Authorization We Just try to use fuinction of other user like we try to delete user 1 post with Admin account url " admin/accounts/deleteuser?userid=1 "  by simply accessing the url or manipulating the request.
```

# Unrestricted Access to Sensitive Business Flows
#Business-Logic-Issues

**What is  Unrestricted Access to Sensitive Business Flows?**

```
**Unrestricted Access to Sensitive Business Flows** occurs when an API allows users to access critical business operations without proper checks, such as authentication, authorization, or input validation. These operations might include actions like transferring money, modifying user data, or deleting records. If these flows are not properly protected, unauthorized users could exploit them to cause serious harm to the business.
```


**Simple Senario:**
```
An unauthenticated user can purchase the product leading to  instantly drain the stock.
a purchase flow for a web application does not restrict access to a purchase process then a scalper could automate requests to instantly drain the stock of an item down to nothing
```

**Scenario: Unrestricted Access to Sensitive Business Flows in TechMart Inc.**

**Overview:**

- **TechMart Inc.** is a global retailer with a massive online store.
- The company has a **backend server** that connects to several critical systems:
    1. **Online Store**: Handles customer orders, payments, and product inventory.
    2. **Support Team**: Manages customer support tickets and user account modifications.
    3. **Database**: Stores customer data, order history, and financial records.
    4. **Data Analytics**: Analyzes customer behavior, sales trends, and marketing strategies.

**API Endpoints:**

1. **Order Processing API**: `/api/orders`
    - Handles placing, updating, and canceling orders.
    - **Vulnerability**: No authentication checks.
2. **Support Management API**: `/api/support/tickets`
    - Manages support tickets and user account updates.
    - **Vulnerability**: Insufficient role-based access control.
3. **Database Access API**: `/api/database/customer`
    - Provides direct access to customer data.
    - **Vulnerability**: No access restrictions based on user roles.
4. **Data Analytics API**: `/api/analytics/reports`
    - Generates reports on sales and customer behavior.
    - **Vulnerability**: Open access without checking user permissions.

**Attack Scenario**

**Step 1: Attacker Discovers Unrestricted Order Processing**

- The attacker identifies the **Order Processing API** endpoint.
- The API allows placing, updating, or canceling orders without requiring authentication.

**Example of a Vulnerable API Request:**

```

POST /api/orders HTTP/1.1
Host: techmart.com
Content-Type: application/json

{
    "orderId": "999999",
    "productId": "12345",
    "quantity": 10,
    "shippingAddress": "123 Attacker Lane, Hacking City"
}



```

**Impact:**
- The attacker places a large order without logging in, potentially draining the store’s inventory or causing financial loss if fraudulent transactions are processed.

**Step 2: Unauthorized Access to Support Management**

- The attacker then moves to the **Support Management API**.
- Since the API lacks proper role-based access control, the attacker can modify user accounts or close support tickets.

**Example of a Vulnerable API Request:**

```
PUT /api/support/tickets/67890 HTTP/1.1
Host: techmart.com
Authorization: Bearer some-stolen-user-token
Content-Type: application/json

{
    "ticketStatus": "Closed",
    "resolutionNotes": "Issue resolved"
}

```

**Impact:**

- The attacker closes critical support tickets or alters user accounts, leading to unresolved customer issues and potential loss of trust in the support system.

**Step 3: Exposing Sensitive Customer Data**

- The attacker discovers the **Database Access API**.
- With no access restrictions, the attacker retrieves sensitive customer data.

**Example of a Vulnerable API Request:**

```
GET /api/database/customer/12345 HTTP/1.1
Host: techmart.com

```

**Impact:**

- The attacker gains access to personal information like customer addresses, order history, and payment details, leading to privacy breaches and potential identity theft.

# (SSRF) Server Side Request Forgery

**What is SSRF?**
```
Server-Side Request Forgery (SSRF) is a security vulnerability where an attacker tricks a server into making requests to unintended locations. This can lead to the exposure of sensitive data, unauthorized actions, or the compromise of internal systems. It's a concern in the API Top 10, as APIs often have access to internal resources that shouldn't be exposed to the public.
```

**How SSRF Works:**

```
Targeting Internal Resources: An attacker might find a vulnerable API endpoint that accepts user input (like a URL). The attacker crafts a request that makes the server access an internal resource (e.g., a private IP address or a sensitive internal service).

Unauthorized Access: The server, thinking it's a legitimate request, might fetch data from these internal resources, exposing them to the attacker. This could include sensitive files, metadata, or internal APIs.

Potential Consequences:

Data Exposure: Sensitive information from internal systems can be leaked.

Internal Network Scanning: Attackers can scan internal networks, revealing more targets.

Service Abuse: Attackers might make the server perform unauthorized actions, like deleting files or sending spam.
```


**Example Scenario:**

```
Imagine an API that fetches content from a URL provided by the user, like a website preview feature. If the API doesn't properly validate the input URL, an attacker could input a URL like `http://internal-system/admin`. The server, instead of fetching a public webpage, might access an internal admin panel, potentially exposing sensitive admin data to the attacker.
```

# Security Misconfiguration

Security Misconfiguration is one of the key issues in the API Top Ten and refers to improper settings or configurations in an API that can expose vulnerabilities. These misconfigurations can occur at various levels of an application stack, from the infrastructure to the API itself, leading to potential security risks.

**EXAMPLES:**
```
Forgotten Test API:

Scenario: During the development of a mobile application, developers create a test API to simulate user data. After the app is launched, the test API is forgotten but remains publicly accessible.

Risk: This forgotten API might be used by attackers to gain access to user data or to perform unauthorized actions, as it might not have the same security measures as the production API.

Lack of Rate Limiting:

Failing to implement rate limiting on API endpoints can allow attackers to brute-force credentials or overwhelm the API with requests (Denial of Service).

Unsecured API Endpoints:

Exposing endpoints without proper authentication or authorization checks can allow unauthorized access to sensitive data or operations.
```

# Improper Inventory Management

**A Simple and Easy Explanation:**
```
Its like someone reported the bug on this url " /api/v3/admin/id=vulnerable "
like that and it fixed but but the application still supports the older version api so we caan just change the version to " /api/v1/admin/id=vulnerable " and if its work we will get the successfull responce

In short, Improper Inventory Management means not keeping track of all the pieces of your software or API, leading to potential security risks and operational problems.

In all these scenarios, the common theme is that components, services, or resources are left unmanaged, outdated, or forgotten. This creates opportunities for attackers to find and exploit weaknesses that the organization might not even realize exist. Proper inventory management involves regularly auditing, updating, and decommissioning resources to minimize these risks.

```


![[Screenshot from 2024-08-19 01-05-40.png]]

# Unsafe Consumption Of API's

**What is Unsafe Consumption Of API's ?**
```
So Unsafe Consumption of api's happens when the webapplication trusts the third party api blindly " not validating the responce recived from the third party api " and then the third party controlled by attacker or some how attaacker manipulates the third party to send's the maliciuos data to the leget website api then the malicious code runs causing it to harm..
```

### Scenario Explained

1. **What the API Does**:
```
The API takes addresses provided by users and sends them to a third-party service.
This service returns additional information about the address, which the API then stores in its local database.
```
2. **How the Attacker Exploits It**:
```
The attacker creates a fake business entry in the third-party service.
This fake entry includes malicious code (SQL injection) designed to attack the API’s database.
```

3. **Attack Execution**:
```
The API requests data from the third-party service for the fake business.
Since the fake business includes the malicious code, the API retrieves this code and stores it in the local SQL database.
When the database processes this data, it executes the malicious SQL code.
```
4. **Outcome**:
```
The malicious SQL code runs on the database, allowing the attacker to access or steal sensitive data from the database.
This data is then sent to a server controlled by the attacker.
```
### In Simple Terms

Imagine a shop that checks business addresses through a service and saves extra details in its records. An attacker makes a fake business entry with harmful instructions and tricks the shop's system into saving this entry. When the system processes the entry, the harmful instructions run and allow the attacker to steal information from the shop's database.

