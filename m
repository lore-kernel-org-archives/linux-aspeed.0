From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Thu, 15 Aug 2024 05:50:15 +0000
Subject: =?big5?B?pl7C0DogW1BBVENIIHYxIDAxLzEwXSBkdC1iaW5kaW5nOiBtZmQ6IGFzcGVlZCxh?=
 =?big5?Q?st2x00-scu:_Add_binding_for_ASPEED_AST2700_SCU?=
In-Reply-To: <e6cb6f26-fef2-49bc-ab25-fdc9a659f593@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-2-kevin_chen@aspeedtech.com>
 <e6cb6f26-fef2-49bc-ab25-fdc9a659f593@kernel.org>
Message-ID: <PSAPR06MB494964BEE33B160EE5E2159289802@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

I will speperate clock part in the v3 patch into Ryan's clock series.

>Missing commit msg.
>
>Please use subject prefixes matching the subsystem. You can get them for
>example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>your patch is touching. For bindings, the preferred subjects are
>explained here:
>https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>
>A nit, subject: drop second/last, redundant "bindings for". The
>"dt-bindings" prefix is already stating that these are bindings.
>See also:
>https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
Agree, already fixed in another commit in Ryan's series.
[1/4] dt-bindings: mfd: aspeed: support for AST2700 - Patchwork (kernel.org)<https://patchwork.kernel.org/project/linux-clk/patch/20240808075937.2756733-2-ryan_chen@aspeedtech.com/>

--
Best Regards,
Kevin. Chen

________________________________
???: Krzysztof Kozlowski <krzk@kernel.org>
????: 2024?7?26? ?? 07:10
???: Kevin Chen <kevin_chen@aspeedtech.com>; robh at kernel.org <robh@kernel.org>; krzk+dt at kernel.org <krzk+dt@kernel.org>; conor+dt at kernel.org <conor+dt@kernel.org>; joel at jms.id.au <joel@jms.id.au>; andrew at codeconstruct.com.au <andrew@codeconstruct.com.au>; lee at kernel.org <lee@kernel.org>; catalin.marinas at arm.com <catalin.marinas@arm.com>; will at kernel.org <will@kernel.org>; arnd at arndb.de <arnd@arndb.de>; olof at lixom.net <olof@lixom.net>; soc at kernel.org <soc@kernel.org>; mturquette at baylibre.com <mturquette@baylibre.com>; sboyd at kernel.org <sboyd@kernel.org>; p.zabel at pengutronix.de <p.zabel@pengutronix.de>; quic_bjorande at quicinc.com <quic_bjorande@quicinc.com>; geert+renesas at glider.be <geert+renesas@glider.be>; dmitry.baryshkov at linaro.org <dmitry.baryshkov@linaro.org>; shawnguo at kernel.org <shawnguo@kernel.org>; neil.armstrong at linaro.org <neil.armstrong@linaro.org>; m.szyprowski at samsung.com <m.szyprowski@samsung.com>; nfraprado at collabora.com <nfraprado@collabora.com>; u-kumar1 at ti.com <u-kumar1@ti.com>; devicetree at vger.kernel.org <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>; linux-aspeed at lists.ozlabs.org <linux-aspeed@lists.ozlabs.org>; linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>; linux-clk at vger.kernel.org <linux-clk@vger.kernel.org>
??: Re: [PATCH v1 01/10] dt-binding: mfd: aspeed,ast2x00-scu: Add binding for ASPEED AST2700 SCU

On 26/07/2024 13:03, Kevin Chen wrote:
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>

Missing commit msg.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18



Best regards,
Krzysztof

************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240815/b56b5015/attachment-0001.htm>
