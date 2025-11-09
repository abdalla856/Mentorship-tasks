# Use Case: Withdraw Vacation Request

## ✅ Description
**Use case name:** Withdraw Request  
**Actor:** Employee  
**Goal:** Employee wants to withdraw a previously submitted request that is still pending approval.  

### Preconditions:
- A vacation request exists with status **Pending Approval**
- Employee is authenticated and authorized in VTS

### Main Flow:
1. Employee navigates to the VTS home page.
2. System displays list of vacation requests with current status.
3. Employee selects a request that is pending approval.
4. System prompts employee to confirm withdrawal.
5. Employee confirms request withdrawal.
6. System removes request from manager’s pending list.
7. System sends notification email to the manager.
8. System updates request status → **Withdrawn**

---

## 🧠 Flowchart Diagram

```mermaid
flowchart TD
    A[Start] --> B[Employee logs into VTS portal]
    B --> C[System displays employee vacation requests and statuses]
    C --> D[Employee selects a Pending vacation request]
    D --> E[System asks for confirmation]
    E --> F{Employee confirms?}
    F -->|No| G[Return to VTS home page]
    F -->|Yes| H[System updates request status to Withdrawn]
    H --> I[System removes request from manager pending list]
    I --> J[Send email notification to manager]
    J --> K[End]
```
## Sequence Diagram;

```mermaid
sequenceDiagram
    participant E as Employee
    participant S as VTS System
    participant DB as Database
    participant Email as Email Service
    participant M as Manager

    E->>S: Login and navigate to VTS
    S->>DB: Fetch vacation requests
    DB-->>S: Requests list
    S-->>E: Display request history
    
    E->>S: Select pending request to withdraw
    S-->>E: Confirm withdraw action
    E->>S: Confirm withdrawal
    
    S->>DB: Update request status to Withdrawn
    S->>Email: Notify manager
    Email-->>M: Email received
```
## Pseudocode

    START

    IF Employee.isAuthenticated THEN
        Display(requests)
    ELSE
        EXIT
    END IF

    PendingRequest = Employee.selectPendingRequest()

    Confirm = Employee.confirmWithdraw()

    IF Confirm == TRUE THEN
        VTS.updateRequestStatus(PendingRequest, "Withdrawn")
        VTS.removeFromManagerPendingList(PendingRequest)
        VTS.notifyManager(PendingRequest)
    END IF

    END
