.POSIX:

INSTALL_PATH = /usr/bin

install:
	cp -r koha-gitify ${INSTALL_PATH}

uninstall:
	rm -f ${INSTALL_PATH}/koha-gitify

.PHONY: install uninstall
