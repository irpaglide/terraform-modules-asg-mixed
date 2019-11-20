resource "aws_iam_role" "main" {
  name = "${var.iam_role_name}"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "main" {
  name = "${aws_iam_role.main.name}"
  role = "${aws_iam_role.main.name}"
}

resource "aws_iam_role_policy" "web_iam_role_policy" {
  name = "${aws_iam_role.main.name}"
  role = "${aws_iam_role.main.id}"
  policy = "${var.instance_profile_policy}"
}
