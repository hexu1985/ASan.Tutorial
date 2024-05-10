
RM = rm -f
CXX = g++
CXXFLAGS = -Wall -g -fsanitize=address -fno-omit-frame-pointer
INCLUDES = 
LDFLAGS = -lasan 
LDPATH =

SOURCES = $(shell ls *.cc)
PROGS = $(subst .cc,,$(SOURCES))
#PROGS = $(SOURCES:%.cc=%)

all: $(PROGS)
	@echo "PROGS = $(PROGS)" 

clean:
	$(RM) $(PROGS) *.o

%: %.cc
	$(CXX) -o $@ $(CXXFLAGS) $(INCLUDE) $^ $(LDFLAGS) $(LDPATH)
