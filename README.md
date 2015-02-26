# Heroku buildpack for [vibe.d](http://vibed.org/)

# Note on heroku stacks

- [`master`](https://github.com/skirino/heroku-buildpack-vibe.d/tree/master) and [`cedar-14`](https://github.com/skirino/heroku-buildpack-vibe.d/tree/cedar-14) branches target classical cedar stack and newer cedar-14 stack, respectively.
  - See [here](https://devcenter.heroku.com/articles/cedar) for details about heroku stacks.
- You can specify buildpack's branch name by the fragment part of your `BUILDPACK_URL`, e.g. `https://github.com/skirino/heroku-buildpack-vibe.d.git#cedar-14`.

# Example usage

```
# Prepare local vibe.d project (See the next section for more detail)
$ cd heroku-buildpack-vibe.d
$ cp -r example ~/
$ cd ~/example
$ git init
Initialized empty Git repository in /home/skirino/example/.git/
$ git add .
$ git commit -m "Initial commit"
...

# Create a new heroku app
$ heroku apps:create -s cedar-14 --buildpack 'https://github.com/skirino/heroku-buildpack-vibe.d.git#cedar-14'
Creating peaceful-shore-2762... done, region is us
BUILDPACK_URL=https://github.com/skirino/heroku-buildpack-vibe.d.git
http://peaceful-shore-2762.herokuapp.com/ | git@heroku.com:peaceful-shore-2762.git
Git remote heroku added

# Git push (this may take a little time for the first time)
$ git push heroku master:master
Counting objects: 9, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (9/9), 997 bytes, done.
Total 9 (delta 0), reused 0 (delta 0)

-----> Fetching custom git buildpack... done
-----> D (dub package manager) app detected

-----> Config:
       DMD_ARCHIVE_URL=http://downloads.dlang.org/releases/2014/dmd.2.066.1.zip
       DUB_ARCHIVE_URL=http://code.dlang.org/files/dub-0.9.22-linux-x86_64.tar.gz

-----> Downloading dmd from http://downloads.dlang.org/releases/2014/dmd.2.066.1.zip...

-----> Extracting /app/tmp/cache/dmd.2.066.1.zip...

-----> Downloading dub from http://code.dlang.org/files/dub-0.9.22-linux-x86_64.tar.gz...

-----> Extracting /app/tmp/cache/dub-0.9.22-linux-x86_64.tar.gz...

-----> Building app...
Warning: -version=VibeDefaultMain will be required in the future to use vibe.d's default main(). Please update your build scripts.
Warning: -version=VibeDefaultMain will be required in the future to use vibe.d's default main(). Please update your build scripts.
Compiling diet template 'index.dt' (compat)...
       Fetching vibe-d 0.7.22 (getting selected version)...
Placing vibe-d 0.7.22 to /app/.dub/packages/...
Fetching libevent 2.0.1+2.0.16 (getting selected version)...
Placing libevent 2.0.1+2.0.16 to /app/.dub/packages/...
Fetching openssl 1.1.3+1.0.1g (getting selected version)...
Placing openssl 1.1.3+1.0.1g to /app/.dub/packages/...
Fetching libev 4.0.0+4.04 (getting selected version)...
Placing libev 4.0.0+4.04 to /app/.dub/packages/...
Fetching libasync 0.6.5 (getting selected version)...
Placing libasync 0.6.5 to /app/.dub/packages/...
Building vibe-d 0.7.22 configuration "libevent", build type release.
Running dmd...
Building vibed-heroku-example ~master configuration "application", build type release.
Compiling using dmd...
Linking...
-----> Discovering process types
       Procfile declares types -> web

-----> Compressing... done, 1.7MB
-----> Launching... done, v3
       http://peaceful-shore-2762.herokuapp.com deployed to Heroku

To git@heroku.com:peaceful-shore-2762.git
 * [new branch]      master -> master

# Send request to the running app
$ curl http://peaceful-shore-2762.herokuapp.com/

<!DOCTYPE html>
<html>
	<head>
		<title>vibe.d heroku buildpack example</title>
	</head>
	<body>
		<h1>vibe.d running on Heroku!</h1>
	</body>
</html>
```

# Required settings of vibe.d project

- Create `Procfile` whose content looks something like the following:
  - `web: ./vibed-heroku-example`
- Listen to the port given by Heroku as an environment variable:
  - `settings.port = environment.get("PORT", "8080").to!ushort;`
- Create your own `vibed_buildpack.config` file to specify dmd and dub versions.
  - If not given, defaults to [config file inside the buildpack](https://github.com/skirino/heroku-buildpack-vibe.d/blob/cedar-14/vibed_buildpack.config).

# Acknowledgment

- Based on https://bitbucket.org/mikehouston/heroku-buildpack-d/.
- @dkhasel fixed a problem due to outdated dub version.
