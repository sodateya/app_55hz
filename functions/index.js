const admin = require('firebase-admin');
const functions = require('firebase-functions');
const algoliasearch = require('algoliasearch');

admin.initializeApp();

const client = algoliasearch('YUUAZI2TQ1', '90e9284829a4a54ca3abfb3aa02fe80b');
const index = client.initIndex('9ch_posts');



exports.addToIndex = functions.firestore.document('thread/{threadId}/post/{postId}')
    .onCreate((snapshot, context) => {
        const data = snapshot.data();
        const objectID = snapshot.id;
        const threadId = context.params.threadId; // ワイルドカードを使ってthreadIdを取得
        const postId = context.params.postId; // ワイルドカードを使ってpostIdを取得
        return index.saveObject({ ...data, objectID, threadId, postId });
    });

    exports.deleteFromIndex = functions.firestore.document('thread/{threadId}/post/{postId}')
    .onDelete(snapshot => {
        const objectID = snapshot.id;
        return index.deleteObject(objectID);
    });
// exports.updateIndex = functions.firestore.document('thread/{threadId}/post/{postId}')
//     .onUpdate((change, context) => {
//         const newData = change.after.data();
//         const objectID = change.after.id;
//         const threadId = context.params.threadId; // ワイルドカードを使ってthreadIdを取得
//         const postId = context.params.postId; // ワイルドカードを使ってpostIdを取得
//         return index.saveObject({ ...newData, objectID, threadId, postId });
//     });


functions.pubsub.schedule()
//  URLから「CloudFunctions」呼び出し
exports.pushSubmitFromURL = functions.https.onRequest(async(_request, _response) => {
const token = _request.query.token;
const body = _request.query.body;
  const payload = {
          notification: {
            title: '9ちゃんねる',
            body: body,
            badge: "1",             //バッジ数  
            sound:"default"         //プッシュ通知音
          }
        };

  pushToDevice(token,payload);

});

//  アプリから「CloudFunctions」呼び出し
exports.pushSubmitFromApp = functions.region('asia-northeast1').https.onCall(async(_request, _response) => {
  const id = _request.id;  // dataに格納されている引数を受け取る
  const token = _request.token
  const payload = {
          notification: {
            title: "9ちゃんねる",
            body: id,
            badge: "1",             //バッジ数  
            sound:"default"         //プッシュ通知音
          }
        };

  pushToDevice(token,payload);

});


exports.pushTime = functions.region('asia-northeast1').https.onCall(async(_request, _response) => {
  const id = _request.id;  // dataに格納されている引数を受け取る
  const token = _request.token
  const payload = {
          notification: {
            title: "9ちゃんねる",
            body: id,
            badge: "1",             //バッジ数  
            sound:"default"         //プッシュ通知音
          }
        };
  pushTotime(token,payload);
});


//  FCM部分
function pushToDevice(token, payload){
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

function pushTotime(token, payload){
  const options = {
    priority: "high",
  };

  admin.messaging().schedule('25 13 28 10*').timeZone('Asia/Tokyo').sendToDevice(token, payload, options)
  .then(_pushResponse => {
    return { text: token };
  })
  .catch(error => {
    throw new functions.https.HttpsError('unknown', error.message, error);
  });
}





// function timePush(token,paylode){functions.pubsub.schedule('10 12 28 10*')
// .timeZone('Asia/Tokyo') 
// .onRun(async(_context) => {
// pushToDevice(token,paylode)
// });
// }




// exports.addNumbers = functions.https.onCall((data) => {

//     const firstNumber = data.firstNumber;
//     const secondNumber = data.secondNumber;
  
//     if (!Number.isFinite(firstNumber) || !Number.isFinite(secondNumber)) {
//       throw new functions.https.HttpsError('invalid-argument', 'The function must be called with ' +
//           'two arguments "firstNumber" and "secondNumber" which must both be numbers.');
//     }
   
//     return {
//       firstNumber: firstNumber,
//       secondNumber: secondNumber,
//       operator: '+',
//       operationResult: firstNumber + secondNumber,
//     };
//   });
 
//   exports.addMessage = functions.https.onCall((data, context) => {
    
//     const text = data.text;
   
//     if (!(typeof text === 'string') || text.length === 0) {
//       throw new functions.https.HttpsError('invalid-argument', 'The function must be called with ' +
//           'one arguments "text" containing the message text to add.');
//     }
//     if (!context.auth) {
//       throw new functions.https.HttpsError('failed-precondition', 'The function must be called ' +
//           'while authenticated.');
//     }
  
//     const uid = context.auth.uid;
//     const name = context.auth.token.name || null;
//     const picture = context.auth.token.picture || null;
//     const email = context.auth.token.email || null;
  
//     const sanitizedMessage = sanitizer.sanitizeText(text); 
//     return admin.database().ref('/messages').push({
//       text: sanitizedMessage,
//       author: { uid, name, picture, email },
//     }).then(() => {
//       console.log('New Message written');
//       return { text: sanitizedMessage };
//     })
//       .catch((error) => {
//         throw new functions.https.HttpsError('unknown', error.message, error);
//       });
//   });
