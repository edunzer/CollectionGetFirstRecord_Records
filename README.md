# CollectionGetFirstRecord_Records

A lightweight Salesforce Apex **Invocable Action** that returns the **first record** from a collection of records.  
Built for use in **Salesforce Flow** to simplify handling record collections when only a single record is needed.

---

## Overview

`CollectionGetFirstRecord_Records` accepts a list of records (`List<SObject>`) and returns the **first full record** from that list.  
If the input collection is null or empty, the action safely returns `null`.

This utility helps reduce unnecessary Flow loops and assignments.

---

## Features

- Flow-ready using `@InvocableMethod`
- Works with **any SObject**
- Null-safe and empty-collection safe
- No DML or SOQL
- Uses `with sharing` to respect org security

---

## Common Use Cases

- Extract a single record from a **Get Records** result in Flow
- Simplify Flow logic where only the first record is required
- Reusable utility across multiple Flows and objects
