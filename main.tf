provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_key_pair" "test_key" {
    key_name   = "test_key"
    public_key = file("./test.pem.pub")
}

resource "aws_instance" "test_ec2" {
    ami                     = "ami-0c3fd0f5d33134a76"
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [aws_security_group.test_sg.id]
    key_name                = aws_key_pair.test_key.key_name
    
    tags = {
        Name = "test"
    }
}

resource "aws_security_group" "test_sg" {
    name   = "test_sg"
}

resource "aws_security_group_rule" "ingress" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.test_sg.id
}

resource "aws_security_group_rule" "egress" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.test_sg.id
}

output "ec2_public_ip" {
    value = "aws_instance.test_ec2.public_ip"
}
