# V100Assist
V100マイクラサーバー（仮）の管理をするためのリポジトリ


### リポジトリ作成時の基本のキ  

[git_branch_flow.mb](https://github.com/Char6tte/V100Assist/blob/main/git_branch_flow.md)を使用してブランチを分割する。

### V100マイクラサーバー（仮）のデータ場所

NAS内のServerDataManagerディレクトリ内に配置。  
別途、プライベートリポジトリ内に保存。

・Default
初期状態のファイルを保存

・Running
現在稼働中のサーバーの主要ファイルをサーバー別に保存

~~~
    plugins  
    bukkit.yml  
    ops.json  
    server.properties  
    spigot.yml  
    usercache.yml  
    whitelist.yml
~~~

## 各サーバーについて
### ・サーバーソフトウェア
| [BungeeCord](https://www.spigotmc.org/wiki/bungeecord/) | Minecraft用のプロキシサーバー |
|---------------------------------------------------------|---------------------|
| [PaperMC](https://papermc.io/)                          | サーバー本体              |

### ・サーバー別運用目的等

#### 現行V100(仮)
>RAM　10GB  
>   
>ネザー、エンドも生かす。それ以外のワールドは削除  
エリア制度については完全排除。  
> 　　世界樹の石壁内はあまりいじらない  
現行廃止時に配布


