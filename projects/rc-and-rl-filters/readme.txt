> shinylive::export(appdir = "projects/rc-and-rl-filters/", destdir = "projects/rc-and-rl-filters/docs/")
Creating projects/rc-and-rl-filters/docs//
Copying base Shinylive files from /Users/clanker/Library/Caches/shinylive/shinylive-0.2.1/ to projects/rc-and-rl-filters/docs//
Writing projects/rc-and-rl-filters/docs/app.json: 1.66K bytes

Run the following in an R session to serve the app:
  library(plumber)
  pr() %>% pr_static("/", "projects/rc-and-rl-filters/docs/") %>% pr_run()

> library(plumber)
> pr() %>% pr_static("/", "projects/rc-and-rl-filters/docs/") %>% pr_run()
