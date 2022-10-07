From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 7 Oct 2022 09:06:37 +0200
Subject: [PATCH v3] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
In-Reply-To: <20221007055346.3484180-1-Delphine_CC_Chiu@Wiwynn.com>
References: <20221007055346.3484180-1-Delphine_CC_Chiu@Wiwynn.com>
Message-ID: <4b861177-df32-ab9c-c746-f32f0ee6438d@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 07/10/2022 07:53, Delphine CC Chiu wrote:
> Add linux device tree entry related to
> greatlakes specific devices connected to BMC SoC.
> 
> ---
> --- v3 - Add documentation of board compatible (bindings)
> ---    - Add board compatible
> ---    - Remove the bootargs
> ---    - Revise the DTS node name
> ---
> --- v2 - Add binding document
> ---
> --- v1 - Initial draft

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> ---
> 
> Signed-off-by: Bonnie Lo <Bonnie_Lo@Wiwynn.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 241 ++++++++++++++++++

You need to document the binding. I think you already did, but then
submitted without it. Read the process:

https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst

Best regards,
Krzysztof

