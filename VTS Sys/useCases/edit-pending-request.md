# Use Case: Edit Pending Request

## Description
**Actor:** Employee  
**Goal:** Employee edits title, comments, or dates of a pending request  

### Preconditions:
- Request status = **Pending approval**
- Employee is authenticated

### Main Flow:
1. Employee logs into VTS.
2. System shows vacation requests and balances.
3. Employee selects a pending request.
4. System shows editable form (title, dates, description).
5. Employee edits fields and submits changes.
6. If employee selects delete/withdraw instead, flow redirects to Withdraw Request.
7. System validates updated details and saves changes.

---

## Flowchart Diagram

```mermaid
flowchart TD
    A[Start] --> B[Employee logs into VTS]
    B --> C[System displays vacation requests]
    C --> D[Employee selects pending request]
    D --> E[System shows editable form]
    E --> F{Save or Withdraw?}
    F -->|Withdraw| G[Follow Withdraw Request use case]
    F -->|Save| H[Validate changes]
    H --> I{Validation OK?}
    I -->|No| E
    I -->|Yes| J[Save edits and update request]
    J --> K[End]
```

## Sequence Diagram 

``` mermaid

sequenceDiagram
    participant E as Employee
    participant S as VTS System
    participant DB as Database

    E->>S: Select pending request to edit
    S-->>E: Display editable fields
    E->>S: Submit edited data
    
    S->>S: Validate data
    alt Invalid
        S-->>E: Display correction errors
    else Valid
        S->>DB: Update request record
        DB-->>S: Success
        S-->>E: Return to home screen
    end
```
## Pseudocode


    START

    PendingRequest = Employee.selectPendingRequest()

    IF Employee.editsInformation THEN
        IF VTS.validateChanges THEN
            VTS.updateRequest(PendingRequest)
        ELSE
            Display(errors)
        END IF
    ELSE IF Employee.withdraws THEN
        Follow Withdraw Request use case
    END IF

    END