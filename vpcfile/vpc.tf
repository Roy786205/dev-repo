AWSTemplateFormatVersion: '2010-09-09'
Description: AWS CloudFormation Template to create a basic VPC

Resources:
  # VPC Resource
  MyVPC:
    Type: AWS::EC2::VPC
    Properties: 
      CidrBlock: 10.0.0.0/16
      Tags:
        - Key: Name
          Value: MyVPC

  # Internet Gateway
  MyInternetGateway:
    Type: AWS::EC2::InternetGateway
    Properties:
      Tags:
        - Key: Name
          Value: MyInternetGateway

  # Attach Internet Gateway to VPC
  VPCGatewayAttachment:
    Type: AWS::EC2::VPCGatewayAttachment
    Properties:
      VpcId: !Ref MyVPC
      InternetGatewayId: !Ref MyInternetGateway

  # Public Subnet
  MyPublicSubnet:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref MyVPC
      CidrBlock: 10.0.1.0/24
      AvailabilityZone: !Select [0, !GetAZs '']
      MapPublicIpOnLaunch: true
      Tags:
        - Key: Name
          Value: MyPublicSubnet

  # Route Table for Public Subnet
  MyPublicRouteTable:
    Type: AWS::EC2::RouteTable
    Properties:
      VpcId: !Ref MyVPC
      Tags:
        - Key: Name
          Value: MyPublicRouteTable

  # Route to the Internet Gateway
  MyPublicRoute:
    Type: AWS::EC2::Route
    DependsOn: VPCGatewayAttachment
    Properties:
      RouteTableId: !Ref MyPublicRouteTable
      DestinationCidrBlock: 0.0.0.0/0
      GatewayId: !Ref MyInternetGateway

  # Associate Route Table with Public Subnet
  MySubnetRouteTableAssociation:
    Type: AWS::EC2::SubnetRouteTableAssociation
    Properties:
      SubnetId: !Ref MyPublicSubnet
      RouteTableId: !Ref MyPublicRouteTable

Outputs:
  VPCId:
    Description: The ID of the VPC
    Value: !Ref MyVPC
  SubnetId:
    Description: The ID of the public subnet
    Value: !Ref MyPublicSubnet
  InternetGatewayId:
    Description: The ID of the Internet Gateway
    Value: !Ref MyInternetGateway
