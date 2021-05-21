# Requests

## Usage

### Making a Request

```swift

import Requests

Requests.request("https://httpbin.org/get").build()
Requests.request("https://httpbin.org/get").query(["foo": "bar"]).build()
Requests.request("https://httpbin.org/get").headers(["Custom-Content-Type": "application/json; encrypted=1"]).build()
Requests.request("https://httpbin.org/post").post(["foo": "bar"]).encoding(.url).build()
Requests.request("https://httpbin.org/post").post(["foo": "bar"]).encoding(.json).retry(1).build()
Requests.request("https://httpbin.org/post").post(["foo": "bar"]).encoding(.json).priority(Network.Priority.Low).build()

// Please take a look at Request.swift for more configuration 

```

### Response Handling

```swift

Requests.request("https://httpbin.org/get").build()?.responseJSON { request, response, responseValue, error in 

}

let (response, responseData, error) = Requests.request("https://httpbin.org/post").query(["foo": "bar"]).post(["encode": "json"]).encoding(.JSON).syncResponseJSON()

```
## Requirements

## Installation

Network is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Requests', :git => 'https://github.com/lovesunstar/Requests.git'
```

## Author

Suen, lovesunstar@sina.com

## License

Requests is available under the MIT license. See the LICENSE file for more info.

