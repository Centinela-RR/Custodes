const dotenv = require('dotenv');
dotenv.config();
const os = require('os');
const fs = require('fs');
const plist = require('plist');
const path = require('path');
const xml2js = require('xml2js');
const parser = new xml2js.Parser();
const builder = new xml2js.Builder();
const ipAddress = process.env.TEST_HOST ?? "localhost";
const PACKAGE_NAME = 'com.centinela.custodes';

// Define the 'unsafe' option
const unsafe = process.env.npm_config_unsafe === 'true' || process.env.UNSAFE === 'true' || process.env.NODE_ENV === 'development';

// iOS
const ios = {
  CLIENT_ID: `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID_IOS}.apps.googleusercontent.com`,
  REVERSED_CLIENT_ID: `com.googleusercontent.apps.${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID_IOS}`,
  ANDROID_CLIENT_ID: `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID_ANDROID}.apps.googleusercontent.com`,
  API_KEY: process.env.API_KEY_IOS,
  GCM_SENDER_ID: process.env.GCM_SENDER_ID,
  PLIST_VERSION: '1',
  BUNDLE_ID: PACKAGE_NAME,
  PROJECT_ID: process.env.PROJECT_ID,
  STORAGE_BUCKET: `${process.env.PROJECT_ID}.appspot.com`,
  IS_ADS_ENABLED: false,
  IS_ANALYTICS_ENABLED: false,
  IS_APPINVITE_ENABLED: true,
  IS_GCM_ENABLED: true,
  IS_SIGNIN_ENABLED: true,
  GOOGLE_APP_ID: `1:${process.env.GCM_SENDER_ID}:ios:${process.env.APP_ID_IOS}`,
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
        "mobilesdk_app_id": `1:${process.env.GCM_SENDER_ID}:android:${process.env.APP_ID_ANDROID}`,
        "android_client_info": {
          "package_name": PACKAGE_NAME
        }
      },
      "oauth_client": [
        {
          "android_info" : {
            "certificate_hash" : process.env.CERTIFICATE_HASH,
            "package_name" : PACKAGE_NAME
          },
          "client_id" : `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID_ANDROID}.apps.googleusercontent.com`,
          "client_type" : 1
        },
        {
          "android_info" : {
            "certificate_hash" : process.env.DEBUG_CERTIFICATE_HASH,
            "package_name" : PACKAGE_NAME
          },
          "client_id" : `${process.env.GCM_SENDER_ID}-${process.env.DEBUG_CLIENT_ID_ANDROID}.apps.googleusercontent.com`,
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
              "client_id": `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID_IOS}.apps.googleusercontent.com`,
              "client_type": 2,
              "ios_info": {
                "bundle_id": PACKAGE_NAME
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
const pubCacheDir = path.join(os.homedir(), '.pub-cache', 'hosted', 'pub.dev');
const compassDir = fs.readdirSync(pubCacheDir).find(dir => dir.startsWith('flutter_compass'));

if (!compassDir) {
  console.error('Could not find flutter_compass directory');
  process.exit(1);
}

const gradleFilePath = path.join(pubCacheDir, compassDir, 'android', 'build.gradle');

// Define the pattern to match
const pattern = /android \{\n    compileSdkVersion/g;

// Check if the file exists
if (!fs.existsSync(gradleFilePath) || fs.lstatSync(gradleFilePath).isDirectory()) {
  console.log("The specified file does not exist or is not a file. Ignoring.");
} else {
  // Read the existing content of the build.gradle file
  const gradleContent = fs.readFileSync(gradleFilePath, 'utf8');

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
    console.log('Successfully updated the flutter_compass build.gradle file');
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
if (process.env.DEBUG === 'true') {
  const xmlFileDir = path.dirname(xmlFilePath);
  
  // Check if the directory exists, if not, create it
  if (!fs.existsSync(xmlFileDir)) {
    fs.mkdirSync(xmlFileDir, { recursive: true });
  }
  
  if (unsafe || !fs.existsSync(xmlFilePath)) {
    fs.writeFileSync(xmlFilePath, androidSecurityConfig);
  }
  
} else {  
  // Check if the file exists, if it does, delete it
  if (fs.existsSync(xmlFilePath)) {
    fs.unlinkSync(xmlFilePath);
  }
  
  console.log('Skipping network_security_config.xml file generation for non-debug builds');
}

// Add the tag to the AndroidManifest.xml file
const manifestFilePath = 'android/app/src/main/AndroidManifest.xml';
// Check if the AndroidManifest.xml file exists, and if it does, read its content
fs.readFile(manifestFilePath, 'utf-8', (err, data) => {
  if (err) throw err;

  parser.parseString(data, (err, result) => {
    if (err) throw err;

    const application = result['manifest']['application'][0]['$'];

    if (process.env.DEBUG === 'true') {
      application['android:networkSecurityConfig'] = '@xml/network_security_config';
    } else {
      delete application['android:networkSecurityConfig'];
    }

    const xml = builder.buildObject(result);
    fs.writeFile(manifestFilePath, xml, (err) => {
      if (err) throw err;
    });
  });
});

// Firebase Options

const firebaseOptions = `
// File generated by custom script.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// import 'firebase_options.dart';
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: '${process.env.API_KEY_WEB}',
    appId: '1:${process.env.GCM_SENDER_ID}:web:${process.env.APP_ID_WEB}',
    messagingSenderId: '${process.env.GCM_SENDER_ID}',
    projectId: '${process.env.PROJECT_ID}',
    authDomain: '${process.env.PROJECT_ID}.firebaseapp.com',
    databaseURL: 'https://${process.env.PROJECT_ID}-default-rtdb.firebaseio.com',
    storageBucket: '${process.env.PROJECT_ID}.appspot.com',
    measurementId: '${process.env.MEASUREMENT_ID_WEB}',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '${process.env.API_KEY_ANDROID}',
    appId: '1:${process.env.GCM_SENDER_ID}:android:${process.env.APP_ID_ANDROID}',
    messagingSenderId: '${process.env.GCM_SENDER_ID}',
    projectId: '${process.env.PROJECT_ID}',
    databaseURL: 'https://${process.env.PROJECT_ID}-default-rtdb.firebaseio.com',
    storageBucket: '${process.env.PROJECT_ID}.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '${process.env.API_KEY_IOS}',
    appId: '1:${process.env.GCM_SENDER_ID}:ios:${process.env.APP_ID_IOS}',
    messagingSenderId: '${process.env.GCM_SENDER_ID}',
    projectId: '${process.env.PROJECT_ID}',
    databaseURL: 'https://${process.env.PROJECT_ID}-default-rtdb.firebaseio.com',
    storageBucket: '${process.env.PROJECT_ID}.appspot.com',
    androidClientId: '${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID_ANDROID}.apps.googleusercontent.com',
    iosClientId: '${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID_IOS}.apps.googleusercontent.com',
    iosBundleId: '${PACKAGE_NAME}',
  );
}
`;

fs.writeFile('lib/modelo/firebase_options.dart', firebaseOptions, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
});