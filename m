From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 May 2019 05:55:07 +0000
Subject: [PATCH v2] misc: aspeed-lpc-ctrl: make parameter optional
In-Reply-To: <DCD8D2E5-DB18-427C-AA8F-18289E9AB0AB@fb.com>
References: <20190116220154.1026171-1-vijaykhemka@fb.com>
 <1547787502.2061444.1637712576.1F1E21B4@webmail.messagingengine.com>
 <DCD8D2E5-DB18-427C-AA8F-18289E9AB0AB@fb.com>
Message-ID: <CACPK8Xdgv1YVgeykf0grSpR3LXTGa45hoBwZVq+zWgR0anhmTg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 18 Jan 2019 at 20:12, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Hi Andrew,
> Thanks for this review, I will have a follow up patch for this return values.

Did you send a follow up patch to fix the return values?

Greg, is there any reason why you did not merge this one? 5.2 will
have device trees that depend on this patch's behavior.

Cheers,

Joel

> ?On 1/17/19, 8:58 PM, "Andrew Jeffery" <andrew@aj.id.au> wrote:
>
>     Hi Vijay,
>
>     Thanks for doing the work to fix the driver. Some minor queries/points
>     below.
>
>     On Thu, 17 Jan 2019, at 08:31, Vijay Khemka wrote:
>     > Makiing memory-region and flash as optional parameter in device
>     > tree if user needs to use these parameter through ioctl then
>     > need to define in devicetree.
>     >
>     > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>     > ---
>     >  drivers/misc/aspeed-lpc-ctrl.c | 58 +++++++++++++++++++++-------------
>     >  1 file changed, 36 insertions(+), 22 deletions(-)
>     >
>     > diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-
>     > ctrl.c
>     > index a024f8042259..332210e06e98 100644
>     > --- a/drivers/misc/aspeed-lpc-ctrl.c
>     > +++ b/drivers/misc/aspeed-lpc-ctrl.c
>     > @@ -68,6 +68,7 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file,
>     > unsigned int cmd,
>     >           unsigned long param)
>     >  {
>     >   struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
>     > + struct device *dev = file->private_data;
>     >   void __user *p = (void __user *)param;
>     >   struct aspeed_lpc_ctrl_mapping map;
>     >   u32 addr;
>     > @@ -90,6 +91,12 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file,
>     > unsigned int cmd,
>     >           if (map.window_id != 0)
>     >                   return -EINVAL;
>     >
>     > +         /* If memory-region is not described in device tree */
>     > +         if (!lpc_ctrl->mem_size) {
>     > +                 dev_err(dev, "Didn't find reserved memory\n");
>     > +                 return -EINVAL;
>
>     I feel like EINVAL isn't quite right - it's pretty generic, and the parameter
>     value changes its validity with the devicetree context. My gut instinct
>     would be to use EINVAL for parameter values that violate assumptions
>     of the driver rather than violate configuration of the driver. Maybe ENXIO
>     ("No such device or address") is an improvement: "I can't map that device
>     because there's no such device or address"?
>
>     > +         }
>     > +
>     >           map.size = lpc_ctrl->mem_size;
>     >
>     >           return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
>     > @@ -126,9 +133,18 @@ static long aspeed_lpc_ctrl_ioctl(struct file
>     > *file, unsigned int cmd,
>     >                   return -EINVAL;
>     >
>     >           if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
>     > +                 if (!lpc_ctrl->pnor_size) {
>     > +                         dev_err(dev, "Didn't find host pnor flash\n");
>     > +                         return -EINVAL;
>
>     See the error code discussion above. Also, this is userspace's error not
>     the kernel's, so I think dev_err() is a bit harsh. Probably best to just let
>     userspace log the error if it thinks the it is concerning.
>
>     > +                 }
>     >                   addr = lpc_ctrl->pnor_base;
>     >                   size = lpc_ctrl->pnor_size;
>     >           } else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
>     > +                 /* If memory-region is not described in device tree */
>     > +                 if (!lpc_ctrl->mem_size) {
>     > +                         dev_err(dev, "Didn't find reserved memory\n");
>     > +                         return -EINVAL;
>
>     as above.
>
>     > +                 }
>     >                   addr = lpc_ctrl->mem_base;
>     >                   size = lpc_ctrl->mem_size;
>     >           } else {
>     > @@ -196,17 +212,17 @@ static int aspeed_lpc_ctrl_probe(struct
>     > platform_device *pdev)
>     >   if (!lpc_ctrl)
>     >           return -ENOMEM;
>     >
>     > + /* If flash is described in device tree then store */
>     >   node = of_parse_phandle(dev->of_node, "flash", 0);
>     >   if (!node) {
>     > -         dev_err(dev, "Didn't find host pnor flash node\n");
>     > -         return -ENODEV;
>     > - }
>     > -
>     > - rc = of_address_to_resource(node, 1, &resm);
>     > - of_node_put(node);
>     > - if (rc) {
>     > -         dev_err(dev, "Couldn't address to resource for flash\n");
>     > -         return rc;
>     > +         dev_dbg(dev, "Didn't find host pnor flash node\n");
>     > + } else {
>     > +         rc = of_address_to_resource(node, 1, &resm);
>     > +         of_node_put(node);
>     > +         if (rc) {
>     > +                 dev_err(dev, "Couldn't address to resource for flash\n");
>     > +                 return rc;
>     > +         }
>     >   }
>     >
>     >   lpc_ctrl->pnor_size = resource_size(&resm);
>     > @@ -214,22 +230,22 @@ static int aspeed_lpc_ctrl_probe(struct
>     > platform_device *pdev)
>     >
>     >   dev_set_drvdata(&pdev->dev, lpc_ctrl);
>     >
>     > + /* If memory-region is described in device tree then store */
>     >   node = of_parse_phandle(dev->of_node, "memory-region", 0);
>     >   if (!node) {
>     > -         dev_err(dev, "Didn't find reserved memory\n");
>     > -         return -EINVAL;
>     > - }
>     > +         dev_dbg(dev, "Didn't find reserved memory\n");
>     > + } else {
>     > +         rc = of_address_to_resource(node, 0, &resm);
>     > +         of_node_put(node);
>     > +         if (rc) {
>     > +                 dev_err(dev, "Couldn't address to resource for reserved memory\n");
>     > +                 return -ENOMEM;
>
>     Wow, I think this is an abuse of ENOMEM. Its description is "Out of memory"
>     which doesn't really reflect the problem here.
>
>     Not really your fault though, maybe we'll fix that with some follow-up patches.
>
>     Cheers,
>
>     Andrew
>
>     > +         }
>     >
>     > - rc = of_address_to_resource(node, 0, &resm);
>     > - of_node_put(node);
>     > - if (rc) {
>     > -         dev_err(dev, "Couldn't address to resource for reserved memory\n");
>     > -         return -ENOMEM;
>     > +         lpc_ctrl->mem_size = resource_size(&resm);
>     > +         lpc_ctrl->mem_base = resm.start;
>     >   }
>     >
>     > - lpc_ctrl->mem_size = resource_size(&resm);
>     > - lpc_ctrl->mem_base = resm.start;
>     > -
>     >   lpc_ctrl->regmap = syscon_node_to_regmap(
>     >                   pdev->dev.parent->of_node);
>     >   if (IS_ERR(lpc_ctrl->regmap)) {
>     > @@ -258,8 +274,6 @@ static int aspeed_lpc_ctrl_probe(struct
>     > platform_device *pdev)
>     >           goto err;
>     >   }
>     >
>     > - dev_info(dev, "Loaded at %pr\n", &resm);
>     > -
>     >   return 0;
>     >
>     >  err:
>     > --
>     > 2.17.1
>     >
>
>
