#!/bin/bash

JDTLS_HOME=~/source/third-party-repos/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository
WORKSPACE=~/workspace

java \
	-Declipse.application=org.eclipse.jdt.ls.core.id1 \
	-Dosgi.bundles.defaultStartLevel=4 \
	-Declipse.product=org.eclipse.jdt.ls.core.product \
	-Dlog.level=ALL \
	-Xmx1G \
	--add-modules=ALL-SYSTEM \
	--add-opens java.base/java.util=ALL-UNNAMED \
	--add-opens java.base/java.lang=ALL-UNNAMED \
	-jar $JDTLS_HOME/plugins/org.eclipse.equinox.launcher_1.6.800.v20240426-1701.jar \
	-configuration $JDTLS_HOME/config_linux \
	-data $WORKSPACE
