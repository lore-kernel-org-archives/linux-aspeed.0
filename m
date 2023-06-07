From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 7 Jun 2023 10:55:08 +0200
Subject: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
In-Reply-To: <SG2PR06MB33652E18980E9CF8E4F0894D8B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
 <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
 <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
 <c28f963e-d13c-6b5c-c389-996e986f81d5@linaro.org>
 <SG2PR06MB33652E18980E9CF8E4F0894D8B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Message-ID: <c8fe71a4-f8bb-d0a5-a227-14040fa024a9@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 07/06/2023 08:26, Billy Tsai wrote:
>         >>
>         >> He felt what he was trying to accomplish met the documented
>         >> expectations.  Are there some changes that need to be done in mfd.txt to
>         >> further clarify when to use it and when not to?
> 
>         > I think mfd.txt clearly states:
>         > "For more complex devices, when the nexus driver has to
>         > probe registers to figure out what child devices exist etc, this should
>         > not be used. In the latter case the child devices will be determined by
>         > the operating system."
> 
> About the mfd:
> For our pwm and tach devices, there is no need to check/apply any hardware register from parent to determine child?s existence or functional.
> They don?t have any dependency on the parent node. In fact, it doesn?t require a specific driver to bind with the "aspeed,ast2600-pwm-tach" label. Their purpose is solely to share the same clock, reset phandle and base address. The main reason for using simple-mfd in this case is because these two independent devices share the same base address.

Actually one more thoughts. I have doubt that you have two independent
devices. If you share the clock, reset line and register address space,
this means *you do not have two independent devices*.

You have most likely only one device.

Best regards,
Krzysztof

