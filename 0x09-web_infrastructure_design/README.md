# 0x09. Web infrastructure design

## Tasks on the 0x09. Web infrastructure design Project

### Task 0: Simple web stack
This is the design of a one server web infrastructure that hosts the website that is reachable via `www.foobar.com`.

#### Components:
- **A server**: A computer that communicates with clients over a network
- **A domain name**: identifies internet resources  in a human-readable, text-based way. In this case, it helps to identify the website `www.foobar.com` so that it can be translated to its IP address 8.8.8.8 by the DNS resolver
- **A CNAME DNS record `www`**: a subdomain of `foobar.com`
- **A web server**: serves static content for a website via HTTP to the client (HTML, CSS)
- **An application server**: serves dynamic content for a website when content needs to be generated dynamically
- **A database**: stores data for the website, for example, user info. Data can be retrieved, deleted, updated, inserted, etc. on request of the web / application server based on client request.
- **A code base**: The source files for the website, both static (HTML, CSS) and dynamic (PHP, Python, etc).
- **HTTP**: the protocol by which the server communicates with the client.

#### Issues:
- **SPOF**: One of the main issues with this infrastructure is that it has several single points of failure. There is only one server, which will not be able to cope with an increase in request traffic. There is also one database, which will not be able to handle a huge load of read and write requests that might come with increased traffic. These SPOFs will make it difficult to scale this website. Also, if there is downtime, whether planned or unplanned, there is no backup server or database to ensure that things continue to run smoothly until the server / database that is down is running smoothly.
- **Lack of security**: The server is using HTTP to communicate with the client, which is insecure as data sent via this protocol is sent in plaintext. Every request and response is visible to anyone. There are also no firewalls, which makes this infrastructure vulnerable to malicious attacks.
- **Lack of monitoring**: There are no monitoring tools in this infrastructure, which means there’s no way to ascertain whether all components of the network are working properly. This makes failover difficult to achieve and affects high availability

### Task 1: Distributed web infrastructure
This is the design of a three server web infrastructure that hosts the website `www.foobar.com`

#### Components:
- **Additional servers**: One server will have the extra web server, application server, and database installed on it, while the other server has the load balancer installed on it. These additional servers increase redundancy and ensure that the system is highly available, and the system can handle increased traffic better. If one server is down due to planned or unplanned downtime, the other server can bear the request load until the other is fixed. 
- **A load balancer**: The load balancer distributes requests to the servers based on a load balancer algorithm. My algorithm of choice is the **Round Robin** algorithm, which distributes requests to the servers sequentially (I am assuming that the two servers are of equal capacity). This algorithm will ensure that the request load is distributed fairly equally between the two servers. My load balancer is also operating an **Active-Active** setup, where both servers are always active, compared to an _Active Passive_ setup where only one instance is active while the other server acts as a back-up in the case of any issue with the active server. I prefer the active-active setup because the load can be distributed equally, especially because there’s no active monitoring in this setup.
- **A Master-Slave database set-up**: With the addition of a second database, one database will be a replica / slave while the other will be the primary / master. The master database handles both read and write operations while the slave database handles only read operations. With this cluster, the master database will handle updates to the database, and those updates will be shared with the slave database. This distributes the load on the database to improve performance. Separate actions can be taken on the master database and the slave database without disturbing the operations on either. Also, if the master database should fail for whatever reason, the slave database is a back-up and can become the master database.

#### Issues:
- **SPOF**: There is a single point of failure because there is only one load balancer. If there’s an issue with the load balancer, there will be downtime while it is being repaired.
- **Lack of security**: The server is using HTTP to communicate with the client, which is insecure as data sent via this protocol is sent in plaintext. Every request and response is visible to anyone. There are also no firewalls, which makes this infrastructure vulnerable to malicious attacks.
- **Lack of monitoring**: There are no monitoring tools in this infrastructure, which means there’s no way to ascertain whether all components of the network are working properly. This makes failover difficult to achieve and affects high availability

### Task 2: Secured and monitored web infrastructure
This is the design of a secured and monitored three-server web infrastructure that hosts the website `www.foobar.com`

#### Components:
- **Firewalls**: A division between the servers and the internet that manages traffic passing through the network. Firewalls are configured with rules and allow, limit, and block network traffic based on those rules. Adding firewalls to the infrastructure improves network security and blocks malicious traffic from infiltrating the website and its servers.
- **HTTPS**: This is the secure version of HTTP. With the addition of the SSL certificate, traffic passing through this network is served over HTTPS and is thus encrypted. This means that requests and responses sent over this network are no longer easily visible, and sensitive data can be protected. SSL termination in this infrastructure is at the level of the load balancer, which protects the servers from being exposed due to certificate renewal, allows you to maintain certificates more easily, and keeps the servers unburdened of the task of processing encrypted messages (since all of that is done at the load balancer level)
- **Monitoring clients and data collector**: The monitoring clients are added to ascertain whether all components of the network are working properly. The monitoring tool is an executable file which collects performance and health data from the servers as well as log data and uploads them to the data collector where they can be analyzed. These monitoring clients can be configured to give alerts when there is an issue with the infrastructure. With the monitoring client and data collector, failover can be achieved when components of the network are not working as they should. Another metric that can be actively monitored with this expanded infrastructure is the web server queries-per-second (QPS). This is a measure of the rate of traffic going to the web server and it is used to analyze how well the web server can handle changing amounts of Web traffic and is a measure of how scalable the server is. The monitoring client collects web server logs and monitors network traffic and analyzes the server performance.

#### Issues:
- **SSL Offloading**: While terminating SSL at the load balancer helps centralize encryption and improve web server performance, it is risky because data going from the load balancer to the servers is unencrypted, which leaves it vulnerable to attacks, especially with cases of attackers hiding in HTTPS traffic.
- **SPOF with MySQL Server**: Having only one database server capable of accepting writes is a SPOF even with replica databases. There will be a lot of load on that one server for writing operations, which can reduce performance.
- **Multiple Servers with the same components**: They are all identical, and one attack that takes down one server will affect the other. There’s also the issue of all the servers being on one machine, which means that when that one machine is down, all the internal servers will be affected.