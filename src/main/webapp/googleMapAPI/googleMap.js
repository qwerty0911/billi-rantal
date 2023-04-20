  /**
       * @license
       * Copyright 2019 Google LLC. All Rights Reserved.
       * SPDX-License-Identifier: Apache-2.0
       */
      let map;
      let marker;
      let geocoder;
      let responseDiv;
      let response;

      function initMap() {
        map = new google.maps.Map(document.getElementById("map"), {
          zoom: 17,
          center: { lat: 37.557527, lng: 126.9244669 },
          mapTypeControl: false,
        });
        
        /* input 태그에 위도 경도 삽입하는 리스너 */
        var myInputLat = document.getElementById("myInputLat");
        var myInputLng = document.getElementById("myInputLng");
        
        map.addListener('click', function(event) {
    	    // 클릭한 위치의 위도와 경도 추출
    	    var latitude = event.latLng.lat();
    	    var longitude = event.latLng.lng();
    	    myInputLat.value = latitude;
    	    myInputLng.value = longitude;
    	    console.log("위도: " + latitude + ", 경도: " + longitude);
    	  });
        
        geocoder = new google.maps.Geocoder();

        const inputText = document.createElement("input");

        inputText.type = "text";
        inputText.placeholder = "Enter a location";

        const submitButton = document.createElement("input");

        submitButton.type = "button";
        submitButton.value = "Geocode";
        submitButton.classList.add("button", "button-primary");

        const clearButton = document.createElement("input");

        clearButton.type = "button";
        clearButton.value = "Clear";
        clearButton.classList.add("button", "button-secondary");
        response = document.createElement("pre");
        response.id = "response";
        response.innerText = "";
        responseDiv = document.createElement("div");
        responseDiv.id = "response-container";
        responseDiv.appendChild(response);

        const instructionsElement = document.createElement("p");

        instructionsElement.id = "instructions";
        instructionsElement.innerHTML =
          "<strong>안내</strong>: 주소를 입력하고 확인버튼을 눌러주세요.";
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(inputText);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(submitButton);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(clearButton);
        map.controls[google.maps.ControlPosition.LEFT_TOP].push(
          instructionsElement
        );
        map.controls[google.maps.ControlPosition.LEFT_TOP].push(responseDiv);
        marker = new google.maps.Marker({
          map,
        });
        map.addListener("click", (e) => {
          geocode({ location: e.latLng });
        });
        submitButton.addEventListener("click", () =>
          geocode({ address: inputText.value })
        );
        clearButton.addEventListener("click", () => {
          clear();
        });
        clear();
      }
      
      function printLongLat(result){
    	  console.log(result)
    	  
      }

      function clear() {
        marker.setMap(null);
      }
      
     

      function geocode(request) {
        clear();
        geocoder
          .geocode(request)
          .then((result) => {
            const { results } = result;

            map.setCenter(results[0].geometry.location);
            marker.setPosition(results[0].geometry.location);
            marker.setMap(map);
            response.innerText = JSON.stringify(result, null, 2);
            return results;
          })
          .catch((e) => {
            alert("Geocode was not successful for the following reason: " + e);
          });
      }
      
      

      window.initMap = initMap;