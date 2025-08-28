# My Portfolio - Azure Container Apps Deployment

Welcome to my **live portfolio website**, deployed on **Azure Container Apps** and managed through a fully automated **DevOps pipeline**.  

This project showcases not only my web development skills (HTML, CSS, JavaScript) but also my **cloud deployment, CI/CD, and infrastructure automation expertise**.

---

> Fully containerized and continuously deployed. All changes pushed to GitHub automatically update the live site.

---

## 🛠 Tech Stack

- **Frontend:** HTML, CSS, JavaScript  
- **Containerization:** Docker (Nginx base image)  
- **Cloud Provider:** Azure (Container Apps)  
- **CI/CD:** GitHub Actions  
- **Infrastructure as Code:** Terraform (via Terraform Cloud)  
- **Security & Code Quality:** TFsec, SonarCloud

---

## ⚡ Features & Workflow

1. **Dockerized Deployment:**  
   - The site is packaged into a lightweight Docker container using an Nginx Alpine base image.
   - Images are pushed to **AWS ECR** using GitHub Actions.  

2. **Continuous Deployment with Terraform Cloud:**  
   - Terraform Cloud provisions and updates the Azure Container App on every commit.  
   - The deployment always pulls the **latest Docker image**, ensuring updates go live immediately.  

3. **Code Quality & Security:**  
   - SonarCloud runs static code analysis to maintain quality.  (In this case i let it override result outcome intentionally)
   - TFsec scans Terraform files for security misconfigurations.  

4. **Version Control & Clean Pipelines:**  
   - GitHub Actions workflows are modularized: Docker build, security scans, Terraform deployment.  
   - Only relevant, clean workflows are active to maintain efficiency.  

---

## 📂 Repository Structure

app/ # Static website files
.github/workflows/ # CI/CD pipelines
main.tf # Terraform configuration
variables.tf # Terraform variables
cred.tf # TF Cloud config

---

## 💡 Key Takeaways for Hiring Managers

- Demonstrates ability to **containerize applications** and manage **cloud infrastructure**.
- Shows knowledge of **CI/CD pipelines**, **IaC with Terraform**, and **automated deployments**.
- Illustrates **code quality and security awareness** using SonarCloud and TFsec.
- Provides a **fully functional, live portfolio**, showcasing both technical and frontend skills.

---

## 🔧 How It Works

1. Push changes to the repository → triggers GitHub Actions, Sonarcloud Scans App for CVES, then upon outcome triggers docker build.  
2. Docker image is built and tagged (`latest`), then scanned by Trivy before then pushed to ECR.  
3. Terraform Infra code is scanned by TfSec before Terraform Cloud applies changes to Azure Container App by it self.  
4. Live site automatically updates with new content.  
5. Terraform Cloud stores and manages states.

---

<pre>
   [Developer Pushes Code]
               │
               ▼
      ┌─────────────────┐
      │ GitHub Actions  │
      │  - Docker Build │
      │  - Push to ECR  │
      │  - Security     │
      │    Scans        │
      └─────────────────┘
               │
               ▼
      ┌─────────────────┐
      │ Terraform Cloud │
      │  - Apply Changes│
      │  - Update Azure │
      │    Container    │
      │    App          │
      └─────────────────┘
               │
               ▼
      [Live Portfolio Website Updated]
</pre>

---

## 📌 Notes

- This setup is optimized for **portfolio/demo purposes** — production environments would typically use SHA-tagged images for rollback safety.  
- All Terraform variables and secrets are securely managed in Terraform Cloud and GitHub Secrets.  

---

> Crafted with care to demonstrate **real-world DevOps skills** in a portfolio-ready project.
> Failed and passed scans are intentionally left to show the process.
> Failure and Progress are part of the process.
