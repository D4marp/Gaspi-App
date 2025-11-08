# 🧪 Mock Authentication Test Credentials

The app now uses **static/mock authentication** for testing. You can login with any of these test accounts:

## Test Accounts by Role

### 1. **Super Admin**
```
Email: superadmin@gaspi.com
Password: anything (mock ignores password)
Role: super_admin
```

### 2. **Admin**
```
Email: admin@gaspi.com
Password: anything
Role: admin
```

### 3. **Maintenance Technician**
```
Email: maintenance@gaspi.com
Password: anything
Role: maintenance
```

### 4. **Supervisor**
```
Email: supervisor@gaspi.com
Password: anything
Role: supervisor
```

### 5. **Coordinator (Default)**
```
Email: coordinator@gaspi.com (or any other email)
Password: anything
Role: coordinator
```

## How It Works

✅ **Mock Mode is ENABLED** (in `auth_remote_datasource.dart`)
- The app detects keywords in the email address to determine the role
- No real API is called
- Login is instant (simulates 1 second network delay)
- Each role sees a different home page and menu options

## Features by Role

| Role | Home Page | Menu Items | Access |
|------|-----------|-----------|--------|
| Super Admin | HomeAdminPage | Home, Reg. Assets, Maintenance, Account | All features |
| Admin | HomeAdminPage | Home, Reg. Assets, Maintenance, Account | All admin features |
| Maintenance | MaintenancePage | Home, Tasks, Schedule, Account | Maintenance only |
| Supervisor | SupervisorPage | Home, QR Scan, Report, Account | Reports & QR |
| Coordinator | CoordinatorPage | Limited menu | Basic access |

## Switching Roles

To test different roles:
1. Click **Logout** (gear icon in header or account menu)
2. Enter a different test email above
3. The app will automatically log you in with that role

## To Switch to Real API

When you're ready to use the real API:

1. Open `lib/features/auth/data/datasources/auth_remote_datasource.dart`
2. Change line:
   ```dart
   return AuthRemoteDataSource(apiService, useMock: true);
   ```
   To:
   ```dart
   return AuthRemoteDataSource(apiService, useMock: false);
   ```
3. Run: `flutter pub run build_runner build --delete-conflicting-outputs`
4. Restart the app

---

**Happy Testing! 🚀**
