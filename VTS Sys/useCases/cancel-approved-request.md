# Use Case: Cancel Approved Request

##  Description
**Actor:** Employee  
**Goal:** Employee wants to cancel a previously approved request.  

### Preconditions:
- Request status is **Approved**
- The vacation has not yet occurred OR occurred within the last 5 business days
- Employee is authenticated

### Main Flow:
1. Employee navigates to the VTS home page.
2. System displays vacation requests and balances.
3. Employee selects an already approved request scheduled in future (or recent past).
4. System prompts confirmation (if in recent past → prompt additional description).
5. Employee confirms cancellation.
6. Request is canceled and vacation hours are returned to employee balance.
7. System sends notification email to manager.
8. Employee is returned to main VTS page.

---

##  Flowchart Diagram

```mermaid
flowchart TD
    A[Start] --> B[Employee logs into VTS portal]
    B --> C[System displays vacation requests]
    C --> D[Employee selects an Approved request]
    D --> E{Future or Past?}
    E -->|Future| F[Confirm cancellation]
    E -->|Recent Past| G[Confirm and enter cancellation explanation]
    F --> H[Update request as Canceled]
    G --> H[Update request as Canceled]
    H --> I[Restore hours to employee balance]
    I --> J[Notify manager]
    J --> K[End]
```
##  Sequence Diagram

``` mermaid
    sequenceDiagram
    participant E as Employee
    participant S as VTS System
    participant DB as Database
    participant Email as Email Service
    participant M as Manager

    E->>S: Log in & navigate to VTS
    S->>DB: Retrieve approved vacation requests
    DB-->>S: Return request list
    S-->>E: Display vacation requests

    E->>S: Select approved request to cancel
    S->>S: Check request date (future or recent past)

    alt Request is in the future
        S-->>E: Ask for cancellation confirmation
    else Request is in the recent past
        S-->>E: Ask for confirmation + request explanation
        E->>S: Provide cancellation explanation
    end

    E->>S: Confirm cancellation
    S->>DB: Update request status to Canceled
    S->>DB: Restore vacation balance
    S->>Email: Send cancellation notification to manager
    Email-->>M: Notification received
```

## Pseudocode


    START

    IF Employee.isAuthenticated THEN
        Display(approvedRequests)
    ELSE
        EXIT
    END IF

    Request = Employee.selectApprovedRequest()

    // Determine whether request is in the future or recent past (<= 5 business days)
    IF VTS.isFuture(Request.date) THEN
        Confirm = Employee.confirmCancellation()
    ELSE IF VTS.isRecentPast(Request.date) THEN
        Confirm = Employee.confirmCancellation()
        Reason  = Employee.enterCancellationReason()
    END IF

    // If employee approves cancellation
    IF Confirm == TRUE THEN
        VTS.cancelRequest(Request)

        // Give hours back to employee
        VTS.restoreBalance(Request)

        // Notify direct manager
        VTS.notifyManager(Request, Reason)
    END IF

    END
