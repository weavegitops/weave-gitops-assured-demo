flux create helmrelease podinfo \
--namespace=podinfo \
--source=HelmRepository/podinfo \
--release-name=podinfo \
--chart=podinfo \
--chart-version="1.5.29" \
--values=/workspaces/codespace/steve-fraser/weave-gitops-assured-demo/kustomize/apps/podinfo/podinfo-values.yaml --export > /workspaces/codespace/steve-fraser/weave-gitops-assured-demo/kustomize/apps/podinfo/podinfo-helmrelease.yaml