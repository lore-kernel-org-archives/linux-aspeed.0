From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 27 Mar 2019 17:44:15 +0000
Subject: [Potential Spoof] Re: [Potential Spoof] Re: [Potential Spoof] Re:
 [PATCH v2] misc: aspeed-lpc-ctrl: make parameter optional
Message-ID: <4D1E0DC7-038D-46A5-9626-0D6C68476565@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,
Can you please apply this below patch to kernel 5.0.

Regards
-Vijay

?On 3/18/19, 12:46 PM, "openbmc on behalf of Vijay Khemka" <openbmc-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:

    Hi Joel,
    Can you please apply this patch as " Documentation/devicetree/bindings/mfd/aspeed-lpc.txt" has already been applied
    
    Regards
    -Vijay
    
    On 3/5/19, 4:15 PM, "Linux-aspeed on behalf of Vijay Khemka" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:
    
        Joel,
        Did this patch apply upstream. Somehow I can't find this patch in linux or linux-next or our obmc dev4.19.
        
        Regards
        -Vijay
        
        On 1/17/19, 10:53 AM, "Linux-aspeed on behalf of Vijay Khemka" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:
        
            
            
            On 1/16/19, 10:17 PM, "Joel Stanley" <joel@jms.id.au> wrote:
            
                On Thu, 17 Jan 2019 at 09:02, Vijay Khemka <vijaykhemka@fb.com> wrote:
                >
                > Makiing memory-region and flash as optional parameter in device
                > tree if user needs to use these parameter through ioctl then
                > need to define in devicetree.
                >
                > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
                
                Thanks! This looks okay to me. I tested it on one of our systems which
                uses both flash and reserved memory and it was fine.
                
                Reviewed-by: Joel Stanley <joel@jms.id.au>
                
                Can you also send a patch to update the bindings at
                Documentation/devicetree/bindings/mfd/aspeed-lpc.txt ? I think the
                only change you need to make is to move the memory region and flash
                properties to optional (instead of required).
            
            Sure I will do this.
                
                Cheers,
                
                Joel
                
                > ---
                >  drivers/misc/aspeed-lpc-ctrl.c | 58 +++++++++++++++++++++-------------
                >  1 file changed, 36 insertions(+), 22 deletions(-)
                >
                > diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
                > index a024f8042259..332210e06e98 100644
                > --- a/drivers/misc/aspeed-lpc-ctrl.c
                > +++ b/drivers/misc/aspeed-lpc-ctrl.c
                > @@ -68,6 +68,7 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
                >                 unsigned long param)
                >  {
                >         struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
                > +       struct device *dev = file->private_data;
                >         void __user *p = (void __user *)param;
                >         struct aspeed_lpc_ctrl_mapping map;
                >         u32 addr;
                > @@ -90,6 +91,12 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
                >                 if (map.window_id != 0)
                >                         return -EINVAL;
                >
                > +               /* If memory-region is not described in device tree */
                > +               if (!lpc_ctrl->mem_size) {
                > +                       dev_err(dev, "Didn't find reserved memory\n");
                > +                       return -EINVAL;
                > +               }
                > +
                >                 map.size = lpc_ctrl->mem_size;
                >
                >                 return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
                > @@ -126,9 +133,18 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
                >                         return -EINVAL;
                >
                >                 if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
                > +                       if (!lpc_ctrl->pnor_size) {
                > +                               dev_err(dev, "Didn't find host pnor flash\n");
                > +                               return -EINVAL;
                > +                       }
                >                         addr = lpc_ctrl->pnor_base;
                >                         size = lpc_ctrl->pnor_size;
                >                 } else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
                > +                       /* If memory-region is not described in device tree */
                > +                       if (!lpc_ctrl->mem_size) {
                > +                               dev_err(dev, "Didn't find reserved memory\n");
                > +                               return -EINVAL;
                > +                       }
                >                         addr = lpc_ctrl->mem_base;
                >                         size = lpc_ctrl->mem_size;
                >                 } else {
                > @@ -196,17 +212,17 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
                >         if (!lpc_ctrl)
                >                 return -ENOMEM;
                >
                > +       /* If flash is described in device tree then store */
                >         node = of_parse_phandle(dev->of_node, "flash", 0);
                >         if (!node) {
                > -               dev_err(dev, "Didn't find host pnor flash node\n");
                > -               return -ENODEV;
                > -       }
                > -
                > -       rc = of_address_to_resource(node, 1, &resm);
                > -       of_node_put(node);
                > -       if (rc) {
                > -               dev_err(dev, "Couldn't address to resource for flash\n");
                > -               return rc;
                > +               dev_dbg(dev, "Didn't find host pnor flash node\n");
                > +       } else {
                > +               rc = of_address_to_resource(node, 1, &resm);
                > +               of_node_put(node);
                > +               if (rc) {
                > +                       dev_err(dev, "Couldn't address to resource for flash\n");
                > +                       return rc;
                > +               }
                >         }
                >
                >         lpc_ctrl->pnor_size = resource_size(&resm);
                > @@ -214,22 +230,22 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
                >
                >         dev_set_drvdata(&pdev->dev, lpc_ctrl);
                >
                > +       /* If memory-region is described in device tree then store */
                >         node = of_parse_phandle(dev->of_node, "memory-region", 0);
                >         if (!node) {
                > -               dev_err(dev, "Didn't find reserved memory\n");
                > -               return -EINVAL;
                > -       }
                > +               dev_dbg(dev, "Didn't find reserved memory\n");
                > +       } else {
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
                > @@ -258,8 +274,6 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
                >                 goto err;
                >         }
                >
                > -       dev_info(dev, "Loaded at %pr\n", &resm);
                > -
                >         return 0;
                >
                >  err:
                > --
                > 2.17.1
                >
                
            
            
        
        
    
    

