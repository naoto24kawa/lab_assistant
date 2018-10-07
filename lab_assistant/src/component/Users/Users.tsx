import * as React from 'react';
import { withRouter } from 'react-router-dom';
import {
  Button,
  Checkbox,
  FormControl,
  FormControlLabel,
  FormGroup,
  FormLabel,
  Grid,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TablePagination,
  TableRow,
  TextField,
  Paper,
} from '@material-ui/core';

import * as moment from 'moment';

import { USER_TYPES } from '../../constant/master';

import { UsersAction } from '../../action/users';
import { UsersState } from '../../reducer/users';

type Props = UsersAction & UsersState;
interface State {};

/**
 * ユーザ一覧画面コンポーネント
 * @extends React.Component
 */
class Component extends React.Component<Props, State> {
  /**
   * Stateをセットする関数を作成
   * @param {string} [key] キーまたはインデックス
   * @return {Function} 関数
   */
  onSetState(key?: string): (e: React.ChangeEvent<HTMLInputElement>) => void {
    return (e: React.ChangeEvent<HTMLInputElement>) => {
      let { type, name, value, checked } = e.target;
      if (type === 'checkbox') {
        this.props.setState({ value: checked, name, key });
      } else {
        this.props.setState({ value, name, key });
      }
    };
  };

  /**
   * 条件を適応する関数を作成
   * @return {Function} 関数
   */
  onApply<T>(): (e: T) => void {
    return (_: T) => {
      this.props.searchUsers();
    };
  };

  /**
   * ページを変更する関数を作成
   * @return {Function} 関数
   */
  onChangePage(): Function {
    return (_, page) => {
      this.props.changePage({ page });
    };
  };

  /**
   * １ページあたりの行数を変更する関数を作成
   * @return {Function} 関数
   */
  onChangeRowsPerPage(): Function {
    return (e) => {
      const rowsPerPage = e.target.value;
      this.props.changeRowsPerPage({ rowsPerPage });
    };
  };

  render() {
    return (
      <div>
        <div>
          <Paper>
            {/* 条件 */}
            <div style={{ margin: 10 }}>
              <Grid container spacing={24}>
                {/* ユーザ名 */}
                <Grid item xs={12}>
                  <TextField
                    name="name"
                    label="ユーザ名"
                    value={this.props.name}
                    onChange={this.onSetState()}
                  />
                </Grid>
                {/* ユーザ種別 */}
                <Grid item xs={12}>
                  <Grid item xs={8}>
                    <FormControl component="fieldset" fullWidth>
                      <FormLabel component="legend">種別</FormLabel>
                      <FormGroup row>
                        {
                          USER_TYPES.map(ut => (
                            <Grid item xs={2} key={ut.id}>
                              <FormControlLabel
                                control={(
                                  <Checkbox
                                    name="userTypes"
                                    checked={this.props.userTypes[ut.id.toString()]}
                                    onChange={this.onSetState(ut.id.toString())}
                                  />
                                )}
                                label={ut.typeName}
                              />
                            </Grid>
                          ))
                        }
                      </FormGroup>
                    </FormControl>
                  </Grid>
                </Grid>
                <Grid item>
                  <Button variant="contained" color="primary" onClick={this.onApply<React.MouseEvent<HTMLElement>>()}>適用</Button>
                </Grid>
              </Grid>
            </div>
            <hr />
            {/* ユーザ一覧 */}
            <Grid container spacing={24}>
              <Grid item xs={1} />
              <Grid item xs={10}>
                <UserTable
                  users={this.props.displayUsers}
                  page={this.props.page}
                  rowsPerPage={this.props.rowsPerPage}
                  onChangePage={this.onChangePage()}
                  onChangeRowsPerPage={this.onChangeRowsPerPage()}
                />
              </Grid>
            </Grid>
          </Paper>
        </div>
      </div>
    );
  }
}
export default withRouter<any>(Component);

/**
 * ユーザ一覧テーブル
 * @param {object} param 引数
 * @param {User[]} param.users ユーザ一覧
 * @param {number} param.page ページ番号
 * @param {number} param.rowsPerPage ページあたりの行数
 * @param {Function} param.onChangePage ページ変更関数
 * @param {Function} param.onChangeRowsPerPage ページあたりの行数変更関数
 * @return {JSX.Element} テーブル
 */
const UserTable = (param: { users, page, rowsPerPage, onChangePage, onChangeRowsPerPage }): JSX.Element => (
  <Paper>
    <TablePagination
      component="div"
      count={param.users.length}
      rowsPerPage={param.rowsPerPage}
      rowsPerPageOptions={[5, 10, 15]}
      page={param.page}
      onChangePage={param.onChangePage}
      onChangeRowsPerPage={param.onChangeRowsPerPage}
    />
    <Table>
      <UserTableHeader />
      <TableBody>
        {
          param.users.slice(param.page * param.rowsPerPage, (param.page + 1) * param.rowsPerPage)
            .map(user => <UserTableRow key={user.id} user={user} />)
        }
      </TableBody>
    </Table>
    <TablePagination
      component="div"
      count={param.users.length}
      rowsPerPage={param.rowsPerPage}
      rowsPerPageOptions={[5, 10, 15]}
      page={param.page}
      onChangePage={param.onChangePage}
      onChangeRowsPerPage={param.onChangeRowsPerPage}
    />
  </Paper>
);

/**
 * ユーザ一覧テーブルのヘッダ
 * @return {JSX.Element} ヘッダ
 */
const UserTableHeader = (): JSX.Element => (
  <TableHead>
    <TableRow>
      <TableCell>名前</TableCell>
      <TableCell padding="none">種別</TableCell>
      <TableCell padding="none">性別</TableCell>
      <TableCell padding="none">年齢</TableCell>
      <TableCell padding="none">生年月日</TableCell>
      <TableCell padding="none">電話番号</TableCell>
      <TableCell padding="none">メールアドレス</TableCell>
    </TableRow>
  </TableHead>
);

/**
 * ユーザ一覧テーブルの1つの行
 * @param {User} user ユーザ情報
 * @return {JSX.Element} 行
 */
const UserTableRow = ({ user }: any): JSX.Element => (
  <TableRow
    hover
    onClick={() => console.warn('TODO ユーザ管理画面に飛ばす', user)}
  >

    <TableCell component="th" scope="row">
      <div>
        <ruby>
          <span>{user.fullName}</span>
          <rt>{user.fullNameKana}</rt>
        </ruby>
      </div>
    </TableCell>
    <TableCell padding="none">
      {user.userTypes.map(t => t.typeName).join(',　')}
    </TableCell>
    <TableCell padding="none">
      {user.gender.name}
    </TableCell>
    <TableCell padding="none">
      {user.age}
    </TableCell>
    <TableCell padding="none">
      {moment(user.birthDate).format('YYYY月M月D日')}
    </TableCell>
    <TableCell padding="none">
      {user.phoneNumber}
    </TableCell>
    <TableCell padding="none">
      {user.mailAddress}
    </TableCell>
  </TableRow>
);
