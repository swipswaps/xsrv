#!/usr/bin/env make
SHELL := '/bin/bash'

tests: shellcheck check_jinja2 ansible_syntax_check ansible_lint yamllint

# Install dev tools in virtualenv
venv:
	python3 -m venv .venv && \
	source .venv/bin/activate && \
	pip3 install isort ansible-lint yamllint ansible==2.9.3

# Static syntax checker for shell scripts
# requirements: sudo apt install shellcheck
shellcheck:
	# ignore 'Can't follow non-constant source' warnings
	shellcheck -e SC1090 xsrv

# Playbook syntax check
ansible_syntax_check: venv
	source .venv/bin/activate && \
	cp examples/playbook.example.yml playbook-test.yml && \
	echo -e "[all]\nmy.example.org" > inventory-test.yml && \
	ansible-playbook --syntax-check --inventory inventory-test.yml playbook-test.yml && \
	rm playbook-test.yml inventory-test.yml

# Ansible linter
ansible_lint: venv
	source .venv/bin/activate && \
	cp examples/playbook.example.yml playbook-test.yml && \
	ansible-lint playbook-test.yml && \
	rm playbook-test.yml

# YAML syntax check and linter
yamllint: venv
	source .venv/bin/activate && \
	set -o pipefail && \
	find roles/ examples/ requirements-dev.yml requirements.yml -iname "*.yml" | xargs yamllint -c tests/.yamllint

check_jinja2: venv
	source .venv/bin/activate && \
	j2_files=$$(find roles/ -name "*.j2") && \
	for i in $$j2_files; do \
	echo "[INFO] checking syntax for $$i"; \
	python3 ./tests/check-jinja2.py "$$i"; \
	done

# Update TODO.md by fetching issues from the main gitea instance API
# requirements: sudo apt install git jq
#               gitea-cli config defined in ~/.config/gitearc
update_todo:
	git clone https://github.com/bashup/gitea-cli gitea-cli
	echo '<!-- This file is automatically generated by "make update_todo" -->' >| docs/TODO.md
	for repo in xsrv \
	            ansible-xsrv-common \
	            ansible-xsrv-backup \
	            ansible-xsrv-monitoring \
	            ansible-xsrv-lamp \
	            ansible-xsrv-nextcloud \
	            ansible-xsrv-tt-rss \
	            ansible-xsrv-gitea; do \
	    echo -e "\n### $$repo\n" >> docs/TODO.md; \
		./gitea-cli/bin/gitea issues xsrv/$$repo | jq -r '.[] | "- #\(.number) - \(.title)"' >> TODO.md; \
	done
	rm -rf gitea-cli
