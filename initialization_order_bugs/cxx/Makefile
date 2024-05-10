# Makefile

RM = rm -f
CXX = g++
CXXFLAGS = -Wall -g
INCLUDE = 
LDFLAGS = 
LDPATH = 

PROGS =	link_a_first link_b_first link_a_first_asan link_b_first_asan

.PHONY: all
all: $(PROGS)
	@echo "build OK!"

clean:
	@$(RM) $(PROGS) *.o
	@echo "clean OK!"

link_a_first: a.cc b.cc
	$(CXX) -o $@ $^ $(CXXFLAGS) $(LDFLAGS) $(LDPATH)

link_b_first: b.cc a.cc
	$(CXX) -o $@ $^ $(CXXFLAGS) $(LDFLAGS) $(LDPATH)

link_a_first_asan: a.cc b.cc
	$(CXX) -o $@ $^ $(CXXFLAGS) -fsanitize=address -fno-omit-frame-pointer $(LDFLAGS) $(LDPATH)

link_b_first_asan: b.cc a.cc
	$(CXX) -o $@ $^ $(CXXFLAGS) -fsanitize=address -fno-omit-frame-pointer $(LDFLAGS) $(LDPATH)


