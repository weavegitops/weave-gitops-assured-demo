# Demo

The goal of this demo is to describe and show the variouse components supported in the Weave GitOps Assured offering.


What is WeaveGitOps Assured (WGA)?

Weave GitOps Assured is a comprehensive solution offered by Weaveworks, combining open-source software, enterprise-grade support, and enhanced features to simplify and automate Continuous Delivery (CD) practices and streamline Kubernetes cluster management. It includes best-in-class open-source software components: FluxCD, Flagger, Observability UI, Infrastructure TF Controller, Flamingo Flux Subsystem for Argo, Weave Policy Agent, and a VSCode Plugin.

[Please visit the FAQ for more information](https://www.weave.works/product/assured-faq/) 



## Setting up the demo

### Set up a Kubernetes cluster

Set up a Kubernetes cluster that Flux and the Weave GitOps Assured offering demo can be installed onto.

For example, it is possible to the follow the [kind quick start guide](https://kind.sigs.k8s.io/docs/user/quick-start/) and create a cluster with
```
kind create cluster
```


### Normal

#### Install the Flux CLI

```bash
brew install jq yq fluxcd/tap/flux
```

#### Install FluxCD 

```
flux install --components-extra 'image-reflector-controller,image-automation-controller'
```

#### Set up Variables
```
export GH_USER=<Insert Github USERNAME>
```
#### Set up Git Repository
```
 gh repo create $GH_USER/weave-gitops-assured-demo --public --template=weavegitops/weave-gitops-assured-demo
 gh repo clone $GH_USER/weave-gitops-assured-demo
```


```
cat <<EOF | kubectl apply -f -
---
apiVersion: source.toolkit.fluxcd.io/v1
kind: GitRepository
metadata:
  name: weave-gitops-assured-demo
  namespace: flux-system
spec:
  interval: 30s
  url: https://github.com/$GH_USER/weave-gitops-assured-demo.git
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: weave-gitops-assured-demo
  namespace: flux-system
spec:
  prune: true
  interval: 2m
  path: "./demo"
  sourceRef:
    kind: GitRepository
    name: weave-gitops-assured-demo
  timeout: 3m
EOF
```


### GitOps Run

#### Install the GitOps CLI

Mac / Linux

```console
curl --silent --location "https://github.com/weaveworks/weave-gitops/releases/download/v0.30.0/gitops-$(uname)-$(uname -m).tar.gz" | tar xz -C /tmp
sudo mv /tmp/gitops /usr/local/bin
gitops version
```

Alternatively, users can use Homebrew:

```console
brew tap weaveworks/tap
brew install weaveworks/tap/gitops
```

#### Clone Demo Repository  

```
git clone https://github.com/weavegitops/weave-gitops-assured-demo.git
cd weave-gitops-assured-demo
```



#### Install Flux and Demo Resources
```
gitops run --no-session --no-bootstrap kustomize/gitops-run
```

```
flux create helmrelease podinfo \
--namespace=default \
--source=HelmRepository/podinfo \
--release-name=podinfo \
--chart=podinfo \
--chart-version=">5.0.0" \
--values=kustomize/apps/podinfo/podinfo-values.yaml --export > kustomize/apps/podinfo/podinfo-helmrelease.yaml
```