From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Thu, 15 Aug 2024 05:50:39 +0000
Subject: =?big5?B?pl7C0DogW1BBVENIIHYxIDA2LzEwXSBkdC1iaW5kaW5nczogYXJtOiBhc3BlZWQ6?=
 =?big5?Q?_Add_aspeed,ast2700-evb_compatible_string?=
In-Reply-To: <371a7c7b-de32-4f97-b4c7-3c0ad0732e1a@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-7-kevin_chen@aspeedtech.com>
 <371a7c7b-de32-4f97-b4c7-3c0ad0732e1a@kernel.org>
Message-ID: <PSAPR06MB4949967385040FAC98C809D789802@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

>> ---
>>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> index 71c31c08a8ad..b21551817f44 100644
>> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> @@ -99,4 +99,9 @@ properties:
>>                - ufispace,ncplite-bmc
>>            - const: aspeed,ast2600
>>
>> +      - description: AST2700 based boards
>> +        items:
>> +          - enum:
>> +              - aspeed,ast2700-evb
>
>NAK, this cannot be alone. Look at all other examples. Why are you doing
>things differently?
Disagree, ast2700-evb is 7th generation IC in ASPEED. It not in the sub-set of AST2400/AST2500/AST2600 based boards.

--
Best Regards,
Kevin. Chen


________________________________
???: Krzysztof Kozlowski <krzk@kernel.org>
????: 2024?7?26? ?? 07:15
???: Kevin Chen <kevin_chen@aspeedtech.com>; robh at kernel.org <robh@kernel.org>; krzk+dt at kernel.org <krzk+dt@kernel.org>; conor+dt at kernel.org <conor+dt@kernel.org>; joel at jms.id.au <joel@jms.id.au>; andrew at codeconstruct.com.au <andrew@codeconstruct.com.au>; lee at kernel.org <lee@kernel.org>; catalin.marinas at arm.com <catalin.marinas@arm.com>; will at kernel.org <will@kernel.org>; arnd at arndb.de <arnd@arndb.de>; olof at lixom.net <olof@lixom.net>; soc at kernel.org <soc@kernel.org>; mturquette at baylibre.com <mturquette@baylibre.com>; sboyd at kernel.org <sboyd@kernel.org>; p.zabel at pengutronix.de <p.zabel@pengutronix.de>; quic_bjorande at quicinc.com <quic_bjorande@quicinc.com>; geert+renesas at glider.be <geert+renesas@glider.be>; dmitry.baryshkov at linaro.org <dmitry.baryshkov@linaro.org>; shawnguo at kernel.org <shawnguo@kernel.org>; neil.armstrong at linaro.org <neil.armstrong@linaro.org>; m.szyprowski at samsung.com <m.szyprowski@samsung.com>; nfraprado at collabora.com <nfraprado@collabora.com>; u-kumar1 at ti.com <u-kumar1@ti.com>; devicetree at vger.kernel.org <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>; linux-aspeed at lists.ozlabs.org <linux-aspeed@lists.ozlabs.org>; linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>; linux-clk at vger.kernel.org <linux-clk@vger.kernel.org>
??: Re: [PATCH v1 06/10] dt-bindings: arm: aspeed: Add aspeed,ast2700-evb compatible string

On 26/07/2024 13:03, Kevin Chen wrote:
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 71c31c08a8ad..b21551817f44 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -99,4 +99,9 @@ properties:
>                - ufispace,ncplite-bmc
>            - const: aspeed,ast2600
>
> +      - description: AST2700 based boards
> +        items:
> +          - enum:
> +              - aspeed,ast2700-evb

NAK, this cannot be alone. Look at all other examples. Why are you doing
things differently?

Best regards,
Krzysztof

************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240815/369eeeac/attachment-0001.htm>
