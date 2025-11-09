# Vacation-Tracking-System
A web-based system for managing employee leave requests and approvals.

### Vision

    A Vacation Tracking System (VTS) will provide individual employees with the
    capability to manage their own vacation time, sick leave, and personal time off,
    without having to be an expert in company policy or the local facility’s leave
    policies.

### Functional requirements
    1. Implements a flexible rules-based system for validating and verifying leave time requests
    2. Enables manager approval (optional)
    3. Provides access to requests for the previous calendar year, and allows
    requests to be made up to a year and a half in the future
    4. Uses e-mail notification to request manager approval and notify employees
    of request status changes
    5. Uses existing hardware and middleware
    6.  implemented as an extension to the existing intranet portal system, and
    uses the portal’s single-sign-on mechanisms for all authentication
    7. Keeps activity logs for all transactions
    8. Enables the HR and system administration personnel to override all actions
    restricted by rules, with logging of those overrides
    9. Allows managers to directly award personal leave time (with system-set
    limits)
    Provides a Web service interface for other internal systems to query any
    10. given employee’s vacation request summary
    11. Interfaces with the HR department legacy systems to retrieve required
    employee information and changes
### Non-Functional requirments
    
    1. Security -> authorized users,
    2.  Compatibility - > (Uses existing hardware and middleware ,implemented as an extension , integrate seamlessly with the corporate intranet)
    3. Usability -> Intuitive web interface requiring minimal training.
    4. Reliability & Availability -> The system should maintain high uptime and recover quickly from failures
    5. Performance – The system should handle concurrent requests without noticeable delay.

### Constraints 
    1. Authorized users
    2. Vacations and sick leave based on employment agreement.
## Domain 

    Human Resources (HR) / Employee Management
## System actors 
    1. Employee: The main user of this system. An employee uses this system to manage his or her vacation time.

    2. Manager: An employee who has all the abilities and goals of a regular employee, but with the added responsibility of approving vacation requests for immediate subordinates. A manager may award subordinates comptime, subject to certain limits set in the system.

    3. Clerk: A member of the HR department who has sufficient rights to view employees’ personal data and is responsible for ensuring that employees’information in all HR systems is up to date and correct. An HR clerk can add or remove nearly any record in the system. In the real world, HR clerks may or may not be employees; however, if they are employees, they use two separate login IDs to manage these two different roles.

    4. System Admin: A role responsible for the smooth running of the system’s technical resources (e.g., Web server, database) and for collecting and archiving all log files.


## ERD MODEL

```mermaid
erDiagram
    EMPLOYEE ||--o{ VACATION_REQUEST : "submits"
    EMPLOYEE ||--|| VACATION_BALANCE : "has"
    EMPLOYEE ||--o{ EMPLOYEE : "manages"
    VACATION_REQUEST ||--|| VACATION_CATEGORY : "of type"

    EMPLOYEE {
        int employeeID PK
        string name
        string email
        string department
        int managerID FK "Points to another EMPLOYEE"
    }

    VACATION_CATEGORY {
        int categoryID PK
        string name
        string description
        boolean requiresHRApproval
    }

    VACATION_REQUEST {
        int requestID PK
        int employeeID FK
        int managerID FK
        int categoryID FK
        date startDate
        date endDate
        float hours
        string title
        string description
        string status   "Pending, Approved, HR_Pending, Rejected, Withdrawn, Canceled"
        datetime submittedAt
        string Reason "For withdraw or cancelling"
    }

    VACATION_BALANCE {
        int balanceID PK
        int employeeID FK
        float totalHours
        float usedHours
        float remainingHours
    }
```
## State Machine Diagram
```mermaid
stateDiagram-v2
    [*] --> Pending

    Pending --> Withdrawn : Employee Withdraws
    Pending --> Rejected : Manager Rejects

    Pending --> Approved : Manager Approves

    Approved --> Canceled : Employee Cancels

    Approved --> HR_Pending : requiresHRApproval == true
    HR_Pending --> HR_Approved : HR Clerk approves
    HR_Pending --> Rejected : HR Clerk rejects

    Withdrawn --> [*]
    Canceled --> [*]
    Rejected --> [*]
    HR_Approved --> [*]

```



## Sequence Diagram


```mermaid
sequenceDiagram
    participant E as Employee
    participant S as VTS System
    participant DB as Database
    participant M as Manager
    participant HR as HR Clerk
    participant Email as Email Service

    %% --- Employee submits request ---
    E->>S: Submit vacation request (category, dates, hours)
    S->>DB: Save request (status = Pending)
    S->>Email: Notify Manager (approval needed)

    %% --- Manager action ---
    M->>S: Approve or Reject request
    S->>DB: Validate transition
    alt Approved
        S->>DB: Update request status = Approved
        S->>DB: Deduct hours from employee balance
        S->>Email: Notify employee
        DB-->>S: Check requiresHRApproval
        alt requiresHRApproval == true
            S->>DB: Update status = HR_Pending
            S->>Email: Notify HR Clerk
        end
    else Rejected
        S->>DB: Update request status = Rejected
        S->>Email: Notify employee
    end

    %% --- HR optional approval ---
    alt Request requires HR
        HR->>S: Approve or Reject
        S->>DB: Update status (HR_Approved or Rejected)
        S->>Email: Notify employee
    end

    %% --- Employee withdraws pending request ---
    E->>S: Withdraw request
    alt Request status = Pending
        S->>DB: Update status = Withdrawn
        S->>DB: Restore hours
        S-->>E: Success
    end

    %% --- Employee cancels approved request ---
    E->>S: Cancel approved request
    alt Request in future or recent past
        S->>DB: Update status = Canceled
        S->>DB: Restore hours
        S->>Email: Notify Manager
        S-->>E: Success
    else Request too old
        S-->>E: Error (cannot cancel)
    end

    %% --- Employee edits pending request ---
    E->>S: Edit request
    alt Request status = Pending
        S->>DB: Update request details
        S-->>E: Success
    else
        S-->>E: Error (cannot edit)
    end

```

## UI Mocks

 - [VTS Figma Mocks](https://www.figma.com/make/ZBSa7egj785uKbXE7OhYIp/Vacation-Tracking-System-UI?t=Y4exO36gPmWpBbfY&fullscreen=1)




## Documentation 

 - [Manage Time use case](useCases/Manage-time.md)
 - [Widthdraw Reuest](useCases/withdraw-request.md)
 - [Cancel Approved Request](useCases/cancel-approved-request.md)
 - [Edit Pending Request](useCases/edit-pending-request.md)
