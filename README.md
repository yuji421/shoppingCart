# 超シンプルカート（Tomcat 10）

Tomcat の動作確認用に作った最小のショッピングカート（JSP + Servlet）。

## 使い方
1. Apache Tomcat 10.1.44 を用意
2. このリポジトリのファイルを `tomcat/webapps/shop/` にコピー
3. サーブレットをコンパイル  
   ```powershell
   $TOMCAT="C:\tomcat\apache-tomcat-10.1.44"
   Set-Location "$TOMCAT\webapps\shop\WEB-INF\classes"
   javac -encoding UTF-8 -cp "$TOMCAT\lib\*;." .\com\example\CartServlet.java
