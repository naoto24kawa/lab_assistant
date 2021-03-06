import * as React from 'react';
import { withRouter } from 'react-router-dom';

import { TopAction } from '../../action/top';
import { TopState } from '../../reducer/top';

type Props = TopAction & TopState;
interface State {
  timer: any;
}

/**
 * トップ画面コンポーネント
 * @extends React.Component
 */
class Component extends React.Component<Props, State> {
  constructor(props: Props, context: any) {
    super(props, context);
    this.state = {
      timer: null,
    };
  }

  componentDidMount() {
    // 1秒ごとに時間を更新
    this.setState({
      ...this.state,
      timer: setInterval(this.props.syncDate, 1000),
    });
  }

  componentWillUnmount() {
    clearInterval(this.state.timer);
  }

  render() {
    return (
      <div>
        <h1>Lab Assistant</h1>
        <br />
        {this.props.time.toString()}
      </div>
    );
  }
}

export default withRouter<any>(Component);
