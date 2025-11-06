#!/bin/bash

# 🚀 Gaspi App Development Helper Script
# This script provides quick commands for common development tasks

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Gaspi Mobile App - Dev Helper     ║${NC}"
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo ""

# Function to print colored output
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Main menu
echo "Select an option:"
echo "1) Setup - Install dependencies & generate code"
echo "2) Run app"
echo "3) Generate code (one-time)"
echo "4) Watch mode (auto-generate)"
echo "5) Clean & rebuild"
echo "6) Run tests"
echo "7) Build APK (release)"
echo "8) Build iOS (release)"
echo "9) Check for outdated packages"
echo "0) Exit"
echo ""
read -p "Enter your choice: " choice

case $choice in
    1)
        print_info "Installing dependencies..."
        flutter pub get
        
        if [ $? -eq 0 ]; then
            print_success "Dependencies installed!"
            print_info "Generating code..."
            dart run build_runner build --delete-conflicting-outputs
            
            if [ $? -eq 0 ]; then
                print_success "Code generation completed!"
                print_success "Setup complete! You can now run the app."
            else
                print_error "Code generation failed!"
            fi
        else
            print_error "Failed to install dependencies!"
        fi
        ;;
        
    2)
        print_info "Running app..."
        flutter run
        ;;
        
    3)
        print_info "Generating code (one-time)..."
        dart run build_runner build --delete-conflicting-outputs
        
        if [ $? -eq 0 ]; then
            print_success "Code generation completed!"
        else
            print_error "Code generation failed!"
        fi
        ;;
        
    4)
        print_info "Starting watch mode (press Ctrl+C to stop)..."
        print_warning "This will auto-generate code when files change"
        dart run build_runner watch --delete-conflicting-outputs
        ;;
        
    5)
        print_info "Cleaning project..."
        flutter clean
        
        print_info "Getting dependencies..."
        flutter pub get
        
        print_info "Generating code..."
        dart run build_runner build --delete-conflicting-outputs
        
        if [ $? -eq 0 ]; then
            print_success "Clean & rebuild completed!"
        else
            print_error "Rebuild failed!"
        fi
        ;;
        
    6)
        print_info "Running tests..."
        flutter test
        
        if [ $? -eq 0 ]; then
            print_success "All tests passed!"
        else
            print_error "Some tests failed!"
        fi
        ;;
        
    7)
        print_info "Building APK (release)..."
        flutter build apk --release
        
        if [ $? -eq 0 ]; then
            print_success "APK built successfully!"
            print_info "Location: build/app/outputs/flutter-apk/app-release.apk"
        else
            print_error "APK build failed!"
        fi
        ;;
        
    8)
        print_info "Building iOS (release)..."
        flutter build ios --release
        
        if [ $? -eq 0 ]; then
            print_success "iOS build completed!"
        else
            print_error "iOS build failed!"
        fi
        ;;
        
    9)
        print_info "Checking for outdated packages..."
        flutter pub outdated
        ;;
        
    0)
        print_info "Goodbye!"
        exit 0
        ;;
        
    *)
        print_error "Invalid choice!"
        exit 1
        ;;
esac

echo ""
print_info "Done!"
