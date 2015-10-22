# ------------------------------------------------
# Generic Makefile
#
# Author: yanick.rochon@gmail.com
# Date  : 2011-08-10
#
# Changelog :
#   2010-11-05 - first version
#   2011-08-10 - added structure : sources, objects, binaries
#                thanks to http://stackoverflow.com/users/128940/beta
# ------------------------------------------------
# ------------------------------------------------
#
# Edited at
# Author: s000032001@gmail.com
# Date  : 2015-10-15
#
# Changelog:
#   2015-10-15 - add gtest 
#
# ------------------------------------------------

# project name (generate executable with this name)
TARGET   = main
TEST_BIN = test_main


GTEST_DIR = gtest
# change these to set the proper directories where each files should be
SRCDIR   = src
OBJDIR   = obj
BINDIR   = bin
INCDIR   = include
TESTDIR  = unittest


CXX       = g++
# compiling flags here
CXXFLAGS   = -g -Wall -Wextra -pthread -I$(INCDIR)

LINKER   = g++ -o
# linking flags here
LDFLAGS   = -Wall -lm -lpthread

SRCS      := $(wildcard $(SRCDIR)/*.cpp)
OBJS      := $(SRCS:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)
TEST_SRCS := $(wildcard $(TESTDIR)/*.cpp)
TEST_OBJS := $(TEST_SRCS:$(TESTDIR)/%.cpp=$(OBJDIR)/%.o)
rm       = rm -f

all: $(BINDIR)/$(TARGET)

test: $(BINDIR)/$(TEST_BIN)

$(BINDIR)/$(TEST_BIN): $(TEST_OBJS) $(filter-out $(OBJDIR)/main.o, $(OBJS))
	$(LINKER) $@ $^ $(GTEST_DIR)/gtest_main.a $(LDFLAGS) && $@

$(BINDIR)/$(TARGET): $(OBJS)
	$(LINKER) $@ $^ $(LDFLAGS) 

$(OBJS): $(OBJDIR)/%.o : $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(TEST_OBJS): $(OBJDIR)/%.o : $(TESTDIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@ -isystem $(GTEST_DIR)/include -include gtest/gtest.h

.PHONEY: clean
clean:
	$(rm) $(OBJS)

.PHONEY: remove
remove: clean
	$(rm) $(BINDIR)/$(TARGET)