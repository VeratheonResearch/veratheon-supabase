# Supabase Email Templates

These email templates should be configured through the **Supabase Dashboard**, not via SQL migrations.

**To apply these templates:**
1. Go to your Supabase project dashboard
2. Navigate to **Authentication** > **Email Templates**
3. Select each template tab (Confirm signup, Invite user, Magic Link, etc.)
4. Copy the HTML from the sections below
5. Paste into the "Message body" field in the dashboard
6. Click "Save" for each template

---

## 1. Confirm Signup

```html
<h2>Confirm your signup</h2>

<p>Follow this link to confirm your user:</p>
<p><a href="{{ .ConfirmationURL }}">Confirm your mail</a></p>
```

**Custom HTML (Light Theme):**

```html
<html>
<head>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      background-color: #f5f5f5;
      color: #1f2937;
    }
    .container {
      max-width: 600px;
      margin: 40px auto;
      background-color: #ffffff;
      border: 1px solid #e5e7eb;
      border-radius: 12px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
      overflow: hidden;
    }
    .header {
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      padding: 32px 24px;
      text-align: center;
    }
    .header h1 {
      margin: 0;
      color: #ffffff;
      font-size: 28px;
      font-weight: 700;
    }
    .content {
      padding: 32px 24px;
    }
    .content h2 {
      color: #5b21b6;
      font-size: 20px;
      font-weight: 600;
      margin: 0 0 16px 0;
    }
    .content p {
      color: #4b5563;
      font-size: 15px;
      line-height: 1.6;
      margin: 0 0 20px 0;
    }
    .button {
      display: inline-block;
      padding: 12px 32px;
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      color: #ffffff;
      text-decoration: none;
      border-radius: 8px;
      font-weight: 600;
      font-size: 16px;
      box-shadow: 0 2px 4px rgba(91, 33, 182, 0.3);
      transition: all 0.3s ease;
    }
    .button:hover {
      box-shadow: 0 4px 8px rgba(91, 33, 182, 0.4);
    }
    .footer {
      padding: 24px;
      text-align: center;
      border-top: 1px solid #e5e7eb;
      background-color: #f9fafb;
    }
    .footer p {
      color: #6b7280;
      font-size: 13px;
      margin: 0;
    }
    .badge {
      display: inline-block;
      padding: 4px 12px;
      background-color: rgba(255, 255, 255, 0.25);
      color: #ffffff;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 600;
      margin-top: 8px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Veratheon Research</h1>
    </div>
    <div class="content">
      <h2>Confirm Your Signup</h2>
      <p>Welcome to Veratheon Research!</p>
      <p>To complete your registration and start analyzing, please confirm your email address by clicking the button below:</p>
      <p style="text-align: center; margin: 32px 0;">
        <a href="{{ .ConfirmationURL }}" class="button">Confirm Your Email</a>
      </p>
      <p style="color: #6b7280; font-size: 13px;">If you didn't create an account, you can safely ignore this email.</p>
    </div>
    <div class="footer">
      <p>© 2025 Veratheon Research. All rights reserved.</p>
    </div>
  </div>
</body>
</html>
```

---

## 2. Invite User

```html
<html>
<head>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      background-color: #f5f5f5;
      color: #1f2937;
    }
    .container {
      max-width: 600px;
      margin: 40px auto;
      background-color: #ffffff;
      border: 1px solid #e5e7eb;
      border-radius: 12px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
      overflow: hidden;
    }
    .header {
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      padding: 32px 24px;
      text-align: center;
    }
    .header h1 {
      margin: 0;
      color: #ffffff;
      font-size: 28px;
      font-weight: 700;
    }
    .content {
      padding: 32px 24px;
    }
    .content h2 {
      color: #5b21b6;
      font-size: 20px;
      font-weight: 600;
      margin: 0 0 16px 0;
    }
    .content p {
      color: #4b5563;
      font-size: 15px;
      line-height: 1.6;
      margin: 0 0 20px 0;
    }
    .button {
      display: inline-block;
      padding: 12px 32px;
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      color: #ffffff;
      text-decoration: none;
      border-radius: 8px;
      font-weight: 600;
      font-size: 16px;
      box-shadow: 0 2px 4px rgba(91, 33, 182, 0.3);
    }
    .footer {
      padding: 24px;
      text-align: center;
      border-top: 1px solid #e5e7eb;
      background-color: #f9fafb;
    }
    .footer p {
      color: #6b7280;
      font-size: 13px;
      margin: 0;
    }
    .badge {
      display: inline-block;
      padding: 4px 12px;
      background-color: rgba(255, 255, 255, 0.25);
      color: #ffffff;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 600;
      margin-top: 8px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Veratheon Research</h1>
    </div>
    <div class="content">
      <h2>You've Been Invited</h2>
      <p>You've been invited to join Veratheon Research.</p>
      <p>Click the button below to accept your invitation and set up your account:</p>
      <p style="text-align: center; margin: 32px 0;">
        <a href="{{ .ConfirmationURL }}" class="button">Accept Invitation</a>
      </p>
      <p style="color: #6b7280; font-size: 13px;">If you didn't expect this invitation, you can safely ignore this email.</p>
    </div>
    <div class="footer">
      <p>© 2025 Veratheon Research. All rights reserved.</p>
    </div>
  </div>
</body>
</html>
```

---

## 3. Magic Link

```html
<html>
<head>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      background-color: #f5f5f5;
      color: #1f2937;
    }
    .container {
      max-width: 600px;
      margin: 40px auto;
      background-color: #ffffff;
      border: 1px solid #e5e7eb;
      border-radius: 12px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
      overflow: hidden;
    }
    .header {
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      padding: 32px 24px;
      text-align: center;
    }
    .header h1 {
      margin: 0;
      color: #ffffff;
      font-size: 28px;
      font-weight: 700;
    }
    .content {
      padding: 32px 24px;
    }
    .content h2 {
      color: #5b21b6;
      font-size: 20px;
      font-weight: 600;
      margin: 0 0 16px 0;
    }
    .content p {
      color: #4b5563;
      font-size: 15px;
      line-height: 1.6;
      margin: 0 0 20px 0;
    }
    .button {
      display: inline-block;
      padding: 12px 32px;
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      color: #ffffff;
      text-decoration: none;
      border-radius: 8px;
      font-weight: 600;
      font-size: 16px;
      box-shadow: 0 2px 4px rgba(91, 33, 182, 0.3);
    }
    .footer {
      padding: 24px;
      text-align: center;
      border-top: 1px solid #e5e7eb;
      background-color: #f9fafb;
    }
    .footer p {
      color: #6b7280;
      font-size: 13px;
      margin: 0;
    }
    .badge {
      display: inline-block;
      padding: 4px 12px;
      background-color: rgba(255, 255, 255, 0.25);
      color: #ffffff;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 600;
      margin-top: 8px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Veratheon Research</h1>
    </div>
    <div class="content">
      <h2>Sign In to Your Account</h2>
      <p>Click the button below to sign in to your account:</p>
      <p style="text-align: center; margin: 32px 0;">
        <a href="{{ .ConfirmationURL }}" class="button">Sign In to Veratheon</a>
      </p>
      <p style="color: #6b7280; font-size: 13px;">This link will expire in 1 hour. If you didn't request this, please ignore this email.</p>
    </div>
    <div class="footer">
      <p>© 2025 Veratheon Research. All rights reserved.</p>
    </div>
  </div>
</body>
</html>
```

---

## 4. Change Email Address

```html
<html>
<head>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      background-color: #f5f5f5;
      color: #1f2937;
    }
    .container {
      max-width: 600px;
      margin: 40px auto;
      background-color: #ffffff;
      border: 1px solid #e5e7eb;
      border-radius: 12px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
      overflow: hidden;
    }
    .header {
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      padding: 32px 24px;
      text-align: center;
    }
    .header h1 {
      margin: 0;
      color: #ffffff;
      font-size: 28px;
      font-weight: 700;
    }
    .content {
      padding: 32px 24px;
    }
    .content h2 {
      color: #5b21b6;
      font-size: 20px;
      font-weight: 600;
      margin: 0 0 16px 0;
    }
    .content p {
      color: #4b5563;
      font-size: 15px;
      line-height: 1.6;
      margin: 0 0 20px 0;
    }
    .button {
      display: inline-block;
      padding: 12px 32px;
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      color: #ffffff;
      text-decoration: none;
      border-radius: 8px;
      font-weight: 600;
      font-size: 16px;
      box-shadow: 0 2px 4px rgba(91, 33, 182, 0.3);
    }
    .footer {
      padding: 24px;
      text-align: center;
      border-top: 1px solid #e5e7eb;
      background-color: #f9fafb;
    }
    .footer p {
      color: #6b7280;
      font-size: 13px;
      margin: 0;
    }
    .badge {
      display: inline-block;
      padding: 4px 12px;
      background-color: rgba(255, 255, 255, 0.25);
      color: #ffffff;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 600;
      margin-top: 8px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Veratheon Research</h1>
    </div>
    <div class="content">
      <h2>Confirm Email Change</h2>
      <p>You requested to change your email address.</p>
      <p>Click the button below to confirm this change:</p>
      <p style="text-align: center; margin: 32px 0;">
        <a href="{{ .ConfirmationURL }}" class="button">Confirm New Email</a>
      </p>
      <p style="color: #6b7280; font-size: 13px;">If you didn't request this change, please contact support immediately.</p>
    </div>
    <div class="footer">
      <p>© 2025 Veratheon Research. All rights reserved.</p>
    </div>
  </div>
</body>
</html>
```

---

## 5. Reset Password

```html
<html>
<head>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      background-color: #f5f5f5;
      color: #1f2937;
    }
    .container {
      max-width: 600px;
      margin: 40px auto;
      background-color: #ffffff;
      border: 1px solid #e5e7eb;
      border-radius: 12px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
      overflow: hidden;
    }
    .header {
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      padding: 32px 24px;
      text-align: center;
    }
    .header h1 {
      margin: 0;
      color: #ffffff;
      font-size: 28px;
      font-weight: 700;
    }
    .content {
      padding: 32px 24px;
    }
    .content h2 {
      color: #5b21b6;
      font-size: 20px;
      font-weight: 600;
      margin: 0 0 16px 0;
    }
    .content p {
      color: #4b5563;
      font-size: 15px;
      line-height: 1.6;
      margin: 0 0 20px 0;
    }
    .button {
      display: inline-block;
      padding: 12px 32px;
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      color: #ffffff;
      text-decoration: none;
      border-radius: 8px;
      font-weight: 600;
      font-size: 16px;
      box-shadow: 0 2px 4px rgba(91, 33, 182, 0.3);
    }
    .footer {
      padding: 24px;
      text-align: center;
      border-top: 1px solid #e5e7eb;
      background-color: #f9fafb;
    }
    .footer p {
      color: #6b7280;
      font-size: 13px;
      margin: 0;
    }
    .badge {
      display: inline-block;
      padding: 4px 12px;
      background-color: rgba(255, 255, 255, 0.25);
      color: #ffffff;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 600;
      margin-top: 8px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Veratheon Research</h1>
      <span class="badge">Password Reset</span>
    </div>
    <div class="content">
      <h2>Reset Your Password</h2>
      <p>You requested to reset your password.</p>
      <p>Click the button below to create a new password:</p>
      <p style="text-align: center; margin: 32px 0;">
        <a href="{{ .ConfirmationURL }}" class="button">Reset Password</a>
      </p>
      <p style="color: #6b7280; font-size: 13px;">If you didn't request this, you can safely ignore this email.</p>
    </div>
    <div class="footer">
      <p>© 2025 Veratheon Research. All rights reserved.</p>
    </div>
  </div>
</body>
</html>
```

---

## 6. Reauthentication

```html
<html>
<head>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      background-color: #f5f5f5;
      color: #1f2937;
    }
    .container {
      max-width: 600px;
      margin: 40px auto;
      background-color: #ffffff;
      border: 1px solid #e5e7eb;
      border-radius: 12px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
      overflow: hidden;
    }
    .header {
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      padding: 32px 24px;
      text-align: center;
    }
    .header h1 {
      margin: 0;
      color: #ffffff;
      font-size: 28px;
      font-weight: 700;
    }
    .content {
      padding: 32px 24px;
    }
    .content h2 {
      color: #5b21b6;
      font-size: 20px;
      font-weight: 600;
      margin: 0 0 16px 0;
    }
    .content p {
      color: #4b5563;
      font-size: 15px;
      line-height: 1.6;
      margin: 0 0 20px 0;
    }
    .button {
      display: inline-block;
      padding: 12px 32px;
      background: linear-gradient(135deg, #5b21b6 0%, #6d28d9 100%);
      color: #ffffff;
      text-decoration: none;
      border-radius: 8px;
      font-weight: 600;
      font-size: 16px;
      box-shadow: 0 2px 4px rgba(91, 33, 182, 0.3);
    }
    .footer {
      padding: 24px;
      text-align: center;
      border-top: 1px solid #e5e7eb;
      background-color: #f9fafb;
    }
    .footer p {
      color: #6b7280;
      font-size: 13px;
      margin: 0;
    }
    .badge {
      display: inline-block;
      padding: 4px 12px;
      background-color: rgba(255, 255, 255, 0.25);
      color: #ffffff;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 600;
      margin-top: 8px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Veratheon Research</h1>
    </div>
    <div class="content">
      <h2>Confirm Your Identity</h2>
      <p>We need to verify your identity before proceeding.</p>
      <p>Click the button below to confirm:</p>
      <p style="text-align: center; margin: 32px 0;">
        <a href="{{ .ConfirmationURL }}" class="button">Verify Identity</a>
      </p>
      <p style="color: #6b7280; font-size: 13px;">If you didn't request this, please contact support.</p>
    </div>
    <div class="footer">
      <p>© 2025 Veratheon Research. All rights reserved.</p>
    </div>
  </div>
</body>
</html>
```

---
