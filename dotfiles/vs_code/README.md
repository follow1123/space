# visual studio code 配置

不知道微软怎么想的，现在几个版本不能覆盖默认的profile了，导入的配置只能起一个新的名字，但是有些插件的部分配置只能配在默认的profile内才生效，vim插件的设置按键配置就只能在默认profile内配置

* 先将必须在默认profile内配置的文件移动到默认配置文件夹内

```cmd
mklink %APPDATA%\Code\User\settings.json %USERPROFILE%\space\dotfiles\vs_code\settings.json

```

* 在手动导入.code-profile结尾的文件

