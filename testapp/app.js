"use strict";

console.log("I'm starting fresh");

const r = require("rethinkdbdash")({
  servers: [
    {
      host: "rethinkdb1",
      port: 28015
    },
    {
      host: "rethinkdb2",
      port: 28015
    },
    {
      host: "rethinkdb3",
      port: 28015
    },
    {
      host: "rethinkdb4",
      port: 28015
    },
    {
      host: "rethinkdb5",
      port: 28015
    }
  ],
  timeout: 5000
});

const thresh = 12;
let count = 0;

setInterval(() => {
  if (count > thresh) {
    console.info("cluster is running normal, exitting testapp..");

    return process.exit(0);
  }

  r.db("clustertest")
    .table("importantData")
    .then(result => {
      count++;
      console.log("read clustertest.importantData", result);
    })
    .catch(err => {
      console.error(err);
    });
}, 10000);
