From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 Dec 2020 16:56:59 +0100
Subject: [PATCH v5 0/6] mmc: sdhci-of-aspeed: Expose phase delay tuning
In-Reply-To: <20201208012615.2717412-1-andrew@aj.id.au>
References: <20201208012615.2717412-1-andrew@aj.id.au>
Message-ID: <CAPDyKFpCiA_fT0tQ58z_3mt183RJ30QZWE_qjbmXGO3imHqMzw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 8 Dec 2020 at 02:26, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> This series implements support for the MMC core clk-phase-* devicetree bindings
> in the Aspeed SD/eMMC driver. The relevant register was exposed on the AST2600
> and is present for both the SD/MMC controller and the dedicated eMMC
> controller.
>
> v5 fixes some build issues identified by the kernel test robot.
>
> v4 can be found here:
>
> https://lore.kernel.org/linux-mmc/20201207142556.2045481-1-andrew at aj.id.au/
>
> The series has had light testing on an AST2600-based platform which requires
> 180deg of input and output clock phase correction at HS200, as well as some
> synthetic testing under qemu and KUnit.
>
> Please review!

FYI, other than the comment I had on patch1, I think the series looks
good to me.

[...]

Kind regards
Uffe
