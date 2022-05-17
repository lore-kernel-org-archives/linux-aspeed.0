From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 17 May 2022 17:25:56 +0200
Subject: [PATCH v2 2/3] ARM: dts: aspeed: Add USB2.0 device controller node
In-Reply-To: <HK0PR06MB320295DB0748CEFC68B73CCF80CE9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220517082558.3534161-1-neal_liu@aspeedtech.com>
 <20220517082558.3534161-3-neal_liu@aspeedtech.com>
 <96973d1d-c52c-d190-6989-3f7996dae70b@linaro.org>
 <HK0PR06MB32027CAC4BEE443F426F587380CE9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <0bc5ba24-5bfb-593e-cbd0-828ef44aabc5@linaro.org>
 <HK0PR06MB320295DB0748CEFC68B73CCF80CE9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <1327ec95-f6b4-838d-f3f2-a115c2ab632b@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 17/05/2022 17:21, Neal Liu wrote:
>>>>>
>>>>> +		udc: udc at 1e6a2000 {
>>>>
>>>> The same as DTS in bindings - generic node name, please.
>>>>
>>>
>>> Is it possible to use "udc: usb-udc at 1e6a2000" to distinguish it between "vhub:
>> usb-vhub at 1e6a0000"?
>>
>> Possible yes :), but not recommended and not wanted. Nodes should be generic
>> and prefixes are added only if there is no unit address. You can though use
>> some more descriptive label.
>>
> "udc: usb at 1e6a2000" is okay for you?

Yes, it's perfect.


Best regards,
Krzysztof
