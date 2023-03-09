From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 9 Mar 2023 09:51:39 +0100
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <SEZPR06MB5269CA376D572B6241FCAD4DF2B79@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
 <53090449-58c9-bc03-56df-aa8ae93c0c26@linaro.org>
 <SEZPR06MB52699DEB2255EB54F35C2A59F2AD9@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <fc20a2d1-e2f9-c22b-dcdf-153cb527eea8@linaro.org>
 <SEZPR06MB526902637624A97D7DFB8523F2B39@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <c41ee6b5-ddb4-1253-de54-a295b3bab2cc@linaro.org>
 <SEZPR06MB5269E7B8785B3CB56A63A916F2B39@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <a3615fe7-aa2a-53e9-2732-ba4512b9369d@linaro.org>
 <SEZPR06MB5269E7B070B239F8E349C427F2B39@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <c5cf6e0a-05dc-dff7-6218-df0984d1ba47@linaro.org>
 <SEZPR06MB5269CB53B51B89C3CA039442F2B09@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <e59fe30a-75d1-eb59-52a3-014fe3c961a6@linaro.org>
 <SEZPR06MB5269B541150855BF0DABFACFF2B69@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <d33145c3-e985-4d3c-a08c-6a249a8dc463@linaro.org>
 <SEZPR06MB5269CA376D572B6241FCAD4DF2B79@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <f17f09f9-ffd0-bd2b-7343-e468f83dd6e7@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 07/03/2023 11:09, Ryan Chen wrote:
>>>> 2. Why we do not have it for all controllers with SMBus v3? Why this
>>>> one is special?
>>>
>>> Not all bus is connected with smbus. Most are i2c device connected in board.
>>> That will be specific statement for each bus.
>>
>> That's not the answer to my question. Why other controllers which can be
>> connected to I2C or SMBus devices do not need this property?
> 
> For example following is the board specific connection.
> 
> Board A                                         Board B
> -------------------------                       ------------------------
> |i2c bus#1(master/slave)  <===fingerprint ===> i2c bus#x (master/slave)|
> |i2c bus#2(master)-> tmp i2c device |          |                       |
> |i2c bus#3(master)-> adc i2c device |          |                       |
> -------------------------                       ------------------------
> 
> Bus#1 is mctp transfer for each BoardA/B. (Not smbus connected)
> Bus#2 is i2c device connected.
> Bus#3 is i2c device connected.

You are repeating the same stuff for my question. Where do you see on
this diagram here other I2C controller? How does it answer my question?
You keep repeating same and same, so it won't work.



Best regards,
Krzysztof

