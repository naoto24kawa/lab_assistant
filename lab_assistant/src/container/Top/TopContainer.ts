import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import Component from '../../component/Top/Top';
import { actions } from '../../action/top';
import { AppState } from '../../reducer';

const mapStateToProps = (state: AppState) => state.top;

const mapDispatchToProps = dispatch => bindActionCreators(actions, dispatch);

const Container = connect(
  mapStateToProps,
  mapDispatchToProps,
)(Component);

export default Container;
