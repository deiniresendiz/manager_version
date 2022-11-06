# Version manager

## Note: This is version beta of the package

Configuration generator for a specific environment.
Allows you to specify version settings during CI/CD compilation.
Mainly created to simplify the configuration and compilation of various environments in flutter.

## Characteristic
- flexible configuration for generating various environments
- allows specifying variable values for each environment
- allows the generation and change of personalized launcher and splash
- allows the change of applicationId according to the environment

### environment_config.json
```json
{
	"environments": [
		"testing",
		"production"
	],
	"application_id": {
		"testing": "com.example.testing",
		"production": "com.example.production"
	},
	"native_splash": {
		"default": {
			"color": "#ffffff",
			"image": "logo-development.png",
			"branding": "branding-development.png",
			"color_dark": "#121212",
			"image_dark": "logo-development.png",
			"branding_dark": "branding-development.png",
			"android_12":{
				"image": "logo-development.png",
	    		"icon_background_color": "#ffffff",
	    		"image_dark": "logo-development.png",
	    		"icon_background_color_dark": "#121212"
			}
		},
		"values": {
			"testing": {
				"image": "logo-development.png",
				"branding_dark": "branding-development.png",
				"android_12":{
					"image": "logo-development.png",
				}
			}
		}
	},
	"launcher_icons": {
		"default": {
			"android": "launcher_icon",
		  	"ios": true,
		  	"image_path": "icon.png",
		  	"min_sdk_android": 21, // android min sdk min:16, default 21
		  	"web": {
		  		"generate": true,
			    "image_path": "path/to/image.png",
			    "background_color": "#hexcode",
			    "theme_color": "#hexcode",
		  	},
		  	"windows": {
		  		"generate": true,
	    		"image_path": "path/to/image.png",
	    		"icon_size": 48 // min:48, max:256, default: 48
		  	}
		  },
		  "values": {
		  	"testing": {
		  		"android": "launcher_icon",
		  	}
		  }
	},
	"firebase_google_services": true, //only android and ios
	"variables": {
		"url_base": {
			"type": "string",//dafult string, accepted types: string, int, double and boolean
			"default": "wwww.goole.com", // required
			"values": { // optional
				"testing": "wwww.goole.com",
				"production": "wwww.goole.co"
			}
		}
	}
}
```