import React, {Component} from 'react';
import {Platform, View, NativeModules, Dimensions, Text} from 'react-native';
import { Container } from 'native-base';
import ArucoIOS from './ArucoView';

export default class App extends Component {

componentWillMount(){
  // Aruco.emitter.addListener('CAMERA_FRAME_EVENT', ({markers})=>{
  //   this.setState(()=>({markerList: markers}))
  // });
  // ArucoModule.setRNScreenDimensions(
  //   Dimensions.get("window").width,
  //   Dimensions.get("window").height
  // );
}

  render() {
    return (
      <Container>
        <ArucoIOS 
          style={{flex: 1}} 
          onArucoDetect={ (result) => {
            
          }}
        />
      </Container>
    );
  }
  

  identifyMarkers = function(){
    return this.state.markerList.map(marker=>{
      return(
          // <View style={this.positionStyle(marker)}>
            <Text style={this.positionStyle(marker)}>
              {"[" + marker.rnx + ", " + marker.rny + "]"} 
            </Text>
          // </View>
      )
    })
  }

  positionStyle = function(marker){
    return {
      position: 'absolute',
      top: marker.rny,
      left: marker.rnx,
      alignItems: 'center',
    }
  }
}

