# Heroku buildpack for [vibe.d](http://vibed.org/)

Based mostly on https://bitbucket.org/mikehouston/heroku-buildpack-d/.

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
$ heroku apps:create -s cedar --buildpack https://github.com/skirino/heroku-buildpack-vibe.d.git
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

-----> Building libevent
...

-----> Building libev
...

-----> Downloading DMD
...

-----> Downloading dub package manager
...

-----> Setting PATH:
...

-----> Initializing toolchain

-----> Building app

       Running dub build
Checking dependencies in '/tmp/build_daa1a32d-c53a-47e0-8811-1a077358079b'
The following changes will be performed:
Install vibe-d >=0.7.17, userWide
Install libevent ~master, userWide
Install openssl ~master, userWide
Install libev ~master, userWide
Downloading vibe-d 0.7.18-beta.1...
Installing vibe-d 0.7.18-beta.1...
vibe-d has been installed with version 0.7.18-beta.1
Downloading libevent ~master...
Installing libevent ~master...
libevent has been installed with version ~master
Downloading openssl ~master...
Installing openssl ~master...
openssl has been installed with version ~master
Downloading libev ~master...
Installing libev ~master...
libev has been installed with version ~master
Building configuration "application", build type release
Running dmd (compile)...
Compiling diet template 'index.dt' (compat)...
Linking...

       Build was successful
-----> Discovering process types
       Procfile declares types -> web

-----> Compiled slug size: 3.5MB
-----> Launching... done, v4
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

- Add the following to `dub.json` in order to specify path to manually-installed libraries:
  - `"lflags": ["-L/app/opt/lib"]`
- Create `Procfile` whose content looks something like the following:
  - `web: LD_LIBRARY_PATH=/app/opt/lib ./vibed-heroku-example`
- Modify to listen to port given by Heroku as environment variable:
  - `settings.port = environment.get("PORT", "8080").to!ushort;`

# Acknowledgment

- @dkhasel fixed a problem due to outdated dub version. Thanks!
