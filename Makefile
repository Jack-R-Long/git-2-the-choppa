INSTALL_DIR = $(HOME)/git_choppa

install:
	@mkdir -p $(INSTALL_DIR)
	@chmod +x git_2_the_choppa.sh
	@mv git_2_the_choppa.sh $(INSTALL_DIR)
	@echo "git_2_the_choppa.sh has been installed to $(INSTALL_DIR)"
	@echo "Please ensure that $(INSTALL_DIR) is in your PATH to use the script globally."

uninstall:
	@rm $(INSTALL_DIR)/git_2_the_choppa.sh
	@echo "git_2_the_choppa.sh has been removed from $(INSTALL_DIR)"
