### Comprehensive Tutorial: Setting Up C++ Development with Google Test and GitHub Actions on Ubuntu 24

This guide walks you through the process of setting up a development environment, integrating Google Test for unit testing, and automating tests with GitHub Actions.

---

### **Part 1: Setting Up Your Ubuntu Machine**

#### 1.1 Install Required Tools and Dependencies

Run the following commands to set up your environment:

```bash
# Update and upgrade system packages
sudo apt update && sudo apt upgrade -y

# Install Git for version control
sudo apt install git -y

# Install build tools (GCC, G++, Make, etc.)
sudo apt install build-essential -y

# Install CMake for build configuration
sudo apt install cmake -y
```

#### 1.2 Clone Your GitHub Repository

Navigate to the directory where you want to store the project and clone your repository:

```bash
# Change directory to your workspace
cd ~/workspace

# Clone your repository with submodules
git clone --recurse-submodules https://github.com/algosup/2024-2025-project-3-quickest-path-team-7.git

# Navigate to the project directory
cd 2024-2025-project-3-quickest-path-team-7
```

---

### **Part 2: Adding Google Test to Your Project**

#### 2.1 Include Google Test

1. Add Google Test as a submodule:
   ```bash
   git submodule add https://github.com/google/googletest.git
   git submodule update --init
   ```

2. Verify that the `googletest` directory appears in your project.

#### 2.2 Update `CMakeLists.txt`

Add the following to your root `CMakeLists.txt` file to include Google Test:

```cmake
cmake_minimum_required(VERSION 3.10)
project(QuickestPathTeam7)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 11)

# Include Google Test
add_subdirectory(googletest)

# Add Hello World executable
add_executable(hello_world test/hello_world.cpp)

# Add Unit Tests executable
add_executable(unit_tests test/unit_tests.cpp)
target_link_libraries(unit_tests gtest gtest_main)

# Enable testing
enable_testing()
add_test(NAME UnitTests COMMAND unit_tests)
```

---

### **Part 3: Create C++ Test Files**

#### 3.1 Create a "Hello World" File

1. Create `test/hello_world.cpp`:
   ```bash
   nano test/hello_world.cpp
   ```

2. Add the following content:
   ```cpp
   #include <iostream>

   int main() {
       std::cout << "Hello, World!" << std::endl;
       return 0;
   }
   ```

#### 3.2 Create a Google Test File

1. Create `test/unit_tests.cpp`:
   ```bash
   nano test/unit_tests.cpp
   ```

2. Add the following content:
   ```cpp
   #include <gtest/gtest.h>

   // A simple test case
   TEST(SampleTest, BasicAssertions) {
       // Check if 1 + 1 equals 2
       EXPECT_EQ(1 + 1, 2);
       // Check if 1 + 1 does not equal 3
       EXPECT_NE(1 + 1, 3);
   }

   int main(int argc, char **argv) {
       ::testing::InitGoogleTest(&argc, argv);
       return RUN_ALL_TESTS();
   }
   ```

---

### **Part 4: Build and Test Locally**

#### 4.1 Generate Build Files with CMake

Run the following commands to configure your project and generate build files:

```bash
mkdir -p build
cd build
cmake ..
```

#### 4.2 Build the Project

Compile the "Hello World" program and tests:

```bash
cmake --build .
```

#### 4.3 Run the Executables

1. Run the "Hello World" program:
   ```bash
   ./hello_world
   ```

   Output:
   ```
   Hello, World!
   ```

2. Run the unit tests:
   ```bash
   ./unit_tests
   ```

   Output:
   ```
   [==========] Running 1 test from 1 test suite.
   [ RUN      ] SampleTest.BasicAssertions
   [       OK ] SampleTest.BasicAssertions (0 ms)
   [==========] 1 test from 1 test suite ran. (0 ms total)
   [  PASSED  ] 1 test.
   ```

---

### **Part 5: Set Up GitHub Actions for CI**

#### 5.1 Create a GitHub Actions Workflow

1. Create a directory for GitHub Actions workflows:
   ```bash
   mkdir -p .github/workflows
   ```

2. Create a workflow file:
   ```bash
   nano .github/workflows/ci.yml
   ```

3. Add the following content to automate building and testing:
   ```yaml
   name: CI

   on:
     push:
       branches:
         - main
     pull_request:
       branches:
         - main

   jobs:
     build-and-test:
       runs-on: ubuntu-latest

       steps:
       - name: Checkout code
         uses: actions/checkout@v3
         with:
           submodules: recursive  # Fetch Google Test submodule

       - name: Install dependencies
         run: sudo apt-get update && sudo apt-get install -y cmake build-essential

       - name: Configure project
         run: cmake -S . -B build

       - name: Build project
         run: cmake --build build

       - name: Run unit tests
         run: cd build && ctest --output-on-failure
   ```

---

### **Part 6: Push Changes and Verify**

1. Commit and push your changes to GitHub:
   ```bash
   git add .
   git commit -m "Add Google Test and GitHub Actions CI"
   git push origin main
   ```

2. Verify the workflow execution:
   - Go to your GitHub repository.
   - Open the "Actions" tab.
   - Check that the CI workflow has run successfully.

---

### **Part 7: Summary**

- **Local Setup**:
  - Installed all necessary tools and dependencies.
  - Configured `CMake` to build both the main program and unit tests.
  - Successfully ran "Hello World" and Google Test locally.

- **GitHub Actions**:
  - Automated the build and test process using CI.
  - Ensured code integrity for every push and pull request.

You now have a fully functional C++ development environment integrated with Google Test and GitHub Actions! 🚀v