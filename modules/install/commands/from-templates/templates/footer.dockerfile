## Footer ------------------------------------------------

# export auto configuration script
RUN /deploy/dockerfile-templates-master/rerun config:init --export-to /configs/

# clean temporary files after installation
RUN /deploy/dockerfile-templates-master/rerun misc:clean

# Run auto configuration
CMD ["/configs/rerun", "rc0:config-init", "--run"]

