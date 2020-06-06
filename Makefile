SHELL = /bin/bash
WMT = ./data/wmt_all
GIT_HOOKS = ./.git/hooks
DATA = ./data

$(GIT_HOOKS)/pre-commit: ./hooks/pre-commit.sample
	cp --force $< $@

.PHONY: hook
hook: $(GIT_HOOKS)/pre-commit

.PHONY: download_laser
download_laser:
	python3 -m laserembeddings download-models

.PHONY: download_paws_X
download_paws_X:
	wget -N -P $(DATA) "https://storage.googleapis.com/paws/pawsx/x-final.tar.gz"
	tar -zxvf $(DATA)/x-final.tar.gz -C $(DATA)
	mkdir -p $(DATA)/x-final/misc
	mv $(DATA)/x-final/es $(DATA)/x-final/fr \
		$(DATA)/x-final/ja $(DATA)/x-final/ko \
		$(DATA)/x-final/zh $(DATA)/x-final/misc/
