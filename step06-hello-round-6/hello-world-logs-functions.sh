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
