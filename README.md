# bronze
#### version
* Ruby: 2.7.2
* Rails: 6.1.4
* database: PGsql

##### Heroku
* brew tap heroku/brew && brew install heroku
安裝
* heroku login
```
heroku: Press any key to open up the browser to login or q to exit:
```
登入
* heroku --version
* heroku create bronze
* git push heroku topic:main
* heroku run rails db:migrate