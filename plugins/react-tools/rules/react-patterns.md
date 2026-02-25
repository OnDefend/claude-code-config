---
paths:
  - "**/src/**/*.jsx"
  - "**/src/**/*.tsx"
  - "**/src/**/*.js"
---

# React Development Patterns

## State Management

Always use these hooks:
```jsx
const { accessToken } = useContext(DataContext);
const current_customer = useAppSelector((state) => state.customer);
```

## API Requests

Always include customer UUID in API paths:
```jsx
const res = await getRequest(
  `/react/api/${current_customer.uuid}/endpoint`,
  accessToken
);
```

## Data Fetching

Use useEffect with proper dependencies:
```jsx
useEffect(() => {
  fetchData();
}, [current_customer, accessToken, reload]);
```

## Common Imports

```jsx
// MUI
import { Box, Paper, Typography, Button } from "@mui/material";

// Icons
import { FaPlus, FaTrashAlt, FaEdit } from "react-icons/fa";

// Internal
import { DataContext } from "../../../Context/dataContext";
import { getRequest, postRequest } from "../../../Helpers/httpRequests";
import { useAppSelector } from "../../../Redux/app/hooks";
```

## Toast Notifications

Wrap async operations with toast.promise for user feedback.
