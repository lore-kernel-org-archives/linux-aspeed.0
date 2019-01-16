From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Jan 2019 11:11:01 +1100
Subject: [PATCH] misc: aspeed-lpc-ctrl: make memory-region optional
In-Reply-To: <20190115015146.2412785-1-vijaykhemka@fb.com>
References: <20190115015146.2412785-1-vijaykhemka@fb.com>
Message-ID: <CACPK8Xesi2tQzH1d=Ow6VucO3qo6ptosKb-WDi-Cw1vg5FXGzg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vijay,

On Tue, 15 Jan 2019 at 12:51, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Makiing memory-region as optional parameter in device tree if
> user needs to use memory-region then define in devicetree.

Thank you for finding the time to do this work. You're not the first
to be blocked by this limitation, but you are the first who found the
time to propose a patch.

I think we should complete the rework to make the flash device
optional too. Can you do a v2 with a proposal for that?

>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> index a024f8042259..20507f0764fb 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -90,6 +90,10 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                 if (map.window_id != 0)
>                         return -EINVAL;
>
> +               /* If memory-region is not described in device tree */
> +               if (!lpc_ctrl->mem_size)
> +                       return -EINVAL;
> +
>                 map.size = lpc_ctrl->mem_size;
>
>                 return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
> @@ -129,6 +133,10 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                         addr = lpc_ctrl->pnor_base;
>                         size = lpc_ctrl->pnor_size;
>                 } else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
> +                       /* If memory-region is not described in device tree */
> +                       if (!lpc_ctrl->mem_size)

Should it print a message here? I think a dev_dbg makes sense.

> +                               return -EINVAL;
> +
>                         addr = lpc_ctrl->mem_base;
>                         size = lpc_ctrl->mem_size;
>                 } else {
> @@ -214,22 +222,20 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>
>         dev_set_drvdata(&pdev->dev, lpc_ctrl);
>
> +       /* If memory-region is described in device tree then store */
>         node = of_parse_phandle(dev->of_node, "memory-region", 0);
> -       if (!node) {
> -               dev_err(dev, "Didn't find reserved memory\n");
> -               return -EINVAL;
> -       }
> +       if (node) {

Print a debug message when we didn't find the node.

> +               rc = of_address_to_resource(node, 0, &resm);
> +               of_node_put(node);
> +               if (rc) {
> +                       dev_err(dev, "Couldn't address to resource for reserved memory\n");
> +                       return -ENOMEM;
> +               }
>
> -       rc = of_address_to_resource(node, 0, &resm);
> -       of_node_put(node);
> -       if (rc) {
> -               dev_err(dev, "Couldn't address to resource for reserved memory\n");
> -               return -ENOMEM;
> +               lpc_ctrl->mem_size = resource_size(&resm);
> +               lpc_ctrl->mem_base = resm.start;
>         }
>
> -       lpc_ctrl->mem_size = resource_size(&resm);
> -       lpc_ctrl->mem_base = resm.start;
> -
>         lpc_ctrl->regmap = syscon_node_to_regmap(
>                         pdev->dev.parent->of_node);
>         if (IS_ERR(lpc_ctrl->regmap)) {

Down below here is this line:

>        dev_info(dev, "Loaded at %pr\n", &resm);

As resm is first used for the flash resource and then the memory
region, it will display the location of the flash when the memory
region is not present. This is confusing. You should either print out
the regions separately, or consider removing this dev_info completely.

> --
> 2.17.1
>
