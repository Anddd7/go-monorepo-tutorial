# Access supporing tools

PS, this env is build on wsl + minikube + docker, it cannot expose a 'public' ip or dns to outside.

So, there are several ways to access the serivce, e.g. argocd

- Port Forward
  - `kubectl port-forward svc/argocd-server -n argocd 8080:443`
- Ingress
  - nginx-ingress-controller
    - > create ingress
    - > expose the ingress controller (default NodePort, same as node port)
    - > `minikube service ingress-nginx-controller -n ingress-nginx --url`
  - istio-ingressgateway
    - > create virtual service
    - > expose the ingress controller
    - > `minikube tunnel`
- NodePort
  - > expose the service via `minikube service <name> --url`

Then, modify the `/etc/hosts` or use `curl -k https://127.0.0.1:33373 -H 'Host: argocd.wsl-ubuntu.anddd7.io'` to verify the connection.