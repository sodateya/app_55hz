const admin = require('firebase-admin');
const functions = require('firebase-functions');
const algoliasearch = require('algoliasearch');

admin.initializeApp();

const client = algoliasearch('YUUAZI2TQ1', '90e9284829a4a54ca3abfb3aa02fe80b');
const index = client.initIndex('9ch_posts');
const adminToken = 'cPZoEIvZ1k9Gui-tKX4Fjv:APA91bHbVaAEUvpegXdNL5b8ibX0ssTViQcUpLbONqn5Kwdftwquc9Pm1bYegcn13xeQG9jd8jBfJuMuMi-cMlQKjIp9xSuuRC1fYaI86qJzYoVogmYHs8pxMRoX5OnaFzFlK_9SuRAU';


exports.addToIndex = functions.firestore.document('thread/{threadId}/post/{postId}')
  .onCreate((snapshot, context) => {
    const data = snapshot.data();
    const objectID = snapshot.id;
    const threadId = context.params.threadId;
    const postId = context.params.postId;
    return index.saveObject({ ...data, objectID, threadId, postId });
  });

exports.deleteFromIndex = functions.firestore.document('thread/{threadId}/post/{postId}')
  .onDelete(snapshot => {
    const objectID = snapshot.id;
    return index.deleteObject(objectID);
  });

exports.puehToAdmin = functions.firestore.document('inquiry/{inquiryID}')
  .onCreate((snapshot) => {
    const payload = {
      notification: {
        title: "9ちゃんねる",
        body: snapshot.data()['comment'],
        badge: "1",
        sound: "default"
      }
    };
    pushToDevice(adminToken, payload)
  });






//  アプリから「CloudFunctions」呼び出し
exports.pushSubmitFromApp = functions.region('asia-northeast1').https.onCall(async (_request, _response) => {
  const id = _request.id;  // dataに格納されている引数を受け取る
  const token = _request.token
  const payload = {
    notification: {
      title: "9ちゃんねる",
      body: id,
      badge: "1",             //バッジ数  
      sound: "default"         //プッシュ通知音
    }
  };
  pushToDevice(token, payload);
});




//  FCM部分
function pushToDevice(token, payload) {
  // priorityをhighにしとくと通知までが早くなります
  const options = {
    priority: "high",
  };

  admin.messaging().sendToDevice(token, payload, options)
    .then(_pushResponse => {
      return { text: token };
    })
    .catch(error => {
      throw new functions.https.HttpsError('unknown', error.message, error);
    });
}



exports.addDeleteLog = functions.firestore.document('thread/{ThreadID}/post/{postID}/talk/{talkID}')
  .onDelete((snapshot, context) => {
    // 新しく作成されたデータを取得
    const newData = snapshot.data();

    // context.paramsからThreadIDとPostIDを取得
    const ThreadID = context.params.ThreadID;
    const PostID = context.params.postID;

    // newDataにThreadIDとPostIDを追加
    newData.ThreadID = ThreadID;
    newData.PostID = PostID;

    // newDataをKanshiコレクションに追加
    return admin.firestore().collection('DeleteLog').add(newData)
      .then(() => {
        console.log('できた');
        return null;
      })
      .catch((error) => {
        console.error('エラー', error);
        return null;
      });
  });

exports.addTreadDeleteLog = functions.firestore.document('thread/{ThreadID}/post/{postID}')
  .onDelete((snapshot, context) => {
    // 新しく作成されたデータを取得
    const newData = snapshot.data();

    // context.paramsからThreadIDとPostIDを取得
    const ThreadID = context.params.ThreadID;
    const PostID = context.params.postID;

    // newDataにThreadIDとPostIDを追加
    newData.ThreadID = ThreadID;
    newData.PostID = PostID;

    // newDataをKanshiコレクションに追加
    return admin.firestore().collection('TreadDeleteLog').add(newData)
      .then(() => {
        console.log('できた');
        return null;
      })
      .catch((error) => {
        console.error('エラー', error);
        return null;
      });
  });


