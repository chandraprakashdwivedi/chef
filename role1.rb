name "security"
description "This role ensures that the nodes attached to it conform the security policy of the organization"
run_list "recipe[nginx]"
default-attribute ({
  "message  => "The message"
  })
