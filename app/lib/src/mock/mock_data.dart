import 'dart:math' as math;

import '../models.dart';

/// モックユーザーは「anchor（中心点）からの相対距離」で配置する。
/// anchor には実 GPS で取得した現在地が入り、どこにいても近くのゲーとも候補が並ぶ。
class _MockSpec {
  final String id;
  final String nickname;
  final String decade;
  final String gender;
  final String iconCategoryId;
  final List<String> interestIds;
  final String bio;
  final double northKm; // anchor からの北方向距離
  final double eastKm; // anchor からの東方向距離

  const _MockSpec(this.id, this.nickname, this.decade, this.gender,
      this.iconCategoryId, this.interestIds, this.bio, this.northKm,
      this.eastKm);
}

const List<_MockSpec> _specs = [
  _MockSpec(
    'u-riichi-ken',
    'FPSのけん',
    '30代',
    'male',
    'shooter',
    ['shooter', 'action', 'strategy'],
    'FPS歴5年。エイム練習とランク戦が日課です。一緒に遊ぶ仲間を探しています。',
    0.6,
    0.2,
  ),
  _MockSpec(
    'u-sanma-akira',
    'RPGのあきら',
    '40代',
    'male',
    'rpg',
    ['rpg', 'retro', 'strategy'],
    'RPGの歴史20年。ストーリー考察が好きです。一緒にじっくりすすめたいです。',
    -0.3,
    -0.1,
  ),
  _MockSpec(
    'u-beginner-nana',
    'ゆるゲーマーのなな',
    '20代',
    'female',
    'beginner',
    ['beginner', 'music', 'gamekai'],
    '休日にゆるくプレイしています。教えてくださる方を探しています。',
    0.15,
    -0.4,
  ),
  _MockSpec(
    'u-east-sora',
    'アクションのそら',
    '20代',
    'undisclosed',
    'action',
    ['action', 'fight', 'netgame'],
    'アクションと格闘を中心にプレイ。コツコツ腕を磨いています。',
    -0.7,
    0.5,
  ),
  _MockSpec(
    'u-tonpu-miu',
    '格闘のみう',
    '20代',
    'female',
    'fight',
    ['fight', 'esports', 'shooter'],
    '格闘オンラインでよく遊びます。まさかの逆転が好きです。',
    1.2,
    -0.9,
  ),
  _MockSpec(
    'u-league-kei',
    'eスポーツ観戦のけい',
    '30代',
    'undisclosed',
    'esports',
    ['esports', 'shooter', 'netgame'],
    'eスポーツを全試合観戦しています。選手の動きを研究するのが好きです。',
    -1.1,
    1.0,
  ),
  _MockSpec(
    'u-goods-hina',
    'グッズ集めのひな',
    '30代',
    'female',
    'goods',
    ['goods', 'retro', 'gamekai'],
    'フィギュアやサントラなどのグッズを集めています。情報交換歓迎です。',
    0.9,
    0.35,
  ),
  _MockSpec(
    'u-rule-kyo',
    'レトロゲームのきょう',
    '40代',
    'male',
    'retro',
    ['retro', 'rpg', 'gamekai'],
    '往年の名作が好きです。一緒に語れる相手を探しています。うちのサークルの顔役です。',
    0.45,
    -1.3,
  ),
];

class _BusinessSpec {
  final String id;
  final String nickname;
  final String iconCategoryId;
  final String storeType;
  final String bio;
  final double northKm;
  final double eastKm;

  const _BusinessSpec(this.id, this.nickname, this.iconCategoryId,
      this.storeType, this.bio, this.northKm, this.eastKm);
}

const List<_BusinessSpec> _businessSpecs = [
  _BusinessSpec(
    'b-jansou-sakura',
    'ゲームセンター 桜荘',
    'arcade',
    'ゲームセンター',
    '対戦台と最新タイトルを多数設置。初心者歓迎のゲーム教室もやっています。',
    0.8,
    0.9,
  ),
  _BusinessSpec(
    'b-game-shop-note',
    'ゲームショップ ノート',
    'beginner',
    'ゲームショップ・ホビー店',
    '新品・中古ソフトの販売と買取。おすすめタイトルの相談も受けます。',
    -0.5,
    1.1,
  ),
  _BusinessSpec(
    'b-goods-pinsoro',
    'ゲームグッズの店 ぴんそろ',
    'goods',
    'カードゲーム・ボードゲーム店',
    'トレカ・ボドゲ・周辺グッズの販売。シングルの買取りもやっています。',
    1.5,
    -0.6,
  ),
  _BusinessSpec(
    'b-arcade-marunouchi',
    'ゲームカフェ 丸の内',
    'netgame',
    'ゲームカフェ運営',
    'ドリンクを飲みながらまったり対戦できます。初心者の練習にも最適です。',
    -1.4,
    -0.8,
  ),
];

const double _kmPerDegLat = 111.32;

AppUser _specToUser(_MockSpec s, double anchorLat, double anchorLng) {
  final cos =
      math.cos(anchorLat * math.pi / 180.0).abs().clamp(0.01, 1.0);
  return AppUser(
    id: s.id,
    nickname: s.nickname,
    decade: s.decade,
    gender: s.gender,
    iconCategoryId: s.iconCategoryId,
    interestIds: s.interestIds,
    bio: s.bio,
    lat: anchorLat + s.northKm / _kmPerDegLat,
    lng: anchorLng + s.eastKm / (_kmPerDegLat * cos),
  );
}

BusinessUser _specToBusiness(
    _BusinessSpec s, double anchorLat, double anchorLng) {
  final cos =
      math.cos(anchorLat * math.pi / 180.0).abs().clamp(0.01, 1.0);
  return BusinessUser(
    id: s.id,
    nickname: s.nickname,
    decade: '経営者',
    gender: 'undisclosed',
    iconCategoryId: s.iconCategoryId,
    interestIds: const [],
    bio: s.bio,
    lat: anchorLat + s.northKm / _kmPerDegLat,
    lng: anchorLng + s.eastKm / (_kmPerDegLat * cos),
    storeType: s.storeType,
  );
}

/// 現在地を中心にモックユーザー（一般 + ビジネス）を配置する。
List<AppUser> buildMockUsers(double anchorLat, double anchorLng) {
  return [
    for (final s in _specs) _specToUser(s, anchorLat, anchorLng),
    for (final s in _businessSpecs) _specToBusiness(s, anchorLat, anchorLng),
  ];
}

/// シード募集（起動時刻からの残り時間で作るので、いつ開いても「今から」感が出る）。
/// host は generalUsers（モック一般ユーザー）から id で引く。
List<Recruitment> seedRecruitments(DateTime now, List<AppUser> generalUsers) {
  Recruitment make({
    required String hostId,
    required String genreId,
    required String title,
    required String body,
    required String meetup,
    required int capacity,
    required int minutesLeft,
  }) {
    return Recruitment(
      id: 'r-$hostId',
      hostId: hostId,
      genreId: genreId,
      title: title,
      body: body,
      meetup: meetup,
      capacity: capacity,
      createdAt: now.subtract(const Duration(minutes: 15)),
      expiresAt: now.add(Duration(minutes: minutesLeft)),
      memberIds: [hostId],
    );
  }

  return [
    make(
      hostId: 'u-riichi-ken',
      genreId: 'game',
      title: '今夜、ゲームセンターで一戦しませんか',
      body: '対戦台を予約しました。あと1人を探しています。初心者も歓迎です。',
      meetup: 'ゲームセンター 桜荘 2F 受付',
      capacity: 4,
      minutesLeft: 105,
    ),
    make(
      hostId: 'u-sanma-akira',
      genreId: 'game',
      title: 'RPGを一緒にすすめませんか',
      body: '新作RPGを相談しながらゆっくりすすめます。ネタバレには気をつけます。',
      meetup: 'ゲームセンター 丸の内 フリースペース',
      capacity: 3,
      minutesLeft: 70,
    ),
    make(
      hostId: 'u-league-kei',
      genreId: 'event',
      title: '今週のeスポーツ観戦会',
      body: '大画面で観戦しながら戦術談義も。初心者も大歓迎です。',
      meetup: 'ゲームセンター 桜荘 1F バー',
      capacity: 4,
      minutesLeft: 160,
    ),
    make(
      hostId: 'u-beginner-nana',
      genreId: 'event',
      title: '初心者の見学会をやります',
      body: '基本操作から攻略の入り口まで見せ合う会です。楽しくゆるくやりましょう。',
      meetup: 'ゲームショップ ノート 入口',
      capacity: 4,
      minutesLeft: 95,
    ),
    make(
      hostId: 'u-east-sora',
      genreId: 'talk',
      title: 'ネット対戦プレーヤーのオフ会',
      body: 'いつもボイチャで遊んでいる仲間とのオフ会です。オフラインでも遊びます。',
      meetup: 'カフェ（ゲームグッズの店 ぴんそろ となり）',
      capacity: 4,
      minutesLeft: 130,
    ),
    make(
      hostId: 'u-goods-hina',
      genreId: 'talk',
      title: 'グッズ自慢のオフ会、参加者募集',
      body: 'お気に入りのソフトやコレクションを見せ合う会です。',
      meetup: 'ゲームセンター 桜荘 1F ロビー',
      capacity: 3,
      minutesLeft: 45,
    ),
  ];
}

/// 近況報告のシード。anchor（現在地）からの相対距離で配置する。
/// id が 'cx-seed-' 始まりのものは GPS 更新のたびに再配置される
/// （AppState.applyGps を参照）。
class _ExchangeSeedSpec {
  final String id;
  final String posterId;
  final String kind;
  final String itemDescription;
  final String areaName;
  final String detail;
  final double northKm;
  final double eastKm;
  final Duration age;
  const _ExchangeSeedSpec(this.id, this.posterId, this.kind,
      this.itemDescription, this.areaName, this.detail, this.northKm,
      this.eastKm, this.age);
}

const List<_ExchangeSeedSpec> _exchangeSeedSpecs = [
  _ExchangeSeedSpec(
    'cx-seed-1',
    'u-goods-hina',
    'shoot',
    '新作のゲームセンターで対戦風景を撮影しました',
    'ゲームセンター 桜荘 周辺',
    '新作の格闘の練習をしていました。'
        '一緒に練習できる仲間を募集しています。',
    0.3,
    -0.6,
    Duration(hours: 2),
  ),
  _ExchangeSeedSpec(
    'cx-seed-2',
    'u-beginner-nana',
    'post',
    'シーズンのランク戦が始まりました',
    '駅前広場 周辺',
    '今シーズンは新しいロールに挑戦しています。'
        '同じ作品を遊ぶ方と情報交換したいです。',
    -0.2,
    0.8,
    Duration(hours: 5),
  ),
  _ExchangeSeedSpec(
    'cx-seed-3',
    'u-tonpu-miu',
    'event',
    'カードゲームの店内大会に参加してきました',
    '市役所裏の公園 周辺',
    '初参加でしたが気持ちよく遊べて楽しかったです。'
        '常連さんにルールも教えてもらえました。',
    -0.9,
    -0.3,
    Duration(hours: 26),
  ),
];

List<GameReport> buildSeedGameReports(
    DateTime now, double anchorLat, double anchorLng) {
  final cos = (anchorLat * math.pi / 180.0).abs().clamp(0.01, 1.0);
  return [
    for (final s in _exchangeSeedSpecs)
      GameReport(
        id: s.id,
        posterId: s.posterId,
        kind: s.kind,
        itemDescription: s.itemDescription,
        areaName: s.areaName,
        detail: s.detail,
        lat: anchorLat + s.northKm / _kmPerDegLat,
        lng: anchorLng + s.eastKm / (_kmPerDegLat * cos),
        createdAt: now.subtract(s.age),
      ),
  ];
}

/// モックの返信候補（デモの自動応答に使う。本開発では Supabase Realtime に置換）
const List<String> mockReplies = [
  'よろしくお願いします！',
  '次のセッション、楽しみですね。',
  '先に着いて席を確保しておきますね。',
  '初心者も大歓迎です。気軽にどうぞ。',
];

/// モックの応募メッセージ
const List<String> mockApplyMessages = [
  '参加したいです！ゲーム仲間を探していました。',
  '同じプラットフォームでよく遊んでいます。',
  'この近くのゲームセンターによく通っています。',
];
