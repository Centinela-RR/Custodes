const dotenv = require('dotenv');
dotenv.config();
const fs = require('fs');
const plist = require('plist');

const ios = {
  CLIENT_ID: `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID2}.apps.googleusercontent.com`,
  REVERSED_CLIENT_ID: `com.googleusercontent.apps.${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID2}`,
  API_KEY: process.env.API_KEY,
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
          "client_id": `${process.env.GCM_SENDER_ID}-${process.env.CLIENT_ID}.apps.googleusercontent.com`,
          "client_type": 3
        }
      ],
      "api_key": [
        {
          "current_key": process.env.API_KEY
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

fs.writeFileSync('android/app/google-services.json', JSON.stringify(android, null, 2));

const xml = plist.build(ios);

fs.writeFileSync('ios/GoogleService-Info.plist', xml);