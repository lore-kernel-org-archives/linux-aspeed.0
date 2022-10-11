From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Tue, 11 Oct 2022 16:49:48 +0200
Subject: [PATCH v2 14/36] pinctrl: mediatek: Add missed header(s)
In-Reply-To: <20221010201453.77401-15-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-15-andriy.shevchenko@linux.intel.com>
Message-ID: <74cdcd93-a528-ec8c-0808-0d698b86e47d@collabora.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Il 10/10/22 22:14, Andy Shevchenko ha scritto:
> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
> 
> While at it, sort headers alphabetically.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/pinctrl/mediatek/pinctrl-moore.c | 3 +++
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 5 +++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
> index 526faaebaf77..9474ada5addb 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-moore.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
> @@ -9,6 +9,9 @@
>    */
>   
>   #include <linux/gpio/driver.h>
> +

Apart from this blank line that I deem unnecessary....

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


