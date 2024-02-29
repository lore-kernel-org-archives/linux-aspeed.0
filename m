From: Kelly Hung(洪嘉莉) <Kelly_Hung@asus.com>
Date: Thu, 29 Feb 2024 11:18:39 -0000
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
In-Reply-To: <7f60e293-8076-4a06-9b6b-35f9c19578c4@linaro.org>
References: <20240229090913.1892215-1-Kelly_Hung@asus.com>
 <7f60e293-8076-4a06-9b6b-35f9c19578c4@linaro.org>
Message-ID: <TYZPR04MB65960D379D89A5C3C4A0B13B9D5F2@TYZPR04MB6596.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, Krzysztof,

I also confused, if I lost all from v1 to v4 change log? If the answer is yes, I had added them in v5.

I follow example and modify my changelogs,  https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L736
---
V4 -> V5: Update all changelog from v1 to v5.
V3 -> V4: The new compatible is a BMC for a ASUS X4TF server which use a ast2600-a3 chip, so correct string to asus,x4tf-bmc.
V2 -> V3: Add a label to indicate it is new compatible for bmc.
V1 -> V2: Remove blank in front of the string x4tf.
---

Thanks for help.
Best Regards
Kelly
-----Original Message-----
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Sent: Thursday, February 29, 2024 6:21 PM
To: Kelly Hung <ppighouse@gmail.com>; robh+dt at kernel.org
Cc: krzysztof.kozlowski+dt at linaro.org; conor+dt at kernel.org; joel at jms.id.au; andrew at codeconstruct.com.au; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org; openbmc at lists.ozlabs.org; Kelly Hung(???) <Kelly_Hung@asus.com>; AllenYY Hsu(???) <AllenYY_Hsu@asus.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board

External email : Ensure your email is secure before opening links and attachments.

On 29/02/2024 10:09, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.
>
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
>
> ---
> Changes in v4:
> - The new compatible is a BMC for a ASUS X4TF server which use a
> ast2600-a3 chip, so correct string to asus,x4tf-bmc.

And what happened with the rest of my message? Did you read it?

Best regards,
Krzysztof


<p></p>
===================================================================================================================================
This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed. If you are not the intended recipient or receive it accidentally, please immediately notify the sender by e-mail and delete the message and any attachments from your computer system, and destroy all hard copies. Please be advised that any unauthorized disclosure, copying, distribution or any action taken or omitted in reliance on this, is illegal and prohibited. Any views or opinions expressed are solely those of the author and do not represent those of ASUSTeK.

For pricing information, ASUS is only entitled to set a recommendation resale price. All customers are free to set their own price as they wish.
===================================================================================================================================
