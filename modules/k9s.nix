{ config, pkgs, ... }:

{
    programs.k9s = {
        enable = true;
    };

    #xdg.configFile.k9s-config = {
    #    target = "k9s/config.yaml";
    #    text = ''
    #        k9s:
    #          liveViewAutoRefresh: false
    #          screenDumpDir: /home/jenss/.local/state/k9s/screen-dumps
    #          refreshRate: 2
    #          maxConnRetry: 5
    #          readOnly: false
    #          noExitOnCtrlC: false
    #          ui:
    #            enableMouse: false
    #            headless: false
    #            logoless: false
    #            crumbsless: false
    #            noIcons: false
    #          skipLatestRevCheck: false
    #          disablePodCounting: false
    #          shellPod:
    #            image: busybox:1.35.0
    #            namespace: default
    #            limits:
    #              cpu: 100m
    #              memory: 100Mi
    #          imageScans:
    #            enable: false
    #            exclusions:
    #              namespaces: []
    #              labels: {}
    #          logger:
    #            tail: 100
    #            buffer: 5000
    #            sinceSeconds: -1
    #            fullScreenLogs: false
    #            textWrap: false
    #            showTime: false
    #          thresholds:
    #            cpu:
    #              critical: 90
    #              warn: 70
    #            memory:
    #              critical: 90
    #              warn: 70
    #    '';
    #};

    xdg.configFile.k9s-gruvbox-skin = {
        target = "k9s/skins/gruvbox.yaml";
        text = ''
            # -----------------------------------------------------------------------------
            # K9s Gruvbox Dark Skin
            # Author: [@indiebrain](https://github.com/indiebrain)
            # -----------------------------------------------------------------------------

            # Styles...
            foreground: &foreground "#ebdbb2"
            background: &background "#272727"
            current_line: &current_line "#ebdbb2"
            selection: &selection "#3c3735"
            comment: &comment "#bdad93"
            cyan: &cyan "#689d69"
            green: &green "#989719"
            orange: &orange "#d79920"
            magenta: &magenta "#b16185"
            blue: &blue "#448488"
            red: &red "#cc231c"

            k9s:
              body:
                fgColor: *foreground
                bgColor: *background
                logoColor: *blue
              prompt:
                fgColor: *foreground
                bgColor: *background
                suggestColor: *orange
              info:
                fgColor: *magenta
                sectionColor: *foreground
              help:
                fgColor: *foreground
                bgColor: *background
                keyColor: *magenta
                numKeyColor: *blue
                sectionColor: *green
              dialog:
                fgColor: *foreground
                bgColor: *background
                buttonFgColor: *foreground
                buttonBgColor: *magenta
                buttonFocusFgColor: white
                buttonFocusBgColor: *cyan
                labelFgColor: *orange
                fieldFgColor: *foreground
              frame:
                border:
                  fgColor: *selection
                  focusColor: *current_line
                menu:
                  fgColor: *foreground
                  keyColor: *magenta
                  numKeyColor: *magenta
                crumbs:
                  fgColor: *foreground
                  bgColor: *comment
                  activeColor: *blue
                status:
                  newColor: *cyan
                  modifyColor: *blue
                  addColor: *green
                  errorColor: *red
                  highlightColor: *orange
                  killColor: *comment
                  completedColor: *comment
                title:
                  fgColor: *foreground
                  bgColor: *background
                  highlightColor: *orange
                  counterColor: *blue
                  filterColor: *magenta
              views:
                charts:
                  bgColor: background
                  defaultDialColors:
                    - *blue
                    - *red
                  defaultChartColors:
                    - *blue
                    - *red
                table:
                  fgColor: *foreground
                  bgColor: *background
                  cursorFgColor: "#fff"
                  cursorBgColor: *current_line
                  header:
                    fgColor: *foreground
                    bgColor: *background
                    sorterColor: *selection
                xray:
                  fgColor: *foreground
                  bgColor: *background
                  cursorColor: *current_line
                  graphicColor: *blue
                  showIcons: false
                yaml:
                  keyColor: *magenta
                  colonColor: *blue
                  valueColor: *foreground
                logs:
                  fgColor: *foreground
                  bgColor: *background
                  indicator:
                    fgColor: *foreground
                    bgColor: *background
        '';
    };
    xdg.configFile.k9s-plugins = {
        target = "k9s/plugins.yaml";
        text = ''
            plugins:
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
