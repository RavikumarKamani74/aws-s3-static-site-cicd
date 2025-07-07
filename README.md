# 🚀 AWS S3 Static Website CI/CD with GitHub Actions and CloudFront

This repository contains a fully automated CI/CD pipeline for deploying a static website to **Amazon S3**, served securely via **Amazon CloudFront**, with no long-term AWS credentials — thanks to **OIDC-based GitHub Actions integration**.

![Deploy to S3](https://github.com/RavikumarKamani74/aws-s3-static-site-cicd/actions/workflows/deploy.yml/badge.svg)

---

## 🔧 Features

- ✅ CI/CD using GitHub Actions
- ✅ OIDC-based authentication (no stored AWS keys)
- ✅ Auto-deployment to S3 on every `main` push
- ✅ CloudFront cache invalidation for instant content update
- ✅ Secure, scalable, and production-grade setup

---

## 📁 Folder Structure


---

## 🛠️ Technologies Used

- **Amazon S3** – Static site hosting  
- **Amazon CloudFront** – CDN & HTTPS  
- **IAM OIDC Role** – Secure GitHub to AWS access  
- **GitHub Actions** – Automation  
- **AWS CLI** – Deployer tool

---

## 🔄 CI/CD Pipeline Overview

1. Push to `main` branch
2. GitHub Actions assumes an OIDC IAM Role
3. Files are synced to the S3 bucket: `ravikumar-s3-static-website`
4. CloudFront distribution (`dq6ta8ipffudm.cloudfront.net`) is invalidated to update content globally

---

## 🔐 IAM Policy (Minimal Example)

```json
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
