SHELL := /bin/bash

BIN_NAME := gol
SDL_DIR := vendor/SDL
SDL_BUILD_DIR := $(realpath $(SDL_DIR))/build

KANTAN = kantan
KANTAN_FILES = src/main.kan src/sdl.kan
OBJ = gol.o

$(BIN_NAME) : $(KANTAN_FILES)
	if ! [ -d $(SDL_BUILD_DIR) ]; then \
		mkdir -p $(SDL_BUILD_DIR) ; \
		pushd $(SDL_BUILD_DIR) ; \
		../configure --prefix=$(SDL_BUILD_DIR) --exec-prefix=$(SDL_BUILD_DIR) && \
		make -j4 && make install; \
	fi ;
	$(KANTAN) $(KANTAN_FILES) -o $(OBJ) -g ; \
	LIBS=$$($(SDL_BUILD_DIR)/sdl2-config --static-libs); \
	gcc $(OBJ) $$LIBS -lSDL2 -o $(BIN_NAME) ; \
	rm $(OBJ)
