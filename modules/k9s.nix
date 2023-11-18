{ config, pkgs, ... }:

{
    programs.k9s = {
        enable = true;
    };

    xdg.configFile.k9s-plugins = {
        target = "k9s/plugin.yml";
        text = ''
            plugin:
              toggle-helmrelease:
                shortCut: Shift-T
                confirm: true
                scopes:
                  - helmreleases
                description: Toggle to suspend or resume a HelmRelease
                command: ${pkgs.tmux}/bin/tmux
                background: false
                args:
                  - display-popup
                  - -E
                  - "flux --context $CONTEXT $([ $(kubectl --context $CONTEXT get helmreleases -n $NAMESPACE $NAME -o=custom-columns=TYPE:.spec.suspend | tail -1) = \"true\" ] && echo \"resume\" || echo \"suspend\") helmrelease -n $NAMESPACE $NAME; read -r input"
              toggle-kustomization:
                shortCut: Shift-T
                confirm: true
                scopes:
                  - kustomizations
                description: Toggle to suspend or resume a Kustomization
                command: ${pkgs.tmux}/bin/tmux
                background: false
                args:
                  - display-popup
                  - -E
                  - "flux --context $CONTEXT $([ $(kubectl --context $CONTEXT get kustomizations -n $NAMESPACE $NAME -o=custom-columns=TYPE:.spec.suspend | tail -1) = \"true\" ] && echo \"resume\" || echo \"suspend\") kustomization -n $NAMESPACE $NAME; read -r input"
              reconcile-git:
                shortCut: Shift-R
                confirm: false
                description: Flux reconcile
                scopes:
                - gitrepositories
                command: ${pkgs.tmux}/bin/tmux
                background: false
                args:
                  - display-popup
                  - -E
                  - "flux --context $CONTEXT reconcile source git -n $NAMESPACE $NAME; read -r input"
              reconcile-hr:
                shortCut: Shift-R
                confirm: false
                description: Flux reconcile
                scopes:
                - helmreleases
                command: ${pkgs.tmux}/bin/tmux
                background: false
                args:
                  - display-popup
                  - -E
                  - "flux --context $CONTEXT reconcile helmrelease -n $NAMESPACE $NAME; read -r input"
              reconcile-helm-repo:
                shortCut: Shift-Z
                description: Flux reconcile
                scopes:
                  - helmrepositories
                command: ${pkgs.tmux}/bin/tmux
                background: false
                confirm: false
                args:
                  - display-popup
                  - -E
                  - "flux reconcile source helm --context $CONTEXT -n $NAMESPACE $NAME; read -r input"
              reconcile-oci-repo:
                shortCut: Shift-Z
                description: Flux reconcile
                scopes:
                  - ocirepositories
                command: ${pkgs.tmux}/bin/tmux
                background: false
                confirm: false
                args:
                  - display-popup
                  - -E
                  - "flux reconcile source oci --context $CONTEXT -n $NAMESPACE $NAME; read -r input"
              reconcile-ks:
                shortCut: Shift-R
                confirm: false
                description: Flux reconcile
                scopes:
                - kustomizations
                command: ${pkgs.tmux}/bin/tmux
                background: false
                args:
                - display-popup
                - -E
                - "flux --context $CONTEXT reconcile kustomization -n $NAMESPACE $NAME; read -r input"
              reconcile-ir:
                shortCut: Shift-R
                confirm: false
                description: Flux reconcile
                scopes:
                - imagerepositories
                command: ${pkgs.tmux}/bin/tmux
                background: false
                args:
                  - display-popup
                  - -E
                  - "flux --context $CONTEXT reconcile image repository -n $NAMESPACE $NAME; read -r input"
              reconcile-iua:
                shortCut: Shift-R
                confirm: false
                description: Flux reconcile
                scopes:
                - imageupdateautomations
                command: ${pkgs.tmux}/bin/tmux
                background: false
                args:
                  - display-popup
                  - -E
                  - "flux --context $CONTEXT reconcile image update -n $NAMESPACE $NAME; read -r input"
              trace:
                shortCut: Shift-A
                confirm: false
                description: Flux trace
                scopes:
                - all
                command: ${pkgs.tmux}/bin/tmux
                background: false
                args:
                  - display-popup
                  - -E
                  - "flux --context $CONTEXT trace --kind `echo $RESOURCE_NAME | sed -E 's/ies$/y/' | sed -E 's/ses$/se/' | sed -E 's/(s|es)$//g'` --api-version $RESOURCE_GROUP/$RESOURCE_VERSION --namespace $NAMESPACE $NAME; read -r input"
        '';
    };
}
