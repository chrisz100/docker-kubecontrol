FROM cjantz/awscli
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
	chmod +x kubectl && \
	mv kubectl /usr/local/bin/kubectl && \
	curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
	echo "source <(kubectl completion bash)" >> ~/.bashrc
RUN curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 && \
	chmod +x kops-linux-amd64 && \
	mv kops-linux-amd64 /usr/local/bin/kops
RUN curl --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && \
	mv /tmp/eksctl /usr/local/bin
RUN curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator && chmod +x /usr/local/bin/aws-iam-authenticator
WORKDIR /project
CMD /bin/bash
