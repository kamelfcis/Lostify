# Postman Testing Guide for Login and Register

## Base URL
```
http://localhost:8000
```
*(If your server runs on a different port, adjust accordingly)*

---

## 1. Register (Sign Up) Endpoint

### Endpoint
```
POST http://localhost:8000/api/register/
```
*Alternative: `POST http://localhost:8000/api/signup/` (both work)*

### Headers
```
Content-Type: application/json
```

### Request Body (JSON)
```json
{
    "email": "user@example.com",
    "username": "testuser",
    "password": "securepassword123",
    "first_name": "John",
    "last_name": "Doe"
}
```

### Required Fields
- `email` (string, required)
- `username` (string, required)
- `password` (string, required)
- `first_name` (string, required)
- `last_name` (string, required)

### Expected Success Response (201 Created)
```json
{
    "message": "Account Created Successfully"
}
```

### Expected Error Response (400 Bad Request)
```json
{
    "email": ["This field is required."],
    "username": ["This field is required."],
    ...
}
```

---

## 2. Login Endpoint

### Endpoint
```
POST http://localhost:8000/api/login/
```

### Headers
```
Content-Type: application/json
```

### Request Body (JSON)
```json
{
    "username": "testuser",
    "password": "securepassword123"
}
```

### Required Fields
- `username` (string, required)
- `password` (string, required)

### Expected Success Response (200 OK)
```json
{
    "user": {
        "id": 1,
        "username": "testuser"
    },
    "tokens": {
        "refresh": "eyJ0eXAiOiJKV1QiLCJhbGc...",
        "access": "eyJ0eXAiOiJKV1QiLCJhbGc..."
    }
}
```

### Expected Error Response (400 Bad Request)
```json
{
    "non_field_errors": ["Invalid credentials"]
}
```

---

## Step-by-Step Postman Instructions

### Testing Register:

1. **Open Postman** and create a new request
2. **Set Method**: Select `POST` from the dropdown
3. **Enter URL**: `http://localhost:8000/api/register/`
4. **Go to Headers tab**:
   - Key: `Content-Type`
   - Value: `application/json`
5. **Go to Body tab**:
   - Select `raw`
   - Select `JSON` from the dropdown
   - Paste the JSON body:
   ```json
   {
       "email": "test@example.com",
       "username": "testuser",
       "password": "testpass123",
       "first_name": "Test",
       "last_name": "User"
   }
   ```
6. **Click Send**
7. **Check Response**: You should see status `201 Created` with message "Account Created Successfully"

### Testing Login:

1. **Create a new request** in Postman
2. **Set Method**: Select `POST`
3. **Enter URL**: `http://localhost:8000/api/login/`
4. **Go to Headers tab**:
   - Key: `Content-Type`
   - Value: `application/json`
5. **Go to Body tab**:
   - Select `raw`
   - Select `JSON` from the dropdown
   - Paste the JSON body (use the username/password from register):
   ```json
   {
       "username": "testuser",
       "password": "testpass123"
   }
   ```
6. **Click Send**
7. **Check Response**: 
   - Status should be `200 OK`
   - You'll receive `access` and `refresh` tokens
   - **Save the `access` token** - you'll need it for authenticated requests

---

## Using the Access Token for Authenticated Requests

After logging in, you'll receive an `access` token. Use it in subsequent requests:

### Headers for Authenticated Requests:
```
Content-Type: application/json
Authorization: Bearer <your_access_token_here>
```

**Example:**
```
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGc...
```

---

## Quick Test Collection

### Test 1: Register a New User
- **URL**: `POST http://localhost:8000/api/register/`
- **Body**: 
```json
{
    "email": "newuser@test.com",
    "username": "newuser",
    "password": "password123",
    "first_name": "New",
    "last_name": "User"
}
```

### Test 2: Login with Registered User
- **URL**: `POST http://localhost:8000/api/login/`
- **Body**:
```json
{
    "username": "newuser",
    "password": "password123"
}
```

### Test 3: Login with Wrong Credentials (Error Test)
- **URL**: `POST http://localhost:8000/api/login/`
- **Body**:
```json
{
    "username": "wronguser",
    "password": "wrongpass"
}
```
- **Expected**: `400 Bad Request` with "Invalid credentials"

---

## Notes

- Make sure your Django server is running (`python manage.py runserver`)
- The access token is valid for **365 days** (as configured in your settings)
- The refresh token is valid for **366 days**
- Use the refresh token at `/api/token/refresh/` to get a new access token if needed
- For logout, use `POST /api/logout/` with the refresh token in the body

