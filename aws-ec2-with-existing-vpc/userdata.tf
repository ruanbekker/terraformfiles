locals {
  user_data = <<EOF
#!/bin/bash
echo "This instance is in region: ${var.region}" > /root/data.txt
EOF
}
