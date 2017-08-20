# print the info message
# usage: log_info "a message"
function log_info() {
  echo "INFO - $@"
}

# print the info message
# usage: msg="a message" log_info_message
function log_info_message() {
  echo "INFO - $msg"
}

# print the eroor message
# usage: log_error "a message"
function log_error() {
  echo "ERROR - $@"
}

# print the error message
# usage: msg="a message" log_error_message
function log_error_message() {
  echo "ERROR - $msg"
}
