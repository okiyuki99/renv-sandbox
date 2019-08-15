# renv-sandbox
playground for renv 

## What is `renv` ?
RStudio社が開発中のpackratに変わるパッケージ管理パッケージである

## インストール

```R
devtools::install_github("rstudio/renv")
```

## Github
* https://rstudio.github.io/renv/

## 使い方

### ```renv::init()``` 

```R
> renv::init()
* Discovering package dependencies ... Done!
* Copying packages into the cache ... [300/300] Done!
* Resolving missing dependencies  ... 
* Querying repositories for available source packages ... Done!
Retrieving 'https://cloud.r-project.org/src/contrib/fclust_2.1.tar.gz' ...
	OK [downloaded 86.2 Kb in 0.8 secs]
<snip>
```

### ```renv::status()```

```R
> renv::status()
* The project is already synchronized with the lockfile.
```

### ```renv::snapshot()```

```R
> renv::snapshot()
The lockfile will be written to '~/resq/renv.lock'.
Do you want to proceed? [y/N]: y
* Lockfile written to '~/resq/renv.lock'.
```

### ```renv::restore()```

```R
> renv::restore(lockfile = '/tmp/renv.lock')
```

rocker/shinyのDockerfileでrenv::restore()でpackageインストールさせたろと思ったらエラー出たりするので、なんか素直にはいかない。。

### ```renv::dependencies()```

プロジェクトにあるソースとパッケージの読み込み関係を出力

```R
> renv:::dependencies()
Finding R package dependencies ... Done!
                                          Source       Package Require Version
1                    /home/ooki/ShinyAB/deploy.R     rsconnect                
2                    /home/ooki/ShinyAB/global.R        pacman                
3                 /home/ooki/ShinyAB/run_tests.R     shinytest                
4                 /home/ooki/ShinyAB/run_tests.R      testthat                
5                    /home/ooki/ShinyAB/server.R          base                
6                    /home/ooki/ShinyAB/server.R         dplyr                
7                    /home/ooki/ShinyAB/server.R         knitr                
8                    /home/ooki/ShinyAB/server.R         shiny                
9                    /home/ooki/ShinyAB/server.R         tippy                
10  /home/ooki/ShinyAB/shinyloadtest/02_record.R shinyloadtest                
11 /home/ooki/ShinyAB/shinyloadtest/04_analyze.R shinyloadtest                
12               /home/ooki/ShinyAB/tests/test.R     shinytest                
13               /home/ooki/ShinyAB/tests/test.R      testthat                
14                       /home/ooki/ShinyAB/ui.R         shiny                
15                       /home/ooki/ShinyAB/ui.R         tippy                
> 
```

### `renv::hydogen()` 

ProjectのなかでSystem libraryから使われているPackageをProject libraryにインストールしてくれる

`renv::init()` の中でこれが実行されている模様

```R
> renv::hydrogen()
```

### `renv::clean()`

使ってないライブラリをProject libraryからRemoveしてくれる

```R
> renv::clean()
```

### `renv::settings`

renvの振る舞いを設定できる。無視するパッケージなど
参考 : https://rstudio.github.io/renv/reference/settings.html

```R
> renv::settings$ignored.packages()
> renv::settings$ignored.packages("devtools", persist = FALSE)
```

#### `renv::settings$use.cache(FALSE)`

renvキャッシュを使わなくする設定

#### `renv::settings$snapshot.type("simple")`

renvのsnapshotの方法を変更する。デフォルトは`packrat`。`simple`にしたら、ユーザライブラリのすべてをlockfileに書こうとする

### Issue
* `pacman::p_load` 対応してくれた: https://github.com/rstudio/renv/issues/143

### 参考
* [Snapshot and Restore](https://environments.rstudio.com/snapshot)
