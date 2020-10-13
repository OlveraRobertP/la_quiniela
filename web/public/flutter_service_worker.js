'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "17f58668c9e89409e2af6aeb17e4f7a1",
"/": "f6492f73d964a64ee1a56a3114dd48f5",
".firebase/hosting.cHVibGlj.cache": "5d6b6573dc7350013d6c7f069c57c6ac",
"main.dart.js": "8e837e0cfa27b2353cd7c69e2c3f4e49",
"favicon.png": "b04b539f32f12c4d2548a4f56b8bd1d1",
"public/index.html": "896f497a26ebf47a827f264ca512405c",
"public/main.dart.js": "b9cc9f29179af213d5db8264bfc17f5f",
"public/favicon.png": "b04b539f32f12c4d2548a4f56b8bd1d1",
"public/public/index.html": "34cb6de3bfd2e5441b031ab0ceae6c64",
"public/public/main.dart.js": "effbcbec9787d85b9603fcae5ce422f8",
"public/public/favicon.png": "b04b539f32f12c4d2548a4f56b8bd1d1",
"public/public/public/index.html": "f6492f73d964a64ee1a56a3114dd48f5",
"public/public/public/main.dart.js": "74883f3f6a5b7df3362c5ab258d8b88c",
"public/public/public/favicon.png": "b04b539f32f12c4d2548a4f56b8bd1d1",
"public/public/public/icons/Icon-192.png": "47a88a26ad46b3fc21ffc8f98e932530",
"public/public/public/icons/Icon-512.png": "97678af1ad3a919dd3bbb9cb3716d809",
"public/public/public/manifest.json": "d29b9ed5fe61531170155dfaccd844e3",
"public/public/public/firebase.json": "9d1146eec87945fcc0e687f5cd1868df",
"public/public/public/assets/AssetManifest.json": "0f3c7cbd4985ede69a0e90868d26ea72",
"public/public/public/assets/NOTICES": "009a8787bd81a84e2656882be26c354c",
"public/public/public/assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"public/public/public/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b14fcf3ee94e3ace300b192e9e7c8c5d",
"public/public/public/assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"public/public/public/assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"public/public/public/assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"public/public/public/assets/packages/flutter_signin_button/assets/logos/google_dark.png": "c32e2778b1d6552b7b4055e49407036f",
"public/public/public/assets/packages/flutter_signin_button/assets/logos/google_light.png": "f71e2d0b0a2bc7d1d8ab757194a02cac",
"public/public/public/assets/packages/flutter_signin_button/assets/logos/2.0x/google_dark.png": "937022ea241c167c8ce463d2ef7ed105",
"public/public/public/assets/packages/flutter_signin_button/assets/logos/2.0x/google_light.png": "8f10eb93525f0c0259c5e97271796b3c",
"public/public/public/assets/packages/flutter_signin_button/assets/logos/2.0x/facebook_new.png": "83bf0093719b2db2b16e2839aee1069f",
"public/public/public/assets/packages/flutter_signin_button/assets/logos/3.0x/google_dark.png": "ac553491f0002941159b405c2d37e8c6",
"public/public/public/assets/packages/flutter_signin_button/assets/logos/3.0x/google_light.png": "fe46d37e7d6a16ecd15d5908a795b4ee",
"public/public/public/assets/packages/flutter_signin_button/assets/logos/3.0x/facebook_new.png": "12531aa3541312b7e5ddd41223fc60cb",
"public/public/public/assets/packages/flutter_signin_button/assets/logos/facebook_new.png": "e1dff5c319a9d7898aee817f624336e3",
"public/public/public/assets/fonts/MaterialIcons-Regular.otf": "a68d2a28c526b3b070aefca4bac93d25",
"public/public/public/assets/assets/images/logo.png": "54f9003368695df2d71b40e0e1525e75",
"public/public/public/assets/assets/images/2.png": "2db02326ea792d43cb16bef3a199aeaf",
"public/public/public/assets/assets/images/not_found.png": "7da78f1fa8fedb5255b99570b875479e",
"public/public/public/assets/assets/nfl/packers.png": "ac653cefc97328ded3c10fdb9888ae03",
"public/public/public/assets/assets/nfl/dolphins.png": "2fd8881e19809befb1a520c55fc6d963",
"public/public/public/assets/assets/nfl/vikings.png": "046e45e28333d5f2887585b5c14df899",
"public/public/public/assets/assets/nfl/jagars.png": "6e486ad7fb4c576aec46b398a030aef6",
"public/public/public/assets/assets/nfl/bengals.png": "68804be43ae375093d14b9c31da9db30",
"public/public/public/assets/assets/nfl/bills.png": "bf176005842f1d0448cc230bab7e95df",
"public/public/public/assets/assets/nfl/ravens.png": "cdceeb930e9b7b6fc6306d54bd704b02",
"public/public/public/assets/assets/nfl/lions.png": "ac4d5ddeb4b87048c411095925ee0760",
"public/public/public/assets/assets/nfl/cardinals.png": "ce5bcd709d2e899cdc37f14ad9ec05c3",
"public/public/public/assets/assets/nfl/bucaners.png": "f749bd80af64b0f852b156fed0ea2c48",
"public/public/public/assets/assets/nfl/49ers.png": "3a139397c2d29523b9970122331b71d1",
"public/public/public/assets/assets/nfl/gigants.png": "7d43631a8e12b2edb8e98a1a61879058",
"public/public/public/assets/assets/nfl/browns.png": "dad620b18671dadaaa8d9bec3da03b33",
"public/public/public/assets/assets/nfl/cheifs.png": "d37b511d8559aa5afa2c059638d249b0",
"public/public/public/assets/assets/nfl/raiders.png": "9be9b4c3fd08118530d91e62cecf841b",
"public/public/public/assets/assets/nfl/seahawks.png": "6a7417575b80d5d6e0d92ff3b6f4a372",
"public/public/public/assets/assets/nfl/titans.png": "54f5c30a6dc8549463ef45e233fb7bf5",
"public/public/public/assets/assets/nfl/colts.png": "0b4a2e5271d677e7a86a63077c104215",
"public/public/public/assets/assets/nfl/falcons.png": "e5119ba26e55a366d9e29d5f3a258e56",
"public/public/public/assets/assets/nfl/stelers.png": "b868135b0a603df6094f53f437826a60",
"public/public/public/assets/assets/nfl/cowboys.png": "9a044eb8168155be10852d9f351af44b",
"public/public/public/assets/assets/nfl/texans.png": "275b9a7003578d33c88202a38577d671",
"public/public/public/assets/assets/nfl/broncos.png": "52073ff4bd06a654a60aa3c4236791ac",
"public/public/public/assets/assets/nfl/jets.png": "24279ee40e1a5133b03ac08faf9f9535",
"public/public/public/assets/assets/nfl/pats.png": "85a2b9ccdafe3a0a6edfb9fcdb49e078",
"public/public/public/assets/assets/nfl/saints.png": "ee6a2bedd61bd32d55a38d38344d71e1",
"public/public/public/assets/assets/nfl/panterts.png": "0f6411229eb04244f3d3d71ac07ce4c1",
"public/public/public/assets/assets/nfl/wfutball.png": "8cc287e7d50a6f04b8db3ef9654eb8e8",
"public/public/public/assets/assets/nfl/rams.png": "d55db625bbadd2f0e6b3b0f6859f2bc0",
"public/public/public/assets/assets/nfl/eagles.png": "4df79eb444b777f28b66d90fa003d6ed",
"public/public/public/assets/assets/nfl/bears.png": "30f971c16565166535b4d12b26be7dfe",
"public/public/public/assets/assets/nfl/chargers.png": "8b282af9dfb49aed79a8c78ac6d56695",
"public/public/icons/Icon-192.png": "47a88a26ad46b3fc21ffc8f98e932530",
"public/public/icons/Icon-512.png": "97678af1ad3a919dd3bbb9cb3716d809",
"public/public/manifest.json": "d29b9ed5fe61531170155dfaccd844e3",
"public/public/firebase.json": "d175a0df63183d457c585ac575284f55",
"public/public/assets/AssetManifest.json": "0f3c7cbd4985ede69a0e90868d26ea72",
"public/public/assets/NOTICES": "ac0c80cb3701ad9ae0c85dbc1a04cc5c",
"public/public/assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"public/public/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b14fcf3ee94e3ace300b192e9e7c8c5d",
"public/public/assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"public/public/assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"public/public/assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"public/public/assets/packages/flutter_signin_button/assets/logos/google_dark.png": "c32e2778b1d6552b7b4055e49407036f",
"public/public/assets/packages/flutter_signin_button/assets/logos/google_light.png": "f71e2d0b0a2bc7d1d8ab757194a02cac",
"public/public/assets/packages/flutter_signin_button/assets/logos/2.0x/google_dark.png": "937022ea241c167c8ce463d2ef7ed105",
"public/public/assets/packages/flutter_signin_button/assets/logos/2.0x/google_light.png": "8f10eb93525f0c0259c5e97271796b3c",
"public/public/assets/packages/flutter_signin_button/assets/logos/2.0x/facebook_new.png": "83bf0093719b2db2b16e2839aee1069f",
"public/public/assets/packages/flutter_signin_button/assets/logos/3.0x/google_dark.png": "ac553491f0002941159b405c2d37e8c6",
"public/public/assets/packages/flutter_signin_button/assets/logos/3.0x/google_light.png": "fe46d37e7d6a16ecd15d5908a795b4ee",
"public/public/assets/packages/flutter_signin_button/assets/logos/3.0x/facebook_new.png": "12531aa3541312b7e5ddd41223fc60cb",
"public/public/assets/packages/flutter_signin_button/assets/logos/facebook_new.png": "e1dff5c319a9d7898aee817f624336e3",
"public/public/assets/fonts/MaterialIcons-Regular.otf": "a68d2a28c526b3b070aefca4bac93d25",
"public/public/assets/assets/images/logo.png": "54f9003368695df2d71b40e0e1525e75",
"public/public/assets/assets/images/2.png": "2db02326ea792d43cb16bef3a199aeaf",
"public/public/assets/assets/images/not_found.png": "7da78f1fa8fedb5255b99570b875479e",
"public/public/assets/assets/nfl/packers.png": "ac653cefc97328ded3c10fdb9888ae03",
"public/public/assets/assets/nfl/dolphins.png": "2fd8881e19809befb1a520c55fc6d963",
"public/public/assets/assets/nfl/vikings.png": "046e45e28333d5f2887585b5c14df899",
"public/public/assets/assets/nfl/jagars.png": "6e486ad7fb4c576aec46b398a030aef6",
"public/public/assets/assets/nfl/bengals.png": "68804be43ae375093d14b9c31da9db30",
"public/public/assets/assets/nfl/bills.png": "bf176005842f1d0448cc230bab7e95df",
"public/public/assets/assets/nfl/ravens.png": "cdceeb930e9b7b6fc6306d54bd704b02",
"public/public/assets/assets/nfl/lions.png": "ac4d5ddeb4b87048c411095925ee0760",
"public/public/assets/assets/nfl/cardinals.png": "ce5bcd709d2e899cdc37f14ad9ec05c3",
"public/public/assets/assets/nfl/bucaners.png": "f749bd80af64b0f852b156fed0ea2c48",
"public/public/assets/assets/nfl/49ers.png": "3a139397c2d29523b9970122331b71d1",
"public/public/assets/assets/nfl/gigants.png": "7d43631a8e12b2edb8e98a1a61879058",
"public/public/assets/assets/nfl/browns.png": "dad620b18671dadaaa8d9bec3da03b33",
"public/public/assets/assets/nfl/cheifs.png": "d37b511d8559aa5afa2c059638d249b0",
"public/public/assets/assets/nfl/raiders.png": "9be9b4c3fd08118530d91e62cecf841b",
"public/public/assets/assets/nfl/seahawks.png": "6a7417575b80d5d6e0d92ff3b6f4a372",
"public/public/assets/assets/nfl/titans.png": "54f5c30a6dc8549463ef45e233fb7bf5",
"public/public/assets/assets/nfl/colts.png": "0b4a2e5271d677e7a86a63077c104215",
"public/public/assets/assets/nfl/falcons.png": "e5119ba26e55a366d9e29d5f3a258e56",
"public/public/assets/assets/nfl/stelers.png": "b868135b0a603df6094f53f437826a60",
"public/public/assets/assets/nfl/cowboys.png": "9a044eb8168155be10852d9f351af44b",
"public/public/assets/assets/nfl/texans.png": "275b9a7003578d33c88202a38577d671",
"public/public/assets/assets/nfl/broncos.png": "52073ff4bd06a654a60aa3c4236791ac",
"public/public/assets/assets/nfl/jets.png": "24279ee40e1a5133b03ac08faf9f9535",
"public/public/assets/assets/nfl/pats.png": "85a2b9ccdafe3a0a6edfb9fcdb49e078",
"public/public/assets/assets/nfl/saints.png": "ee6a2bedd61bd32d55a38d38344d71e1",
"public/public/assets/assets/nfl/panterts.png": "0f6411229eb04244f3d3d71ac07ce4c1",
"public/public/assets/assets/nfl/wfutball.png": "8cc287e7d50a6f04b8db3ef9654eb8e8",
"public/public/assets/assets/nfl/rams.png": "d55db625bbadd2f0e6b3b0f6859f2bc0",
"public/public/assets/assets/nfl/eagles.png": "4df79eb444b777f28b66d90fa003d6ed",
"public/public/assets/assets/nfl/bears.png": "30f971c16565166535b4d12b26be7dfe",
"public/public/assets/assets/nfl/chargers.png": "8b282af9dfb49aed79a8c78ac6d56695",
"public/icons/Icon-192.png": "47a88a26ad46b3fc21ffc8f98e932530",
"public/icons/Icon-512.png": "97678af1ad3a919dd3bbb9cb3716d809",
"public/manifest.json": "d29b9ed5fe61531170155dfaccd844e3",
"public/firebase.json": "d175a0df63183d457c585ac575284f55",
"public/assets/AssetManifest.json": "9e910763c496604425b60ecb52a88447",
"public/assets/NOTICES": "ac0c80cb3701ad9ae0c85dbc1a04cc5c",
"public/assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"public/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b14fcf3ee94e3ace300b192e9e7c8c5d",
"public/assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"public/assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"public/assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"public/assets/packages/flutter_signin_button/assets/logos/google_dark.png": "c32e2778b1d6552b7b4055e49407036f",
"public/assets/packages/flutter_signin_button/assets/logos/google_light.png": "f71e2d0b0a2bc7d1d8ab757194a02cac",
"public/assets/packages/flutter_signin_button/assets/logos/2.0x/google_dark.png": "937022ea241c167c8ce463d2ef7ed105",
"public/assets/packages/flutter_signin_button/assets/logos/2.0x/google_light.png": "8f10eb93525f0c0259c5e97271796b3c",
"public/assets/packages/flutter_signin_button/assets/logos/2.0x/facebook_new.png": "83bf0093719b2db2b16e2839aee1069f",
"public/assets/packages/flutter_signin_button/assets/logos/3.0x/google_dark.png": "ac553491f0002941159b405c2d37e8c6",
"public/assets/packages/flutter_signin_button/assets/logos/3.0x/google_light.png": "fe46d37e7d6a16ecd15d5908a795b4ee",
"public/assets/packages/flutter_signin_button/assets/logos/3.0x/facebook_new.png": "12531aa3541312b7e5ddd41223fc60cb",
"public/assets/packages/flutter_signin_button/assets/logos/facebook_new.png": "e1dff5c319a9d7898aee817f624336e3",
"public/assets/fonts/MaterialIcons-Regular.otf": "a68d2a28c526b3b070aefca4bac93d25",
"public/assets/assets/images/logo.png": "54f9003368695df2d71b40e0e1525e75",
"public/assets/assets/images/2.png": "2db02326ea792d43cb16bef3a199aeaf",
"public/assets/assets/images/not_found.png": "7da78f1fa8fedb5255b99570b875479e",
"public/assets/assets/nfl/packers.png": "ac653cefc97328ded3c10fdb9888ae03",
"public/assets/assets/nfl/dolphins.png": "2fd8881e19809befb1a520c55fc6d963",
"public/assets/assets/nfl/vikings.png": "046e45e28333d5f2887585b5c14df899",
"public/assets/assets/nfl/bengals.png": "68804be43ae375093d14b9c31da9db30",
"public/assets/assets/nfl/bills.png": "bf176005842f1d0448cc230bab7e95df",
"public/assets/assets/nfl/ravens.png": "cdceeb930e9b7b6fc6306d54bd704b02",
"public/assets/assets/nfl/jaguars.png": "6e486ad7fb4c576aec46b398a030aef6",
"public/assets/assets/nfl/lions.png": "ac4d5ddeb4b87048c411095925ee0760",
"public/assets/assets/nfl/cardinals.png": "ce5bcd709d2e899cdc37f14ad9ec05c3",
"public/assets/assets/nfl/buccaneers.png": "f749bd80af64b0f852b156fed0ea2c48",
"public/assets/assets/nfl/49ers.png": "3a139397c2d29523b9970122331b71d1",
"public/assets/assets/nfl/browns.png": "dad620b18671dadaaa8d9bec3da03b33",
"public/assets/assets/nfl/raiders.png": "9be9b4c3fd08118530d91e62cecf841b",
"public/assets/assets/nfl/seahawks.png": "6a7417575b80d5d6e0d92ff3b6f4a372",
"public/assets/assets/nfl/titans.png": "54f5c30a6dc8549463ef45e233fb7bf5",
"public/assets/assets/nfl/colts.png": "0b4a2e5271d677e7a86a63077c104215",
"public/assets/assets/nfl/falcons.png": "e5119ba26e55a366d9e29d5f3a258e56",
"public/assets/assets/nfl/cowboys.png": "9a044eb8168155be10852d9f351af44b",
"public/assets/assets/nfl/panthers.png": "0f6411229eb04244f3d3d71ac07ce4c1",
"public/assets/assets/nfl/texans.png": "275b9a7003578d33c88202a38577d671",
"public/assets/assets/nfl/broncos.png": "52073ff4bd06a654a60aa3c4236791ac",
"public/assets/assets/nfl/wsh.png": "8cc287e7d50a6f04b8db3ef9654eb8e8",
"public/assets/assets/nfl/chiefs.png": "d37b511d8559aa5afa2c059638d249b0",
"public/assets/assets/nfl/jets.png": "24279ee40e1a5133b03ac08faf9f9535",
"public/assets/assets/nfl/saints.png": "ee6a2bedd61bd32d55a38d38344d71e1",
"public/assets/assets/nfl/rams.png": "d55db625bbadd2f0e6b3b0f6859f2bc0",
"public/assets/assets/nfl/eagles.png": "4df79eb444b777f28b66d90fa003d6ed",
"public/assets/assets/nfl/steelers.png": "b868135b0a603df6094f53f437826a60",
"public/assets/assets/nfl/patriots.png": "85a2b9ccdafe3a0a6edfb9fcdb49e078",
"public/assets/assets/nfl/bears.png": "30f971c16565166535b4d12b26be7dfe",
"public/assets/assets/nfl/chargers.png": "8b282af9dfb49aed79a8c78ac6d56695",
"public/assets/assets/nfl/giants.png": "7d43631a8e12b2edb8e98a1a61879058",
"icons/Icon-192.png": "47a88a26ad46b3fc21ffc8f98e932530",
"icons/Icon-512.png": "97678af1ad3a919dd3bbb9cb3716d809",
"manifest.json": "d29b9ed5fe61531170155dfaccd844e3",
"firebase.json": "d175a0df63183d457c585ac575284f55",
"assets/AssetManifest.json": "9e910763c496604425b60ecb52a88447",
"assets/NOTICES": "ac0c80cb3701ad9ae0c85dbc1a04cc5c",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b14fcf3ee94e3ace300b192e9e7c8c5d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"assets/packages/flutter_signin_button/assets/logos/google_dark.png": "c32e2778b1d6552b7b4055e49407036f",
"assets/packages/flutter_signin_button/assets/logos/google_light.png": "f71e2d0b0a2bc7d1d8ab757194a02cac",
"assets/packages/flutter_signin_button/assets/logos/2.0x/google_dark.png": "937022ea241c167c8ce463d2ef7ed105",
"assets/packages/flutter_signin_button/assets/logos/2.0x/google_light.png": "8f10eb93525f0c0259c5e97271796b3c",
"assets/packages/flutter_signin_button/assets/logos/2.0x/facebook_new.png": "83bf0093719b2db2b16e2839aee1069f",
"assets/packages/flutter_signin_button/assets/logos/3.0x/google_dark.png": "ac553491f0002941159b405c2d37e8c6",
"assets/packages/flutter_signin_button/assets/logos/3.0x/google_light.png": "fe46d37e7d6a16ecd15d5908a795b4ee",
"assets/packages/flutter_signin_button/assets/logos/3.0x/facebook_new.png": "12531aa3541312b7e5ddd41223fc60cb",
"assets/packages/flutter_signin_button/assets/logos/facebook_new.png": "e1dff5c319a9d7898aee817f624336e3",
"assets/fonts/MaterialIcons-Regular.otf": "a68d2a28c526b3b070aefca4bac93d25",
"assets/assets/images/logo.png": "54f9003368695df2d71b40e0e1525e75",
"assets/assets/images/2.png": "2db02326ea792d43cb16bef3a199aeaf",
"assets/assets/images/not_found.png": "7da78f1fa8fedb5255b99570b875479e",
"assets/assets/nfl/packers.png": "ac653cefc97328ded3c10fdb9888ae03",
"assets/assets/nfl/dolphins.png": "2fd8881e19809befb1a520c55fc6d963",
"assets/assets/nfl/vikings.png": "046e45e28333d5f2887585b5c14df899",
"assets/assets/nfl/bengals.png": "68804be43ae375093d14b9c31da9db30",
"assets/assets/nfl/bills.png": "bf176005842f1d0448cc230bab7e95df",
"assets/assets/nfl/ravens.png": "cdceeb930e9b7b6fc6306d54bd704b02",
"assets/assets/nfl/jaguars.png": "6e486ad7fb4c576aec46b398a030aef6",
"assets/assets/nfl/lions.png": "ac4d5ddeb4b87048c411095925ee0760",
"assets/assets/nfl/cardinals.png": "ce5bcd709d2e899cdc37f14ad9ec05c3",
"assets/assets/nfl/buccaneers.png": "f749bd80af64b0f852b156fed0ea2c48",
"assets/assets/nfl/49ers.png": "3a139397c2d29523b9970122331b71d1",
"assets/assets/nfl/browns.png": "dad620b18671dadaaa8d9bec3da03b33",
"assets/assets/nfl/raiders.png": "9be9b4c3fd08118530d91e62cecf841b",
"assets/assets/nfl/seahawks.png": "6a7417575b80d5d6e0d92ff3b6f4a372",
"assets/assets/nfl/titans.png": "54f5c30a6dc8549463ef45e233fb7bf5",
"assets/assets/nfl/colts.png": "0b4a2e5271d677e7a86a63077c104215",
"assets/assets/nfl/falcons.png": "e5119ba26e55a366d9e29d5f3a258e56",
"assets/assets/nfl/cowboys.png": "9a044eb8168155be10852d9f351af44b",
"assets/assets/nfl/panthers.png": "0f6411229eb04244f3d3d71ac07ce4c1",
"assets/assets/nfl/texans.png": "275b9a7003578d33c88202a38577d671",
"assets/assets/nfl/broncos.png": "52073ff4bd06a654a60aa3c4236791ac",
"assets/assets/nfl/wsh.png": "8cc287e7d50a6f04b8db3ef9654eb8e8",
"assets/assets/nfl/chiefs.png": "d37b511d8559aa5afa2c059638d249b0",
"assets/assets/nfl/jets.png": "24279ee40e1a5133b03ac08faf9f9535",
"assets/assets/nfl/saints.png": "ee6a2bedd61bd32d55a38d38344d71e1",
"assets/assets/nfl/rams.png": "d55db625bbadd2f0e6b3b0f6859f2bc0",
"assets/assets/nfl/eagles.png": "4df79eb444b777f28b66d90fa003d6ed",
"assets/assets/nfl/steelers.png": "b868135b0a603df6094f53f437826a60",
"assets/assets/nfl/patriots.png": "85a2b9ccdafe3a0a6edfb9fcdb49e078",
"assets/assets/nfl/bears.png": "30f971c16565166535b4d12b26be7dfe",
"assets/assets/nfl/chargers.png": "8b282af9dfb49aed79a8c78ac6d56695",
"assets/assets/nfl/giants.png": "7d43631a8e12b2edb8e98a1a61879058"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    return self.skipWaiting();
  }
  if (event.message === 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
