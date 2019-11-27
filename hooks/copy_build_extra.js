#!/usr/bin/env node

const fs = require('fs')
fs.copyFileSync("./build-extras.gradle", "./platforms/android/build-extras.gradle");
