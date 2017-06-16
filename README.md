## labarchives-cookies

Cookie manager for react native.

### Installation

1. `npm install labarchives-cookies.git`
2. `react-native link labarchives-cookies`

### Usage

```javascript
import CookieManager from 'labarchives-cookies';

// set a cookie
CookieManager.set({
  name: 'myCookie',
  value: 'myValue',
  domain: 'some domain',
  origin: 'some origin',
  path: '/',
  version: '1',
  expiration: '2015-05-30T12:30:00.00-05:00'
}, (err, res) => {
  console.log('cookie set!');
  console.log(err);
  console.log(res);
});

```
