module app;

import std.conv;
import std.process;
import vibe.d;

void index(HTTPServerRequest req, HTTPServerResponse res)
{
  res.renderCompat!("index.dt");
}

shared static this()
{
  auto router = new URLRouter;
  router.get("/", &index);

  auto settings = new HTTPServerSettings;
  settings.port = environment.get("PORT", "8080").to!ushort;

  listenHTTP(settings, router);
}
