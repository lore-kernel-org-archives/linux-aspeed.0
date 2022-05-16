From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 16 May 2022 07:54:03 +0200
Subject: [PATCH 3/3] dt-bindings: usb: add documentation for aspeed udc
In-Reply-To: <HK0PR06MB32020539063F8A7C5D56E0B980CF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220513065728.857722-1-neal_liu@aspeedtech.com>
 <20220513065728.857722-4-neal_liu@aspeedtech.com>
 <da78aaf6-c9ae-d591-fdc4-723f097ace2c@linaro.org>
 <HK0PR06MB3202679A7FABAF7D0D045F0880CA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <567d135b-3d40-9958-e000-1357020b5650@linaro.org>
 <HK0PR06MB32020539063F8A7C5D56E0B980CF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <3499cca2-1d7b-12f5-adbe-0c9b279cc51a@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 16/05/2022 03:59, Neal Liu wrote:
>>> Okay, I could rename it for next patch if you preferred.
>>> But there are lots of yaml files which are not named as first compatible.
>>
>> Yes, I know, I quite likely I also produced such bindings, but a specific name is
>> rather preferred. Otherwise you will have a difficult naming choice when your
>> next Aspeed UDC requires new bindings file because of some differences (not
>> yet known now).
>>
> We can rename the bindings if next Aspeed UDC needs, don't you think?
> Currently, Aspeed has no requirement.

So just use proper name from the beginning....


Best regards,
Krzysztof
