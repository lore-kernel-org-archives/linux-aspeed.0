From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Wed, 3 Nov 2021 23:05:27 +0000
Subject: [PATCH] soc: aspeed: lpc-ctrl: Block error printing on probe
 defer cases
In-Reply-To: <20211103215430.192229-1-jae.hyun.yoo@intel.com>
References: <20211103215430.192229-1-jae.hyun.yoo@intel.com>
Message-ID: <7e0bcb8b36bd6af1cadd30a18bf5e28d48b80c0c.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2021-11-03 at 14:54 -0700, jae.hyun.yoo at intel.com wrote:
> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> Add a checking code when it gets -EPROBE_DEFER while getting a clock
> resource. In this case, it doesn't need to print out an error message
> because the probing will be re-visited.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
> ?drivers/soc/aspeed/aspeed-lpc-ctrl.c | 6 ++++--
> ?1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-
> lpc-ctrl.c
> index 72771e018c42..e2262dbc7cf6 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> @@ -307,8 +307,10 @@ static int aspeed_lpc_ctrl_probe(struct platform_device
> *pdev)
> ?
> ????????lpc_ctrl->clk = devm_clk_get(dev, NULL);
> ????????if (IS_ERR(lpc_ctrl->clk)) {
> -???????????????dev_err(dev, "couldn't get clock\n");
> -???????????????return PTR_ERR(lpc_ctrl->clk);
> +???????????????rc = PTR_ERR(lpc_ctrl->clk);
> +???????????????if (rc != -EPROBE_DEFER)
> +???????????????????????dev_err(dev, "couldn't get clock\n");
> +???????????????return rc;
> ????????}
> ????????rc = clk_prepare_enable(lpc_ctrl->clk);
> ????????if (rc) {

This pattern should be handled using dev_err_probe()

Thanks
-Iwona
