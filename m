From: Joel Stanley <joel@jms.id.au>
Date: Thu, 20 Jun 2019 08:29:36 +0000
Subject: [PATCH] soc: aspeed: fix probe error handling
In-Reply-To: <20190619125636.1109665-1-arnd@arndb.de>
References: <20190619125636.1109665-1-arnd@arndb.de>
Message-ID: <CACPK8Xe0Ppr8QjPSTPyNSHEbSXvuZLjC04hqP6ATTSystY888w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2019 at 12:56, Arnd Bergmann <arnd@arndb.de> wrote:
>
> gcc warns that a mising "flash" phandle node leads to undefined
> behavior later:
>
> drivers/soc/aspeed/aspeed-lpc-ctrl.c: In function 'aspeed_lpc_ctrl_probe':
> drivers/soc/aspeed/aspeed-lpc-ctrl.c:201:18: error: '*((void *)&resm+8)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> The device cannot work without this node, so just error out here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd. This looks like it applies on top of Vijay's recent patch?

The intent of that change was to make the driver usable for systems
that do not want to depend on the flash phandle. I think the fix we
want looks like this:

--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -224,10 +224,11 @@ static int aspeed_lpc_ctrl_probe(struct
platform_device *pdev)
                        dev_err(dev, "Couldn't address to resource for
flash\n");
                        return rc;
                }
+
+               lpc_ctrl->pnor_size = resource_size(&resm);
+               lpc_ctrl->pnor_base = resm.start;
        }

-       lpc_ctrl->pnor_size = resource_size(&resm);
-       lpc_ctrl->pnor_base = resm.start;


Vijay, do you agree?

Cheers,

Joel

> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> index 239520bb207e..81109d22af6a 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> @@ -212,6 +212,7 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>         node = of_parse_phandle(dev->of_node, "flash", 0);
>         if (!node) {
>                 dev_dbg(dev, "Didn't find host pnor flash node\n");
> +               return -ENXIO;
>         } else {
>                 rc = of_address_to_resource(node, 1, &resm);
>                 of_node_put(node);
> --
> 2.20.0
>
