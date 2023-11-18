> shinylive::export(appdir = "projects/rc-and-rl-filters/", destdir = "docs/")
Creating docs//
Copying base Shinylive files from /Users/clanker/Library/Caches/shinylive/shinylive-0.2.1/ to docs//
Writing docs/app.json: 1.66K bytes

Run the following in an R session to serve the app:
  library(plumber)
  pr() %>% pr_static("/", "docs/") %>% pr_run()
