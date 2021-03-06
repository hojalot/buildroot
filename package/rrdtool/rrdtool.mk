################################################################################
#
# rrdtool
#
################################################################################

RRDTOOL_VERSION = 1.6.0
RRDTOOL_SITE = http://oss.oetiker.ch/rrdtool/pub
RRDTOOL_LICENSE = GPLv2+ with FLOSS license exceptions as explained in COPYRIGHT
RRDTOOL_LICENSE_FILES = COPYRIGHT LICENSE
RRDTOOL_DEPENDENCIES = host-pkgconf libglib2
# autoreconf needed to avoid link failure due to missing -lintl,
# gettextize needed as a consequence of autoreconf
RRDTOOL_AUTORECONF = YES
RRDTOOL_GETTEXTIZE = YES
RRDTOOL_INSTALL_STAGING = YES
RRDTOOL_CONF_OPTS = \
	--disable-examples \
	--disable-libdbi \
	--disable-librados \
	--disable-libwrap \
	--disable-lua \
	--disable-perl \
	--disable-python \
	--disable-ruby \
	--disable-tcl


ifeq ($(BR2_NEEDS_GETTEXT),y)
RRDTOOL_DEPENDENCIES += gettext
endif

ifeq ($(BR2_PACKAGE_RRDTOOL_RRDGRAPH),y)
RRDTOOL_DEPENDENCIES += cairo pango
else
RRDTOOL_CONF_OPTS += --disable-rrd_graph
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
RRDTOOL_DEPENDENCIES += libxml2
else
RRDTOOL_CONF_OPTS += --disable-rrd_restore
endif

$(eval $(autotools-package))
