# 🚀 AWS S3 Static Website CI/CD with GitHub Actions and CloudFront

This repository contains a **secure, production-grade CI/CD pipeline** for deploying a static website to **Amazon S3**, delivered via **Amazon CloudFront** with HTTPS and automatic cache invalidation. Authentication is done using **OIDC-based IAM Roles** — so **no access keys are stored or exposed**.

![Deploy to S3](https://github.com/RavikumarKamani74/aws-s3-static-site-cicd/actions/workflows/deploy.yml/badge.)

---

## 🔧 Key Features

- ✅ **CI/CD via GitHub Actions** – triggered on `main` branch pushes
- ✅ **OIDC-based authentication** – no AWS credentials stored
- ✅ **S3 static hosting** – deploys static HTML/CSS/JS
- ✅ **CloudFront CDN** – secure, global content delivery
- ✅ **Automatic cache invalidation** – no manual step after update
- ✅ **Least-privilege IAM role setup** – follows AWS security best practices

---

## 📁 Folder Structure

aws-s3-static-site-cicd/
├── .github/workflows/
│ └── deploy.yml # GitHub Actions workflow
├── index.html # Static website (landing page)
└── README.md


---

## 🛠️ Technologies Used

| Component         | Description                                 |
|------------------|---------------------------------------------|
| **Amazon S3**     | Hosts static HTML site                     |
| **Amazon CloudFront** | Distributes via CDN with HTTPS         |
| **GitHub Actions**| CI/CD workflow automation                  |
| **IAM OIDC Role** | Secure GitHub → AWS access (no secrets)   |
| **AWS CLI**       | Used by GitHub Actions for deployment      |

---

## 🔄 CI/CD Pipeline Workflow

1. **Push** to `main` triggers the GitHub Actions pipeline.
2. GitHub uses **OIDC** to securely assume an **IAM role** in your AWS account.
3. **Website files** are synced to the **S3 bucket**:  
   `ravikumar-s3-static-website`
4. The linked **CloudFront distribution** (`dq6ta8ipffudm.cloudfront.net`) is **invalidated**, so users see updates immediately.

---

## 🔐 IAM Role & Permissions

This IAM Role is used by GitHub via OIDC.

### ✅ Trust Policy

```json
{
  "Effect": "Allow",
  "Principal": {
    "Federated": "arn:aws:iam::358238714507:oidc-provider/token.actions.githubusercontent.com"
  },
  "Action": "sts:AssumeRoleWithWebIdentity",
  "Condition": {
    "StringLike": {
      "token.actions.githubusercontent.com:sub": "repo:RavikumarKamani74/aws-s3-static-site-cicd:*"
    }
  }
}
IAM Policy (Minimal Permissions)
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": "arn:aws:s3:::ravikumar-s3-static-website"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:PutObject", "s3:DeleteObject"],
      "Resource": "arn:aws:s3:::ravikumar-s3-static-website/*"
    },
    {
      "Effect": "Allow",
      "Action": "cloudfront:CreateInvalidation",
      "Resource": "arn:aws:cloudfront::358238714507:distribution/E25GGGTVVJHHS7D"
    }
  ]
}




