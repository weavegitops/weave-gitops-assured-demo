cd /workspaces/codespace/steve-fraser/weave-gitops-assured-demo
gh repo delete --yes
cd /workspaces/codespace/steve-fraser
rm -rf weave-gitops-assured-demo
export GH_USER=$(gh api user | jq -r '.login')
gh repo create $GH_USER/weave-gitops-assured-demo --public --template=weavegitops/weave-gitops-assured-demo -c
cd weave-gitops-assured-demo
# flux create helmrelease podinfo \
# --namespace=podinfo \
# --source=HelmRepository/podinfo \
# --release-name=podinfo \
# --chart=podinfo \
# --chart-version="1.5.29" \
# --values=/workspaces/codespace/steve-fraser/weave-gitops-assured-demo/kustomize/apps/podinfo/podinfo-values.yaml --export > /workspaces/codespace/steve-fraser/weave-gitops-assured-demo/kustomize/apps/podinfo/podinfo-helmrelease.yaml