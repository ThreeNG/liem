PROGRAM=$(notdir $(CURDIR))

SRC_DIRS=src
INC_DIRS=$(SRC_DIRS)

CSRCS=$(foreach SRC,$(SRC_DIRS),$(wildcard $(SRC)/*.c))
CXXSRCS=$(foreach SRC,$(SRC_DIRS),$(wildcard $(SRC)/*.cpp))
SRCS=$(sort $(CXXSRCS) $(CSRCS))
OBJS=$(subst src/,obj/,$(CXXSRCS:.cpp=.o)) $(subst src/,obj/,$(CSRCS:.c=.o))

LIBS+=

out/$(PROGRAM) : $(OBJS)
FLAGS=-Wall -Werror=return-type -g $(foreach INC,$INC_DIRS,-I$INC)
CFLAGS=$(FLAGS)
CPPFLAGS=$(FLAGS)

NODEPS:=clean
DEPFILES=$(wildcard obj/*.d)

#Don't create dependencies when we're cleaning, for instance
ifeq (0, $(words $(findstring $(MAKECMDGOALS), $(NODEPS))))
#Chances are, these files don't exist.  GMake will create them and
#clean up automatically afterwards
-include $(DEPFILES)
endif

info:
	@printf "Program : %s\n" "$(PROGRAM)"
	@printf "Platform: %s\n" "$(PLATFORM)"
	@printf "\nInclude Directories:\n"
	@printf "%s\n" $(INC_DIRS)
	@printf "\nLibrary Files:\n"
	@printf "%s\n" $(LIBS)
	@printf "\nSource Files:\n"
	@printf "%s\n" $(SRCS)
	@printf "\nObject Files:\n"
	@printf "%s\n" $(OBJS)

obj/%.o : src/%.c
	@mkdir -p $(dir $@)
	@printf "%s\t<- %s\n" "$@" "$<"
	@$(CC) -c $(CFLAGS) $(foreach INC,$(INC_DIRS),-I$(INC)) -MMD -o $@ $<

obj/%.o : src/%.cpp
	@mkdir -p $(dir $@)
	@printf "%s\t<- %s\n" "$@" "$<"
	@$(CC) -c $(CPPFLAGS) $(foreach INC,$(INC_DIRS),-I$(INC)) -MMD -o $@ $<

clean:
	@rm -rf obj out

out/$(PROGRAM):
	@mkdir -p out
	@printf "%s\t<- %s\n\n" "$@" "$?"
	@cc -o $@ $(OBJS) $(foreach LIB,$(LIBS),-l$(LIB))
