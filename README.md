# aws-secure-infra

Terraform for a small AWS network (VPC, subnet, flow logs) with encrypted remote state in S3, scanned by Checkov on every pull request.
## Security

### Automated checks on every pull request
- `terraform fmt` and `terraform validate` for every root configuration.
- Checkov IaC scan; any new failed check blocks the merge.
- All GitHub Actions pinned to full commit SHAs; workflow token is read-only.
- `main` is protected: pull request required, `CI / terraform` must pass, no force pushes.

### State and secrets
- Remote state in an encrypted, versioned S3 bucket with native lock-file locking.
- Old state versions expire after 90 days; the current state is never touched.
- State, `.tfvars` and credentials are never committed; `.terraform.lock.hcl` is.

### Network hardening
- The VPC default security group is managed in Terraform with no rules.
- VPC flow logs record all traffic (accepted and rejected) to CloudWatch, kept 365 days.
- The flow log IAM role trusts only the flow logs service from this account and can write only to its own log group.

### Documented exceptions
| Check | Reason |
|---|---|
| CKV_AWS_18 | Single-user state bucket; access logs would need a second bucket |
| CKV_AWS_144 | Versioning protects history; replication doubles cost |
| CKV_AWS_145 | Already encrypted with SSE-S3; a KMS key adds cost |
| CKV2_AWS_62 | Nothing consumes bucket events |
| CKV_AWS_158 | Logs already encrypted by AWS; a KMS key adds cost |


