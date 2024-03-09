# K3s Pi 5

### Getting Started
- Get your device running, I used a Raspberry Pi5 5 (8GB RAM) for this. You don't have to, but there is some ARM64-specific things that may not work if you're not using a Pi.
- Install [K3s](https://k3s.io/) on your device
- Replace the placeholder values in the [initial-git-secret-template.yaml](./bootstrap/initial-git-secret-template.yaml) file with your Git credentials. Don't push this file to Git, it's just there to remind you that it's necessary for the GitOps flow.
- Install FluxCD onto your new K3s cluster using the provided script
```bash
cd bootstrap
./install-flux.sh
```
- It's now safe to revert/remove the changes you made to the [initial-git-secret-template.yaml](./bootstrap/initial-git-secret-template.yaml) file.


### What Now?
At this point, you have a functioning GitOps workflow for your new cluster. Any changes made to the resources in the Git repository will be reconciled onto the cluster after some time. If you're new to GitOps, I'd recommend looking at the [FluxCD Documentation](https://fluxcd.io/flux/concepts/) for more information.

The resources in the `services/` directory are optional to deploy. Just run `kubectl apply -f services/<NAME>/<NAME>.yaml`. If there is a templated Secret manifest in that directory, then the service will need you to fill that in and manually deploy it to the cluster.