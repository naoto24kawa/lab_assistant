import * as React from 'react';
import {
  BrowserRouter,
  Route,
  Switch,
} from 'react-router-dom';

import TopContainer from '../Top/TopContainer';
import UsersContainer from '../Users/UsersContainer';

import { ApplicationBar } from '../../component/Common';

/**
 * ルーティングコンポーネント
 */
function Component() {
  return (
    <div>
      <ApplicationBar />
      <BrowserRouter>
        <Switch>
          {/* トップページ */}
          <Route exact path="/top" component={TopContainer} />
          {/* ユーザ一覧ページ */}
          <Route exact path="/user" component={UsersContainer} />
          {/* TODO 2018/9/10 watanabe 404ページを作成する */}
          <Route component={() => <h1 style={{ color: '#8e8e8e' }}>404 Not found.</h1>} />
        </Switch>
      </BrowserRouter>
    </div>
  );
}

export default Component;
