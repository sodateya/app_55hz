enum RouteConfig {
  login(path: '/login'),
  singUp(path: 'signUp'),
  forgetPassword(path: 'forgetPassword'),
  emailCheckPage(path: 'emailCheckPage'),

  top(path: '/top'),
  talk(path: 'talk'),
  addPost(path: 'addPost'),
  addTalk(path: 'addTalk'),

  myPage(path: 'myPage'),
  favoritePage(path: 'favoritePage'),
  settingPage(path: 'settingPage'),
  editProfilePage(path: 'editProfilePage'),
  blockListPage(path: 'blockListPage'),
  talkToAdminPage(path: 'talkToAdminPage'),
  accountDelete(path: 'accountDelete'),
  searchPage(path: 'searchPage'),
  testPage(path: '/testPage'),

  banPage(path: '/banPage');

  const RouteConfig({required this.path});
  final String path;
}
