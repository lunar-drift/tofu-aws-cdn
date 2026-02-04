# AWS CDN Module
Used to create CloudFront configurations for a project.
Origin bucket created with root directory accessible to CloudFront

## Usage

### Prerequisites
- AWS Certificate Manager certificate arn for subdomains desired to use with Amazon CloudFront `var.aws_acm_certificate_arn`

### Variables
| Variable Name             | Type           | Example                        | Notes                                                            |
|---------------------------|----------------|--------------------------------|------------------------------------------------------------------|
| `aws_region`              | `string`       | `'us-east-1'`                  |                                                                  |
| `acm_certificate_arn`     | `string`       | `aws_acm_certificate.cert.arn` |                                                                  |
| `s3_bucket_name`          | `string`       | `'www.lunardrift.net'`         | Restrictions                                                     |
| `s3_origin_id`            | `string`       | `'www_lunardrift_net_bucket'`  | Restrictions                                                     |
| `cf_aliases`              | `list(string)` | `['www.lunardrift.net']`       | Restrictions                                                     |
| `cf_restricted_locations` | `list(string)` | `['AF', 'IQ', 'RU']`           | [country-codes](https://www.iso.org/iso-3166-country-codes.html) |



### Resources
- S3 Bucket with an Origin Access Control policy and bucket versioning 
- Amazon CloudFront Distribution

TODO create tool that allows for the checking if a bucket name is valid / available.
Only clients with an aws account can take advantage of the flat rate cdn plan. -- which is far from being implemented.
- when a client is able to use the flat rate plan, use r53 for dns.
- create waf web acl
- 

## Further Reading
[opentofu enabled/disabled resource docs](https://opentofu.org/docs/v1.11/language/meta-arguments/enabled/) for use with additional distribution configurations i.e. caching
