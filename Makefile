# Build every source in src/ into its own executable in bin/

SRC_DIR := src
BIN_DIR := bin
OBJ_DIR := obj

CC ?= cc
CXX ?= c++
CFLAGS ?= -O2 -Wall -Wextra -std=c11
CXXFLAGS ?= -O2 -Wall -Wextra -std=c++17
LDFLAGS ?= 
LDLIBS ?= 

C_SOURCES   := $(wildcard $(SRC_DIR)/*.c)
CXX_SOURCES := $(wildcard $(SRC_DIR)/*.cpp)
SOURCES     := $(C_SOURCES) $(CXX_SOURCES)

PROGS      := $(sort $(patsubst $(SRC_DIR)/%,$(BIN_DIR)/%,$(basename $(SOURCES))))
PROGS_C    := $(patsubst $(SRC_DIR)/%.c,$(BIN_DIR)/%,$(C_SOURCES))
PROGS_CXX  := $(patsubst $(SRC_DIR)/%.cpp,$(BIN_DIR)/%,$(CXX_SOURCES))
OBJS       := $(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%.o,$(basename $(SOURCES)))

.PHONY: all clean test-all
all: $(PROGS)

$(BIN_DIR) $(OBJ_DIR):
	@mkdir -p $@

# Compile
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

# Link
$(PROGS_C): $(BIN_DIR)/%: $(OBJ_DIR)/%.o | $(BIN_DIR)
	$(CC) $< -o $@ $(LDFLAGS) $(LDLIBS)

$(PROGS_CXX): $(BIN_DIR)/%: $(OBJ_DIR)/%.o | $(BIN_DIR)
	$(CXX) $< -o $@ $(LDFLAGS) $(LDLIBS)

clean:
	rm -rf $(BIN_DIR) $(OBJ_DIR)

-include $(OBJS:.o=.d)

# Usage: make test <id>
ID := $(wordlist 2, 2, $(MAKECMDGOALS))
$(eval $(ID):)
test: $(BIN_DIR)/$(ID)
	@if [ -z "$(ID)" ]; then \
		echo "Usage: make test <id>"; \
		exit 1; \
	fi
	@if [ ! -f "data/$(ID)/sample.in" ]; then \
		echo "Error: data/$(ID)/sample.in not found"; \
		exit 1; \
	fi
	@if [ ! -f "data/$(ID)/sample.out" ]; then \
		echo "Error: data/$(ID)/sample.out not found"; \
		exit 1; \
	fi
	@$(BIN_DIR)/$(ID) < data/$(ID)/sample.in > out.txt
	@if diff -q out.txt data/$(ID)/sample.out > /dev/null; then \
		printf "Test $(ID): \033[0;32mPASSED\033[0m\n"; \
	else \
		printf "Test $(ID): \033[0;31mFAILED\033[0m\n"; \
		diff out.txt data/$(ID)/sample.out; \
		exit 1; \
	fi
	@rm -f out.txt

.PHONY: test-all
test-all: $(PROGS)
	@passed_count=0; \
	failed_count=0; \
	failed_ids=""; \
	failed_details=""; \
	for id in $(patsubst $(BIN_DIR)/%,%,$(PROGS)); do \
		if [ ! -f "data/$$id/sample.in" ] || [ ! -f "data/$$id/sample.out" ]; then \
			continue; \
		fi; \
		printf "Running test for %s... " $$id; \
		$(BIN_DIR)/$$id < data/$$id/sample.in > out.txt; \
		if diff -q out.txt data/$$id/sample.out > /dev/null; then \
			printf "\033[0;32mPASSED\033[0m\n"; \
			passed_count=$$((passed_count+1)); \
		else \
			printf "\033[0;31mFAILED\033[0m\n"; \
			failed_count=$$((failed_count+1)); \
			failed_ids="$$failed_ids $$id"; \
			diff_output=$$(diff out.txt data/$$id/sample.out); \
			failed_details="$$failed_details--- FAILED: $$id ---$$diff_output\n\n"; \
		fi; \
		done; \
	rm -f out.txt; \
	printf "\n--- Test Summary ---\n"; \
	printf "Passed: \033[0;32m%d\033[0m\n" $$passed_count; \
	printf "Failed: \033[0;31m%d\033[0m\n" $$failed_count; \
	if [ $$failed_count -gt 0 ]; then \
		echo "Failed IDs:" "$$failed_ids"; \
		echo " "; \
		echo "--- Failure Details ---"; \
		echo "$$failed_details"; \
		echo "Se aparecer igual, verifique se há espaços em branco extras ou linhas em branco no final dos arquivos de saída."; \
	fi