#!/bin/bash
# $Id: install.sh,v 0.5 2007/04/06 09:17:45 orveldv Exp $
#
# Logsend watches files and mails the additions to your 
# e-mail address.
#
# Logsend is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# Logsend is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public 
# License along with this program; if not, write to the Free 
# Software Foundation, Inc.,51 Franklin Street, Fifth Floor, 
# Boston, MA 02110-1301 USA.
#
#
# Copyright: 	Daniel Butzu (Orveldv) 
# Mailto: 	orveldv at users dot sourceforge dot net
# Homepage: 	http://logsend.sourceforge.net





# -------------------------------------

set -e

	# needed for installing under ALL prefixes;
	# these will be passed to ALL bins & libs.
	ORV_SCRIPT_NAME="logsend"
	ORV_SCRIPT_VERSION="1.0"
	ORV_PKG_NAME="${ORV_SCRIPT_NAME}-${ORV_SCRIPT_VERSION}"

	# if ./install.sh was called directly and not by make
	[ -z "${prefix}" ] && prefix="/usr/local"

	# if a user specified a relative path for prefix, 
	# convert it to absolute.
	[ "${prefix:0:1}" != "/" ] && prefix="${PWD}/${prefix}"

	# check what PREFIX was supplied
	if [ "${prefix}" != "/usr" ] && [ "${prefix}" != "/usr/" ] && [ "${prefix}" != "/usr/local" ] && [ "${prefix}" != "/usr/local/" ]
	then 
		DESTDIR="${prefix}/${ORV_PKG_NAME}"
		ORV_NONSTD_PREFIX="1"
	else
		DESTDIR="${prefix}"
		ORV_NONSTD_PREFIX="0"
	fi 

	# our files
	ORV_BINS="logsend"
	ORV_LIBS="logsend-config backend-inotify backend-simple backend-tail"
	ORV_THEMES="dialogrc_dark dialogrc_blue_cyan dialogrc_blue_white dialogrc_bw dialogrc_cyan_contrast dialogrc_cyan_pale dialogrc_debianish"
	ORV_SHARES="logsend.conf.default"
	ORV_MANS="logsend.1"
	ORV_DOCS="COPYING AUTHORS ChangeLog README README.html"





orv_install() {
set -x
	cd $(dirname $0)
	mkdir --parents "${DESTDIR}"

	mkdir --parents "${DESTDIR}/bin"
	for ONE_BIN in ${ORV_BINS}
	do
		cp -f "contents/${ONE_BIN}" "${DESTDIR}/bin/${ONE_BIN}"
		chown "${USER}" "${DESTDIR}/bin/${ONE_BIN}"
		chmod 755 "${DESTDIR}/bin/${ONE_BIN}"

		echo "# Added by install.sh" >> "${DESTDIR}/bin/${ONE_BIN}"
		echo DESTDIR='"'${DESTDIR}'"' >> "${DESTDIR}/bin/${ONE_BIN}"
		echo ORV_PKG_NAME='"'${ORV_PKG_NAME}'"' >> "${DESTDIR}/bin/${ONE_BIN}"
		echo ORV_SCRIPT_NAME='"'${ORV_SCRIPT_NAME}'"' >> "${DESTDIR}/bin/${ONE_BIN}"
		echo ORV_SCRIPT_VERSION='"'${ORV_SCRIPT_VERSION}'"' >> "${DESTDIR}/bin/${ONE_BIN}"
	done

	mkdir --parents "${DESTDIR}/lib/${ORV_PKG_NAME}" 
	for ONE_LIB in ${ORV_LIBS}
	do
		cp -f "contents/${ONE_LIB}" "${DESTDIR}/lib/${ORV_PKG_NAME}/${ONE_LIB}"
		chown "${USER}" "${DESTDIR}/lib/${ORV_PKG_NAME}/${ONE_LIB}"
		chmod 755 "${DESTDIR}/lib/${ORV_PKG_NAME}/${ONE_LIB}"

		echo "# Added by install.sh" >> "${DESTDIR}/lib/${ORV_PKG_NAME}/${ONE_LIB}"
		echo DESTDIR='"'${DESTDIR}'"' >> "${DESTDIR}/lib/${ORV_PKG_NAME}/${ONE_LIB}"
		echo ORV_PKG_NAME='"'${ORV_PKG_NAME}'"' >> "${DESTDIR}/lib/${ORV_PKG_NAME}/${ONE_LIB}"
		echo ORV_SCRIPT_NAME='"'${ORV_SCRIPT_NAME}'"' >> "${DESTDIR}/lib/${ORV_PKG_NAME}/${ONE_LIB}"
		echo ORV_SCRIPT_VERSION='"'${ORV_SCRIPT_VERSION}'"' >> "${DESTDIR}/lib/${ORV_PKG_NAME}/${ONE_LIB}"
	done

	mkdir --parents "${DESTDIR}/share/${ORV_PKG_NAME}/themes"
	for ONE_THEME in ${ORV_THEMES}
	do
		cp -f "contents/${ONE_THEME}" "${DESTDIR}/share/${ORV_PKG_NAME}/themes/${ONE_THEME}"
		chown "${USER}" "${DESTDIR}/share/${ORV_PKG_NAME}/themes/${ONE_THEME}"
		chmod 644 "${DESTDIR}/share/${ORV_PKG_NAME}/themes/${ONE_THEME}"
	done

	mkdir --parents "${DESTDIR}/share/${ORV_PKG_NAME}"
	for ONE_SHARE in ${ORV_SHARES}
	do
		cp -f "contents/${ONE_SHARE}" "${DESTDIR}/share/${ORV_PKG_NAME}/${ONE_SHARE}"
		chown "${USER}" "${DESTDIR}/share/${ORV_PKG_NAME}/${ONE_SHARE}"
		chmod 644 "${DESTDIR}/share/${ORV_PKG_NAME}/${ONE_SHARE}"
	done

	mkdir --parents "${DESTDIR}/share/man/man1"
	for ONE_MAN in ${ORV_MANS}
	do
		cp -f "contents/${ONE_MAN}" "${DESTDIR}/share/man/man1/${ONE_MAN}"
		chown "${USER}" "${DESTDIR}/share/man/man1/${ONE_MAN}"
		chmod 644 "${DESTDIR}/share/man/man1/${ONE_MAN}"
	done

	mkdir --parents "${DESTDIR}/share/doc/${ORV_PKG_NAME}"
	for ONE_DOC in ${ORV_DOCS}
	do
		cp -f "${ONE_DOC}" "${DESTDIR}/share/doc/${ORV_PKG_NAME}/${ONE_DOC}"
		chown "${USER}" "${DESTDIR}/share/doc/${ORV_PKG_NAME}/${ONE_DOC}"
		chmod 644 "${DESTDIR}/share/doc/${ORV_PKG_NAME}/${ONE_DOC}"
	done


set +x
	echo
	echo "Install completed successfully."
	echo "Now you should configure logsend for your own needs."

	if ! command -v "inotifywait" > /dev/null 2>&1
	then
		echo "You don't seem to have inotify-tools installed. You won't be able to use the INOTIFY backend."
	else
		echo "You have inotify-tools installed. You can use the INOTIFY backend."
	fi

	if ! command -v "dialog" > /dev/null 2>&1
	then
		echo "You don't seem to have dialog installed. You won't be able to use the configuration tool."
	else
		echo "Type: logsend config"
	fi
	echo 
}


orv_uninstall() {	
set -x 

	for ONE_BIN in ${ORV_BINS}
	do
		rm -f "${DESTDIR}/bin/${ONE_BIN}"
	done
	rm -rf "${DESTDIR}/lib/${ORV_PKG_NAME}"
	rm -rf "${DESTDIR}/share/${ORV_PKG_NAME}"
	for ONE_MAN in ${ORV_MANS}
	do
		rm -f "${DESTDIR}/share/man/man1/${ONE_MAN}"
	done
	rm -rf "${DESTDIR}/share/doc/${ORV_PKG_NAME}"

	if [ "${ORV_NONSTD_PREFIX}" = "1" ]
	then
		rm -rf "${DESTDIR}"
	fi


set +x
	echo
	echo "Uninstall completed successfully."
	echo "Thank you for using ${ORV_PKG_NAME}."
	echo 
}





orv_usage() {
	echo "Usage: ./install.sh <OPTION>"
	echo
	echo "Supported options:"
	echo "  -i, --install             perform install"
	echo "  -u, --uninstall           perform uninstall"
}





case "$1" in
'-i'|'--install')
	orv_install
	;;
'-u'|'--uninstall')
	orv_uninstall
	;;
*)
	orv_usage
	;;
esac


