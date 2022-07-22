# If you are using windows OS then use the below
# If you are using Linux uncomment the commented lines and comment the previous 2 lines
provider "aws" {
  region     = "us-east-2"
  shared_config_files      = ["$HOME/.aws/config"]
  shared_credentials_files = ["$HOME/.aws/credentials"]
  /*
  shared_config_files      = ["%USERPROFILE%\\.aws\\config"]
  shared_credentials_files = ["%USERPROFILE%\\.aws\\credentials"]
  */
}
