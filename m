From: Joel Stanley <joel@jms.id.au>
Date: Tue, 8 Dec 2020 02:27:37 +0000
Subject: [PATCH 1/2] clk: ast2600: fix reset settings for eclk and vclk
In-Reply-To: <20201207164240.15436-2-jae.hyun.yoo@linux.intel.com>
References: <20201207164240.15436-1-jae.hyun.yoo@linux.intel.com>
 <20201207164240.15436-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <CACPK8Xf-5YDB2ofA+ivn8AtKLmVABD2PQ7p678cppu0hka63xQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 7 Dec 2020 at 16:33, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> Video engine reset setting should be coupled with eclk to match it
> with the setting for previous Aspeed SoCs which is defined in
> clk-aspeed.c since all Aspeed SoCs are sharing a single video engine
> driver. Also, reset bit 6 is defined as 'Video Engine' reset in
> datasheet so it should be de-asserted when eclk is enabled. This
> commit fixes the setting.
>
> Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

This fix should go to stable too.

Thanks Jae.

> ---
>  drivers/clk/clk-ast2600.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index 177368cac6dd..882da16575d4 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -60,10 +60,10 @@ static void __iomem *scu_g6_base;
>  static const struct aspeed_gate_data aspeed_g6_gates[] = {
>         /*                                  clk rst  name               parent   flags */
>         [ASPEED_CLK_GATE_MCLK]          = {  0, -1, "mclk-gate",        "mpll",  CLK_IS_CRITICAL }, /* SDRAM */
> -       [ASPEED_CLK_GATE_ECLK]          = {  1, -1, "eclk-gate",        "eclk",  0 },   /* Video Engine */
> +       [ASPEED_CLK_GATE_ECLK]          = {  1,  6, "eclk-gate",        "eclk",  0 },   /* Video Engine */
>         [ASPEED_CLK_GATE_GCLK]          = {  2,  7, "gclk-gate",        NULL,    0 },   /* 2D engine */
>         /* vclk parent - dclk/d1clk/hclk/mclk */
> -       [ASPEED_CLK_GATE_VCLK]          = {  3,  6, "vclk-gate",        NULL,    0 },   /* Video Capture */
> +       [ASPEED_CLK_GATE_VCLK]          = {  3, -1, "vclk-gate",        NULL,    0 },   /* Video Capture */
>         [ASPEED_CLK_GATE_BCLK]          = {  4,  8, "bclk-gate",        "bclk",  0 }, /* PCIe/PCI */
>         /* From dpll */
>         [ASPEED_CLK_GATE_DCLK]          = {  5, -1, "dclk-gate",        NULL,    CLK_IS_CRITICAL }, /* DAC */
> --
> 2.17.1
>
