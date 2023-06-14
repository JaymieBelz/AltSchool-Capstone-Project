resource "aws_iam_role" "capstone" {
  name = "eks-cluster-capstone"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    { 
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "capstone-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.capstone.name
}

resource "aws_eks_cluster" "capstone" {
  name     = "capstone"
  role_arn = aws_iam_role.capstone.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-subnet.id,
      aws_subnet.public-subnet.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.capstone-AmazonEKSClusterPolicy]
}