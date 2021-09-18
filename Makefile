
# $Id: Makefile,v 0.2 2007/03/26 10:29:14 orveldv Exp $
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





# --------------------------------------
# set prefix and pass it to ./install.sh

prefix ?= /usr/local
export prefix


default:
	@ echo "Nothing to do. Type 'make install' or 'make uninstall'"


install:
	./install.sh -i

uninstall:
	./install.sh -u