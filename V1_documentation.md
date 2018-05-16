### Endpoints

#### Register A New User

    POST /api/v1/users

##### Required data
    user:
        - email: string, required
        - password: string, required
        - password_confirmation: :string, required
        - grand_type: string, required, default: 'password'

##### Sample Request:

    curl -X POST http://localhost:3000/api/v1/users -F 'user[password]=123456789' -F grand_type=password -F 'user[email]=user2@gmail.com' -F 'user[password_confirmation]=123456789'

##### Sample Response:

- Succeeded, need to activate account: <HTTP status 200>

```
    {
        "message":  string, Ex: "You will receive an email with instructions for how to confirm your email address in a few minutes."
    }
```
- Failed: <HTTP status 400>

```
    {
        "error_message": string, Ex: "Email is taken"
    }
    
```

- Successfully created and confirmed: <HTTP status code 201>
NOTE: likely not used because all users need to confirm the account

```
    {
        auth_token: <string>
        email: <string>
    }
```
