INSTALL_DIR = $(HOME)/git-choppa

install:
	@mkdir -p $(INSTALL_DIR)
	@chmod +x git-2-the-choppa.sh
	@cp git-2-the-choppa.sh $(INSTALL_DIR)
	@echo "git-2-the-choppa.sh has been installed to $(INSTALL_DIR)"
	@echo "Please ensure that $(INSTALL_DIR) is in your PATH to use the script globally."

uninstall:
	@rm $(INSTALL_DIR)/git-2-the-choppa.sh
	@echo "git-2-the-choppa.sh has been removed from $(INSTALL_DIR)"
