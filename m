From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2019 17:10:42 +0200
Subject: [PATCH v2 0/4] mmc: sdhci-of-aspeed: Fixes for AST2600 eMMC
 support
In-Reply-To: <20190902035842.2747-1-andrew@aj.id.au>
References: <20190902035842.2747-1-andrew@aj.id.au>
Message-ID: <CAPDyKFph4C7fCcGYzFp2PwwJsaFvw6a0Do4Vm0uF8mbwD7zUzQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2019 at 05:58, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> I've added a couple of patches since v1 of this series. The horizon has
> broadened slightly with a fix for SPARC builds as well in patch 1/4. Ulf
> suggested a minor cleanup on v1 with respect to handling of the current clock
> value, so that's now patch 2/4. Patches 3/4 and 4/4 are as they were in v1.

Applied patch 2->4 for next, thanks!

Kind regards
Uffe


>
> The v1 series can be found here:
>
> https://patchwork.ozlabs.org/cover/1155757/
>
> Please review!
>
> Andrew
>
> Andrew Jeffery (4):
>   mmc: sdhci-of-aspeed: Fix link failure for SPARC
>   mmc: sdhci-of-aspeed: Drop redundant assignment to host->clock
>   mmc: sdhci-of-aspeed: Uphold clocks-on post-condition of set_clock()
>   mmc: sdhci-of-aspeed: Allow max-frequency limitation of SDCLK
>
>  drivers/mmc/host/sdhci-of-aspeed.c | 62 ++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 20 deletions(-)
>
> --
> 2.20.1
>
