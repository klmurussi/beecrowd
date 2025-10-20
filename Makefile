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

.PHONY: all clean
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