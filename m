From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 20 Dec 2023 09:07:33 +0100
Subject: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
In-Reply-To: <20211207094923.422422-1-howard.chiu@quantatw.com>
References: <20211207094923.422422-1-howard.chiu@quantatw.com>
Message-ID: <20231220080733.GA30641@wunner.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 07, 2021 at 05:49:24PM +0800, Howard Chiu wrote:
> Initial introduction of Facebook Bletchley equipped with
> Aspeed 2600 BMC SoC.
[...]
> +		tpmdev at 0 {
> +			compatible = "tcg,tpm_tis-spi";

What's the chip used on this board?  Going forward, the DT schema for TPMs
requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".


> +			spi-max-frequency = <33000000>;
> +			reg = <0>;
> +		};
> +	};
