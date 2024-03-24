const dotenv = require('dotenv');
dotenv.config();
const fs = require('fs');
const plist = require('plist');
const path = require('path');
const ipAddress = process.env.TEST_HOST ?? "localhost";

// Define the 'unsafe' option
const unsafe = process.env.npm_config_unsafe === 'true' || process.env.UNSAFE === 'true' || process.env.NODE_ENV === 'development';

// iOS
const ios = {
  CLIENT_ID: `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID2}.apps.googleusercontent.com`,
  REVERSED_CLIENT_ID: `com.googleusercontent.apps.${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID2}`,
  ANDROID_CLIENT_ID: `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID3}.apps.googleusercontent.com`,
  API_KEY: process.env.API_KEY_IOS,
  GCM_SENDER_ID: process.env.GCM_SENDER_ID,
  PLIST_VERSION: '1',
  BUNDLE_ID: process.env.PACKAGE_NAME,
  PROJECT_ID: process.env.PROJECT_ID,
  STORAGE_BUCKET: `${process.env.PROJECT_ID}.appspot.com`,
  IS_ADS_ENABLED: false,
  IS_ANALYTICS_ENABLED: false,
  IS_APPINVITE_ENABLED: true,
  IS_GCM_ENABLED: true,
  IS_SIGNIN_ENABLED: true,
  GOOGLE_APP_ID: `1:${process.env.GCM_SENDER_ID}:ios:${process.env.APP_ID}`,
  DATABASE_URL: `https://${process.env.PROJECT_ID}-default-rtdb.firebaseio.com`,
};

// Android
const android = {
  "project_info": {
    "project_number": process.env.GCM_SENDER_ID,
    "firebase_url": `https://${process.env.PROJECT_ID}-default-rtdb.firebaseio.com`,
    "project_id": process.env.PROJECT_ID,
    "storage_bucket": `${process.env.PROJECT_ID}.appspot.com`
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": `1:${process.env.GCM_SENDER_ID}:android:${process.env.SDK_APP_ID}`,
        "android_client_info": {
          "package_name": process.env.PACKAGE_NAME
        }
      },
      "oauth_client": [
        {
          "android_info" : {
            "certificate_hash" : process.env.CERTIFICATE_HASH,
            "package_name" : process.env.PACKAGE_NAME
          },
          "client_id" : `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID3}.apps.googleusercontent.com`,
          "client_type" : 1
        },
        {
          "android_info" : {
            "certificate_hash" : process.env.DEBUG_CERTIFICATE_HASH,
            "package_name" : process.env.PACKAGE_NAME
          },
          "client_id" : `${process.env.GCM_SENDER_ID}-${process.env.DEBUG_CLIENT_ID_3}.apps.googleusercontent.com`,
          "client_type" : 1
        },
        {
          "client_id": `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID}.apps.googleusercontent.com`,
          "client_type": 3
        }
      ],
      "api_key": [
        {
          "current_key": process.env.API_KEY_ANDROID
        }
      ],
      "services": {
        "appinvite_service": {
          "other_platform_oauth_client": [
            {
              "client_id": `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID}.apps.googleusercontent.com`,
              "client_type": 3
            },
            {
              "client_id": `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID2}.apps.googleusercontent.com`,
              "client_type": 2,
              "ios_info": {
                "bundle_id": process.env.PACKAGE_NAME
              }
            }
          ]
        }
      }
    }
  ],
  "configuration_version": "1"
};

const androidSecurityConfig = `
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">${ipAddress}</domain>
    </domain-config>
</network-security-config>
`;

// START_BLOCK: Fixing flutter_compass issue

// Define the namespace
const namespace = "namespace 'com.hemanthraj.fluttercompass'";

// Define the path to the build.gradle file
const gradleFilePath = 'ios/.symlinks/plugins/flutter_compass/android/build.gradle';

// Read the existing content of the build.gradle file
const gradleContent = fs.readFileSync(gradleFilePath, 'utf8');

// Define the pattern to match
const pattern = /android \{\n    compileSdkVersion/g;

// Check if the ios/.symlinks directory exists
const iosSymlinksDir = 'ios/.symlinks';
if (!fs.existsSync(iosSymlinksDir) || !fs.lstatSync(iosSymlinksDir).isDirectory()) {
  console.log("ios/.symlinks directory does not exist or is not a directory. Ignoring.");
} else {
  let updatedGradleContent = '';
  
  // Check if the pattern matches
  if (pattern.test(gradleContent)) {
    // If the pattern matches, insert the namespace line
    updatedGradleContent = gradleContent.replace(pattern, `android {\n    ${namespace}\n    compileSdkVersion`);
  } else if (unsafe) {
    // If the 'unsafe' option is set, replace the entire 'android' block
    updatedGradleContent = gradleContent.replace(/android \{[\s\S]*\}/g, `android {\n    ${namespace}\n    compileSdkVersion 30\n    defaultConfig {\n        minSdkVersion 20\n        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"\n    }\n    lintOptions {\n        disable 'InvalidPackage'\n    }\n}`);
  }

  if (updatedGradleContent) {
    fs.writeFileSync(gradleFilePath, updatedGradleContent);
  }
}

// END_BLOCK: End of fixing flutter_compass issue


// Write the config to the respective files

// iOS Google Services
if (unsafe || !fs.existsSync('ios/GoogleService-Info.plist')) {
  fs.writeFileSync('ios/GoogleService-Info.plist', plist.build(ios));
}

// Android Google Services
if (unsafe || !fs.existsSync('android/app/google-services.json')) {
  fs.writeFileSync('android/app/google-services.json', JSON.stringify(android, null, 2));
}

// Android Network Security Config
const xmlFilePath = 'android/app/src/main/res/xml/network_security_config.xml';
const xmlFileDir = path.dirname(xmlFilePath);

// Check if the directory exists, if not, create it
if (!fs.existsSync(xmlFileDir)) {
  fs.mkdirSync(xmlFileDir, { recursive: true });
}

if (unsafe || !fs.existsSync(xmlFilePath)) {
  fs.writeFileSync(xmlFilePath, androidSecurityConfig);
}