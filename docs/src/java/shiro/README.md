# Shiro


## 认证(Authentication)

### 身份(principals)

> 一般对应用户名、邮箱


### 证明/凭证(credentials)

> 一般对应密码

## 授权(Authorization)

### 主体(Subject)

> 对应用户等

### 资源

> 对应菜单，按钮等

### 权限

> 对应是否能对资源进行crud操作

### 角色

> 权限集合


## 会话管理(Session Management)

## Web Support

## 缓存(Caching)

## Concurrency

## 测试(Testing)

## Run As

## Remember Me

## 代码

### 使用ini模拟登录

* Main.java

```java
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.Subject;

public class Main {
    public static void main(String[] args) {
        IniSecurityManagerFactory factory = new IniSecurityManagerFactory();
        SecurityManager instance = factory.getInstance();
        SecurityUtils.setSecurityManager(instance);

        Subject subject = SecurityUtils.getSubject();

        UsernamePasswordToken admin = new UsernamePasswordToken("admin", "123456");

        try {
            subject.login(admin);
            System.out.println("登录成功");
        } catch (AuthenticationException e) {
            System.out.println("用户名或密码错误");
            throw new RuntimeException(e);
        }
    }
}
```

* resources目录下新建shiro.ini

```ini
[users]
admin=123456
```

### 使用ini文件模拟鉴权

* Main.java

```java
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.Subject;

public class Main {
    public static void main(String[] args) {
        IniSecurityManagerFactory factory = new IniSecurityManagerFactory();
        SecurityManager instance = factory.getInstance();
        SecurityUtils.setSecurityManager(instance);

        Subject subject = SecurityUtils.getSubject();

        UsernamePasswordToken user = new UsernamePasswordToken("admin", "123456");
//        UsernamePasswordToken user = new UsernamePasswordToken("zs", "123");

        try {
            subject.login(user);
            System.out.println("登录成功");

            // 角色校验
            boolean isAdmin = subject.hasRole("administrator");
            if (isAdmin){
                System.out.println("管理员登录");
            }else{
                System.out.println("非管理员登录");
            }

            // 权限校验
            if (subject.isPermitted("user:view")) {
                System.out.println("允许查看用户");
            }

            if (subject.isPermitted("user:delete")){
                System.out.println("允许删除用户");
            }

        } catch (AuthenticationException e) {
            System.out.println("用户名或密码错误");
            throw new RuntimeException(e);
        }
    }
}
```

* resources目录下新建shiro.ini

```ini
[users]
admin=123456,administrator
zs=123,user

[roles]
administrator=user:view,user:insert,user:update,user:delete
user=user:view,user:update
```

### Shiro加密

```java
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.crypto.hash.SimpleHash;

public class ShiroPassword {
    public static void main(String[] args) {

        String password = "password";

        // sha加密
        Sha256Hash enc1 = new Sha256Hash(password);
        System.out.println("enc1 = " + enc1);

        // 加盐加密
        Sha256Hash enc2 = new Sha256Hash(password, "12345431");
        System.out.println("enc2 = " + enc2);

        // 多次加密
        Sha256Hash enc3 = new Sha256Hash(password, "1231", 4);
        System.out.println("enc3 = " + enc3);

        // 选择加密方式加密
        SimpleHash enc4 = new SimpleHash("MD5", password);
        System.out.println("enc4 = " + enc4);

    }
}
```

### 使用自定义Realm进行认证操作

* CustomRealm.java

```java
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.credential.Sha256CredentialsMatcher;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.util.ByteSource;


public class CustomRealm extends AuthenticatingRealm{


    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        // 获取用户名（身份）
        String username = token.getPrincipal().toString();

        // 获取密码（凭证）
        String password = String.valueOf(token.getCredentials());

        System.out.println("用户：" + username + "正在登录，密码为：" + password);
        String passwdFromDB = null;
        // 从数据库获取密码进行匹配
        if ("admin".equals(username)){
            passwdFromDB = "4c2d82a2242bfb84249e563f5c9922e77ed6bd06683a37b2247d05fa63355235";
        } else if ("zs".equals(username)){
            passwdFromDB = "87109e4282dc3e6463bf06c66d3313c0c4137036b33ef0bf600262d1c8b8415a";
        }

       return new SimpleAuthenticationInfo(token.getPrincipal(), passwdFromDB, ByteSource.Util.bytes("abc"), username);
    }
}
```

* resources目录下新建shiro.ini

```ini
[main]
# 密码匹配器
cm = org.apache.shiro.authc.credential.HashedCredentialsMatcher
# 加密算法
cm.hashAlgorithmName = SHA-256
# 加密迭代次数
cm.hashIterations = 5
# 是否保存为16进制编码方式
cm.storedCredentialsHexEncoded = true

# 自定义Realm
customRealm=com.demo.CustomRealm
customRealm.credentialsMatcher=$cm

securityManager.realms=$customRealm

[users]
admin=4c2d82a2242bfb84249e563f5c9922e77ed6bd06683a37b2247d05fa63355235,administrator
zs=87109e4282dc3e6463bf06c66d3313c0c4137036b33ef0bf600262d1c8b8415a,user

[roles]
administrator=user:view,user:insert,user:update,user:delete
user=user:view,user:update
```

* 在之前的main方法内测试
