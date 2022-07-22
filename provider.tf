provider "aws" {
  region     = "us-east-2"
  shared_config_files      = ["%USERPROFILE%\\.aws\\config"]
  shared_credentials_files = ["%USERPROFILE%\\.aws\\credentials"]
}
