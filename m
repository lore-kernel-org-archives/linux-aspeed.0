From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 20 Dec 2023 09:27:14 +0100
Subject: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Wedge400 BMC
In-Reply-To: <20200824211948.12852-6-rentao.bupt@gmail.com>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
 <20200824211948.12852-6-rentao.bupt@gmail.com>
Message-ID: <20231220082714.GA17989@wunner.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2020 at 02:19:48PM -0700, rentao.bupt at gmail.com wrote:
> Add initial version of device tree for Facebook Wedge400 (AST2500) BMC.
[...]
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
[...]
> +		tpmdev at 0 {
> +			compatible = "tcg,tpm_tis-spi";

What's the chip used on this board?  Going forward, the DT schema for TPMs
requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".


> +			spi-max-frequency = <33000000>;
> +			reg = <0>;
> +		};
