import { requireNativeComponent } from 'react-native';
import PropTypes from 'prop-types';
import React from 'react';

class ArucoView extends React.Component {
    render() {
        return <RNTAruco {...this.props} />;
    }
}

ArucoView.propTypes = {

}

var RNTAruco = requireNativeComponent('RNTAruco', ArucoView);

module.exports = ArucoView;
