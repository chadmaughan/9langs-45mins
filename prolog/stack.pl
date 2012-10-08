

db(markLogic, 50).
db(redis, 10).
db(mongo, 3).
db(voltdb, 3).
db(couchdb, 20).

lang(erlang, 9).
lang(go, 7).
lang(haskell, 12).
lang(prolog, 33).
lang(java, 19).
lang(javascript, 11).

hasDrivers(couchdb, Lang) :- lang(Lang, _).
hasDrivers(couchdb, Lang) :- lang(Lang, _).
hasDrivers(Db, java) :- db(Db, _).
hasDrivers(mongo, java) :- db(Db, _).
hasDrivers(mongo, javascript) :- db(Db, _).

stack(Lang, DB, Score) :- lang(Lang, NLang), db(DB, NDB), Score is (NLang * NDB).
