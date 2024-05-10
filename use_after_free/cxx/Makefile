
RM = rm -f
CXX = g++
CXXFLAGS = -Wall -g -fsanitize=address -fno-omit-frame-pointer
INCLUDES = 
LDFLAGS = -lasan 
LDPATH =

SOURCES = $(shell ls *.cpp)
PROGS = $(subst .cpp,,$(SOURCES))
#PROGS = $(SOURCES:%.cpp=%)

all: $(PROGS)
	@echo "PROGS = $(PROGS)" 

clean:
	$(RM) $(PROGS) *.o

%: %.cpp
	$(CXX) -o $@ $(CXXFLAGS) $(INCLUDE) $^ $(LDFLAGS) $(LDPATH)
