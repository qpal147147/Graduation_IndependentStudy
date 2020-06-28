# 大學畢業專題
作品名稱為：**_遠端智慧型運送列車_**<br>
為IOT物聯網的作品。<br>
由4人團隊所創作。<hr>
## 使用語言<br>
* **前端**：HTML、CSS、JavaScript、JQuery
* **後端**：PHP
* **DataBase**：MySQL

## 作品架構<br>
網站透過WIFI傳達資訊給ESP8266 WIFI模組，透過8052單晶片讀取解析並驅動列車行駛，最後回傳即時點位訊息至網站。<br>
> **使用者**
>>使用者定料介面<br>
>>確認訂單介面<br>
>>使用者查詢訂單介面<br>
>>列車當前位置介面<br>

> **管理員**
>>管理員登入介面<br>
>>管理員管控介面(修改、刪除、確認運送)<br>

> **歷史資料查詢**
>>歷史資料查詢介面(日期區間查詢、年月份查詢)<br>

## 文件描述<br>
|         文件        |                       描述                      |
|         ---         |                       ---                      |
|**index.html**       |  使用者定料介面                                 |
|**stock.php**        |  顯示物料剩餘數量                               |
|**confirm.php**      | 再次確認使用者所選物料之介面                     |
|**Session.php**      | 將所選物料存入資料庫裡                           |
|**viewOrder.php**    | 使用者檢視所有訂單之介面                         |
|**loginManager.php** |  管理員管控網站之登入介面                        |
|**Manager.php**      | 管理員管控介面，負責處理所有訂單並隨時根據狀況修改 |
|**position.php**     |  負責讀取txt檔案內資料並顯示                     |
|**position.txt**     |  接收ESP8266所傳回的資訊                        |
|**trainPath.html**   |  將當前位置轉換成GIF圖                          |
|**loginHistory.php** |  歷史資料查詢網站之登入介面                      |
| **history.php**     | 顯示所有過往「已處理」之訂單                     |
|**8052.a51**         |  為8052單晶片進行所有處理與發送訊號的程式碼       |

## 文件關係圖<br>
## 整體流程<br>
## 軟體作品介紹<br>
