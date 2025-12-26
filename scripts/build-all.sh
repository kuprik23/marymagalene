#!/bin/bash
echo "Building all services..."
cd services
for dir in */; do
  echo "Building $dir..."
  cd $dir
  if [ -f "Cargo.toml" ]; then
    cargo build --release
  elif [ -f "build.gradle" ]; then
    ./gradlew build
  elif [ -f "package.json" ]; then
    npm run build
  fi
  cd ..
done
