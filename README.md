#  Hospital Health Record Management System

##  Overview

A Java-based Hospital Health Record Management System designed to manage and organize patient and clinical data efficiently. This project demonstrates a fully normalized relational database (3NF) integrated with a modular Java application using JDBC and MySQL.

---

##  Features

* Complete **CRUD operations** for:

  * Patients
  * Doctors
  * Appointments
  * Medical Records
  * Prescriptions
* **Menu-driven CLI interface**
* **Data validation** for reliable input handling
* **Analytics & reporting modules**
* Structured and modular codebase

---

##  Database Design

* Fully normalized up to **Third Normal Form (3NF)**
* Contains **8 core relational tables**
* Ensures:

  * Reduced redundancy
  * Data consistency
  * Optimized query performance

---

##  Tech Stack

* **Java** (Core + OOP)
* **JDBC** (Database connectivity)
* **MySQL** (Relational Database)

---

##  Installation & Setup

### 1. Clone the repository

```bash
git clone https://github.com/your-username/hospital-record-system.git
cd hospital-record-system
```

### 2. Setup MySQL Database

* Create a database:

```sql
CREATE DATABASE hospital_db;
```

* Import the provided SQL schema file

### 3. Configure Database Connection

Update your JDBC credentials in:

```
DBConnection.java
```

Example:

```java
String url = "jdbc:mysql://localhost:3306/hospital_db";
String user = "root";
String password = "your_password";
```

### 4. Run the Application

Compile and run:

```bash
javac Main.java
java Main
```
---
###UI OUTLOOK



![UI Out](https://github.com/zodiac9363/Hospital-Health-Record-Management-System/blob/main/Picture1.png)


![UI](https://github.com/zodiac9363/Hospital-Health-Record-Management-System/blob/main/Picture2.png)

![UI](https://github.com/zodiac9363/Hospital-Health-Record-Management-System/blob/main/Picture3.png](https://github.com/zodiac9363/Hospital-Health-Record-Management-System/blob/main/3.jpg)


---

##  Modules

* Patient Management
* Doctor Management
* Appointment Scheduling
* Medical Records Tracking
* Prescription Handling
* Reporting & Analytics

---

##  Project Structure

```
hospital-record-system/
│
├── src/
│   ├── db/              # Database connection
│   ├── models/          # Entity classes
│   ├── dao/             # Data access logic
│   ├── services/        # Business logic
│   └── Main.java
│
├── database/
│   └── schema.sql
│
├── docs/
│   └── ER-diagram.png
│
├── README.md
└── .gitignore
```

---

##  Learning Outcomes

* Practical implementation of **database normalization (3NF)**
* Hands-on experience with **JDBC and SQL integration**
* Understanding of **modular architecture in Java**
* Real-world simulation of healthcare data systems

---

##  Future Improvements

* GUI interface (JavaFX / Web-based)
* Role-based authentication system
* REST API integration
* Cloud database deployment

---

##  License

This project is intended for educational purposes.
