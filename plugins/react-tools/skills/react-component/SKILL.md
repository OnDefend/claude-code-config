---
name: react-component
description: Scaffold new React page components and feature modules following BlindspotWeb patterns
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, Write
---

# React Component Scaffolder

Generate new React page components and feature modules following established patterns.

## Skill Invocation

```
/react-component <component-type> <name> [description]
```

**Component Types:**
- `page` - Full page component with data fetching
- `list-page` - Page with data table/grid
- `form-page` - Page with form for creating/editing
- `detail-page` - Page showing single item details
- `modal` - Modal dialog component
- `card` - Card component for displaying items

**Examples:**
- `/react-component page Notifications`
- `/react-component list-page Alerts "Alert management page"`
- `/react-component form-page CreateEndpoint`

## Key Patterns

### State Management
```jsx
const { accessToken } = useContext(DataContext);
const current_customer = useAppSelector((state) => state.customer);
```

### API Requests
```jsx
const res = await getRequest(
  `/react/api/${current_customer.uuid}/...`,
  accessToken
);
```

### Reload Pattern
```jsx
const [reload, setReload] = useState(false);
// After mutation:
setReload((prev) => !prev);
```

### Toast Notifications
```jsx
const res = await toast.promise(
  postRequest(...),
  {
    pending: "Saving...",
    success: "Saved successfully",
    error: "Failed to save",
  }
);
```

## List Page Template

```jsx
import { useContext, useEffect, useState } from "react";
import { Box, Paper, Typography } from "@mui/material";
import { toast } from "react-toastify";
import { FaPlus } from "react-icons/fa";
import TextButton from "../../../Components/Buttons/TextButton";
import { DataContext } from "../../../Context/dataContext";
import { getRequest } from "../../../Helpers/httpRequests";
import { useAppSelector } from "../../../Redux/app/hooks";

const {ComponentName} = () => {
  const { accessToken } = useContext(DataContext);
  const current_customer = useAppSelector((state) => state.customer);

  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);
  const [reload, setReload] = useState(false);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      const res = await getRequest(
        `/react/api/${current_customer.uuid}/{endpoint}`,
        accessToken
      );
      if (res.status === 200) {
        setItems(res.data.items);
      }
      setLoading(false);
    };
    fetchData();
  }, [current_customer, accessToken, reload]);

  return (
    <Box>
      <Typography variant="h4">{Page Title}</Typography>
      {/* Content */}
    </Box>
  );
};

export default {ComponentName};
```

## Verification Checklist

- [ ] Component file created
- [ ] Index file for re-export
- [ ] Uses DataContext for accessToken
- [ ] Uses useAppSelector for customer
- [ ] API paths include customer UUID
- [ ] Loading/empty states handled
- [ ] Route registered if page component
