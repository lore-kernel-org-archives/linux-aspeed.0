From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 9 Apr 2021 06:25:27 +0000
Subject: [PATCH v2 10/21] ipmi: kcs_bmc: Turn the driver data-structures
 inside-out
In-Reply-To: <ea34ee69-a266-4737-8450-4695d2d0fbd4@www.fastmail.com>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-10-andrew@aj.id.au> <YG/Ql9z9X/mtOSvl@packtop>
 <ea34ee69-a266-4737-8450-4695d2d0fbd4@www.fastmail.com>
Message-ID: <YG/zVv4XOo1HoLd1@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 09, 2021 at 12:59:09AM CDT, Andrew Jeffery wrote:
>
>
>On Fri, 9 Apr 2021, at 13:27, Zev Weiss wrote:
>> On Fri, Mar 19, 2021 at 01:27:41AM CDT, Andrew Jeffery wrote:
>> >Make the KCS device drivers responsible for allocating their own memory.
>> >
>> >Until now the private data for the device driver was allocated internal
>> >to the private data for the chardev interface. This coupling required
>> >the slightly awkward API of passing through the struct size for the
>> >driver private data to the chardev constructor, and then retrieving a
>> >pointer to the driver private data from the allocated chardev memory.
>> >
>> >In addition to being awkward, the arrangement prevents the
>> >implementation of alternative userspace interfaces as the device driver
>> >private data is not independent.
>> >
>> >Peel a layer off the onion and turn the data-structures inside out by
>> >exploiting container_of() and embedding `struct kcs_device` in the
>> >driver private data.
>> >
>> >Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> >---
>> > drivers/char/ipmi/kcs_bmc.c           | 15 +++++--
>> > drivers/char/ipmi/kcs_bmc.h           | 12 ++----
>> > drivers/char/ipmi/kcs_bmc_aspeed.c    | 60 ++++++++++++++++-----------
>> > drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 60 ++++++++++++++++++---------
>> > drivers/char/ipmi/kcs_bmc_npcm7xx.c   | 37 ++++++++++-------
>> > 5 files changed, 113 insertions(+), 71 deletions(-)
>> >
>> >diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
>> >index ef5c48ffe74a..709b6bdec165 100644
>> >--- a/drivers/char/ipmi/kcs_bmc.c
>> >+++ b/drivers/char/ipmi/kcs_bmc.c
>> >@@ -44,12 +44,19 @@ int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
>> > }
>> > EXPORT_SYMBOL(kcs_bmc_handle_event);
>> >
>> >-struct kcs_bmc *kcs_bmc_ipmi_alloc(struct device *dev, int sizeof_priv, u32 channel);
>> >-struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv, u32 channel)
>> >+int kcs_bmc_ipmi_attach_cdev(struct kcs_bmc *kcs_bmc);
>>
>> Another declaration perhaps intended for kcs_bmc.h?
>
>These are temporary while the code gets shuffled around. The symbol
>name is an implementation detail, not a "public" part of the API; after
>some further shuffling these are eventually assigned as callbacks in an
>ops struct.
>

Okay, that makes sense.

>>
>> >+int kcs_bmc_add_device(struct kcs_bmc *kcs_bmc)
>> > {
>> >-	return kcs_bmc_ipmi_alloc(dev, sizeof_priv, channel);
>> >+	return kcs_bmc_ipmi_attach_cdev(kcs_bmc);
>> > }
>> >-EXPORT_SYMBOL(kcs_bmc_alloc);
>> >+EXPORT_SYMBOL(kcs_bmc_add_device);
>> >+
>> >+int kcs_bmc_ipmi_detach_cdev(struct kcs_bmc *kcs_bmc);
>>
>> Here too.
>>
>> >+int kcs_bmc_remove_device(struct kcs_bmc *kcs_bmc)
>> >+{
>> >+	return kcs_bmc_ipmi_detach_cdev(kcs_bmc);
>> >+}
>> >+EXPORT_SYMBOL(kcs_bmc_remove_device);
>> >
>> > MODULE_LICENSE("GPL v2");
>> > MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
>> >diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
>> >index febea0c8deb4..bf0ae327997f 100644
>> >--- a/drivers/char/ipmi/kcs_bmc.h
>> >+++ b/drivers/char/ipmi/kcs_bmc.h
>> >@@ -67,6 +67,8 @@ struct kcs_ioreg {
>> > };
>> >
>> > struct kcs_bmc {
>> >+	struct device *dev;
>> >+
>> > 	spinlock_t lock;
>> >
>> > 	u32 channel;
>> >@@ -94,17 +96,11 @@ struct kcs_bmc {
>> > 	u8 *kbuffer;
>> >
>> > 	struct miscdevice miscdev;
>> >-
>> >-	unsigned long priv[];
>> > };
>> >
>> >-static inline void *kcs_bmc_priv(struct kcs_bmc *kcs_bmc)
>> >-{
>> >-	return kcs_bmc->priv;
>> >-}
>> >-
>> > int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc);
>> >-struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv, u32 channel);
>> >+int kcs_bmc_add_device(struct kcs_bmc *kcs_bmc);
>> >+int kcs_bmc_remove_device(struct kcs_bmc *kcs_bmc);
>> >
>> > u8 kcs_bmc_read_data(struct kcs_bmc *kcs_bmc);
>> > void kcs_bmc_write_data(struct kcs_bmc *kcs_bmc, u8 data);
>> >diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
>> >index 630cf095560e..0416ac78ce68 100644
>> >--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
>> >+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
>> >@@ -61,6 +61,8 @@
>> > #define LPC_STR4             0x11C
>> >
>> > struct aspeed_kcs_bmc {
>> >+	struct kcs_bmc kcs_bmc;
>> >+
>> > 	struct regmap *map;
>> > };
>> >
>> >@@ -69,9 +71,14 @@ struct aspeed_kcs_of_ops {
>> > 	int (*get_io_address)(struct platform_device *pdev);
>> > };
>> >
>> >+static inline struct aspeed_kcs_bmc *to_aspeed_kcs_bmc(struct kcs_bmc *kcs_bmc)
>> >+{
>> >+	return container_of(kcs_bmc, struct aspeed_kcs_bmc, kcs_bmc);
>> >+}
>> >+
>> > static u8 aspeed_kcs_inb(struct kcs_bmc *kcs_bmc, u32 reg)
>> > {
>> >-	struct aspeed_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
>> >+	struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
>> > 	u32 val = 0;
>> > 	int rc;
>> >
>> >@@ -83,7 +90,7 @@ static u8 aspeed_kcs_inb(struct kcs_bmc *kcs_bmc, u32 reg)
>> >
>> > static void aspeed_kcs_outb(struct kcs_bmc *kcs_bmc, u32 reg, u8 data)
>> > {
>> >-	struct aspeed_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
>> >+	struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
>> > 	int rc;
>> >
>> > 	rc = regmap_write(priv->map, reg, data);
>> >@@ -92,7 +99,7 @@ static void aspeed_kcs_outb(struct kcs_bmc *kcs_bmc, u32 reg, u8 data)
>> >
>> > static void aspeed_kcs_updateb(struct kcs_bmc *kcs_bmc, u32 reg, u8 mask, u8 val)
>> > {
>> >-	struct aspeed_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
>> >+	struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
>> > 	int rc;
>> >
>> > 	rc = regmap_update_bits(priv->map, reg, mask, val);
>> >@@ -114,7 +121,7 @@ static void aspeed_kcs_updateb(struct kcs_bmc *kcs_bmc, u32 reg, u8 mask, u8 val
>> >  */
>> > static void aspeed_kcs_set_address(struct kcs_bmc *kcs_bmc, u16 addr)
>> > {
>> >-	struct aspeed_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
>> >+	struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
>> >
>> > 	switch (kcs_bmc->channel) {
>> > 	case 1:
>> >@@ -148,7 +155,7 @@ static void aspeed_kcs_set_address(struct kcs_bmc *kcs_bmc, u16 addr)
>> >
>> > static void aspeed_kcs_enable_channel(struct kcs_bmc *kcs_bmc, bool enable)
>> > {
>> >-	struct aspeed_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
>> >+	struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
>> >
>> > 	switch (kcs_bmc->channel) {
>> > 	case 1:
>> >@@ -323,16 +330,16 @@ static int aspeed_kcs_of_v2_get_io_address(struct platform_device *pdev)
>> > static int aspeed_kcs_probe(struct platform_device *pdev)
>> > {
>> > 	const struct aspeed_kcs_of_ops *ops;
>> >-	struct device *dev = &pdev->dev;
>> >+	struct aspeed_kcs_bmc *priv;
>> > 	struct kcs_bmc *kcs_bmc;
>> > 	struct device_node *np;
>> > 	int rc, channel, addr;
>> >
>> >-	np = dev->of_node->parent;
>> >+	np = pdev->dev.of_node->parent;
>> > 	if (!of_device_is_compatible(np, "aspeed,ast2400-lpc-v2") &&
>> > 	    !of_device_is_compatible(np, "aspeed,ast2500-lpc-v2") &&
>> > 	    !of_device_is_compatible(np, "aspeed,ast2600-lpc-v2")) {
>> >-		dev_err(dev, "unsupported LPC device binding\n");
>> >+		dev_err(&pdev->dev, "unsupported LPC device binding\n");
>> > 		return -ENODEV;
>> > 	}
>> > 	ops = of_device_get_match_data(&pdev->dev);
>> >@@ -343,18 +350,27 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
>> > 	if (channel < 0)
>> > 		return channel;
>> >
>> >-	kcs_bmc = kcs_bmc_alloc(&pdev->dev, sizeof(struct aspeed_kcs_bmc), channel);
>> >-	if (!kcs_bmc)
>> >+	addr = ops->get_io_address(pdev);
>> >+	if (addr < 0)
>> >+		return addr;
>> >+
>> >+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> >+	if (!priv)
>> > 		return -ENOMEM;
>> >
>> >+	kcs_bmc = &priv->kcs_bmc;
>> >+	kcs_bmc->dev = &pdev->dev;
>> >+	kcs_bmc->channel = channel;
>> > 	kcs_bmc->ioreg = ast_kcs_bmc_ioregs[channel - 1];
>> > 	kcs_bmc->io_inputb = aspeed_kcs_inb;
>> > 	kcs_bmc->io_outputb = aspeed_kcs_outb;
>> > 	kcs_bmc->io_updateb = aspeed_kcs_updateb;
>> >
>> >-	addr = ops->get_io_address(pdev);
>> >-	if (addr < 0)
>> >-		return addr;
>> >+	priv->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
>> >+	if (IS_ERR(priv->map)) {
>> >+		dev_err(&pdev->dev, "Couldn't get regmap\n");
>> >+		return -ENODEV;
>> >+	}
>>
>> The reanimated priv->map initialization I suspect wasn't meant to
>> have been removed in the first place...
>
>Yeah, I'll have to go back and figure out what went wrong there!
>
>Thanks for catching that.
>
>>
>> >
>> > 	aspeed_kcs_set_address(kcs_bmc, addr);
>> >
>> >@@ -362,29 +378,25 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
>> > 	if (rc)
>> > 		return rc;
>> >
>> >-	dev_set_drvdata(dev, kcs_bmc);
>> >+	platform_set_drvdata(pdev, priv);
>> >
>> > 	aspeed_kcs_enable_channel(kcs_bmc, true);
>> >
>> >-	rc = misc_register(&kcs_bmc->miscdev);
>> >-	if (rc) {
>> >-		dev_err(dev, "Unable to register device\n");
>> >+	rc = kcs_bmc_add_device(&priv->kcs_bmc);
>> >+	if (rc < 0)
>> > 		return rc;
>> >-	}
>> >
>> >-	dev_dbg(&pdev->dev,
>> >-		"Probed KCS device %d (IDR=0x%x, ODR=0x%x, STR=0x%x)\n",
>> >-		kcs_bmc->channel, kcs_bmc->ioreg.idr, kcs_bmc->ioreg.odr,
>> >-		kcs_bmc->ioreg.str);
>> >+	dev_info(&pdev->dev, "Initialised channel %d at 0x%x\n", kcs_bmc->channel, addr);
>>
>> Is the dbg->info change here intentional?  (I have no particular
>> objection if so, but it's often a change I make myself during
>> testing/debugging and then forget to revert...)
>
>Yeah, it was possibly something I forgot to revert. If others have
>issues with it staying at dev_info() I'll switch it back.
>
>>
>> >
>> > 	return 0;
>> > }
>> >
>> > static int aspeed_kcs_remove(struct platform_device *pdev)
>> > {
>> >-	struct kcs_bmc *kcs_bmc = dev_get_drvdata(&pdev->dev);
>> >+	struct aspeed_kcs_bmc *priv = platform_get_drvdata(pdev);
>> >+	struct kcs_bmc *kcs_bmc = &priv->kcs_bmc;
>> >
>> >-	misc_deregister(&kcs_bmc->miscdev);
>> >+	kcs_bmc_remove_device(kcs_bmc);
>>
>> Should we propagate the return value outward here?
>
>Probably!
>
>>
>> >
>> > 	return 0;
>> > }
>> >diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
>> >index 82c77994e481..0ca71c135a1a 100644
>> >--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
>> >+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
>> >@@ -382,7 +382,7 @@ static int kcs_bmc_ipmi_release(struct inode *inode, struct file *filp)
>> > 	return 0;
>> > }
>> >
>> >-static const struct file_operations kcs_bmc_fops = {
>> >+static const struct file_operations kcs_bmc_ipmi_fops = {
>> > 	.owner          = THIS_MODULE,
>> > 	.open           = kcs_bmc_ipmi_open,
>> > 	.read           = kcs_bmc_ipmi_read,
>> >@@ -392,36 +392,58 @@ static const struct file_operations kcs_bmc_fops = {
>> > 	.unlocked_ioctl = kcs_bmc_ipmi_ioctl,
>> > };
>> >
>> >-struct kcs_bmc *kcs_bmc_ipmi_alloc(struct device *dev, int sizeof_priv, u32 channel);
>> >-struct kcs_bmc *kcs_bmc_ipmi_alloc(struct device *dev, int sizeof_priv, u32 channel)
>> >+int kcs_bmc_ipmi_attach_cdev(struct kcs_bmc *kcs_bmc);
>>
>> Errant declaration again?
>
>As previously explained.
>

This one seems like a slightly different category, because...

>>
>> >+int kcs_bmc_ipmi_attach_cdev(struct kcs_bmc *kcs_bmc)

...it's immediately followed by the definition of the very same function
that it just declared, so I can't see how its presence or absence could
make any functional difference to anything.  (So perhaps I should have
said "redundant" instead of "errant...again".)

It's fairly trivial of course given that it's gone by the end of the
series, but as long as there's going to be another iteration anyway it
seems like we might as well tidy it up?

>> > {
>> >-	struct kcs_bmc *kcs_bmc;
>> >-
>> >-	kcs_bmc = devm_kzalloc(dev, sizeof(*kcs_bmc) + sizeof_priv, GFP_KERNEL);
>> >-	if (!kcs_bmc)
>> >-		return NULL;
>> >+	int rc;
>> >
>> > 	spin_lock_init(&kcs_bmc->lock);
>> >-	kcs_bmc->channel = channel;
>> >-
>> > 	mutex_init(&kcs_bmc->mutex);
>> > 	init_waitqueue_head(&kcs_bmc->queue);
>> >
>> >-	kcs_bmc->data_in = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>> >-	kcs_bmc->data_out = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>> >-	kcs_bmc->kbuffer = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>> >+	kcs_bmc->data_in = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>> >+	kcs_bmc->data_out = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>> >+	kcs_bmc->kbuffer = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>> >
>> > 	kcs_bmc->miscdev.minor = MISC_DYNAMIC_MINOR;
>> >-	kcs_bmc->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s%u",
>> >-					       DEVICE_NAME, channel);
>> >+	kcs_bmc->miscdev.name = devm_kasprintf(kcs_bmc->dev, GFP_KERNEL, "%s%u",
>> >+					       DEVICE_NAME, kcs_bmc->channel);
>> > 	if (!kcs_bmc->data_in || !kcs_bmc->data_out || !kcs_bmc->kbuffer ||
>> > 	    !kcs_bmc->miscdev.name)
>> >-		return NULL;
>> >-	kcs_bmc->miscdev.fops = &kcs_bmc_fops;
>> >+		return -ENOMEM;
>> >
>> >-	return kcs_bmc;
>> >+	kcs_bmc->miscdev.fops = &kcs_bmc_ipmi_fops;
>> >+
>> >+	rc = misc_register(&kcs_bmc->miscdev);
>> >+	if (rc) {
>> >+		dev_err(kcs_bmc->dev, "Unable to register device: %d\n", rc);
>> >+		return rc;
>> >+	}
>> >+
>> >+	dev_info(kcs_bmc->dev, "Initialised IPMI client for channel %d", kcs_bmc->channel);
>> >+
>> >+	return 0;
>> >+}
>> >+EXPORT_SYMBOL(kcs_bmc_ipmi_attach_cdev);
>> >+
>> >+int kcs_bmc_ipmi_detach_cdev(struct kcs_bmc *kcs_bmc);
>>
>> Same here.
>
>Same explanation.
>

Also a "category 2" I think.

>>
>> >+int kcs_bmc_ipmi_detach_cdev(struct kcs_bmc *kcs_bmc)
>> >+{
>> >+	misc_deregister(&kcs_bmc->miscdev);
>> >+
>> >+	spin_lock_irq(&kcs_bmc->lock);
>> >+	kcs_bmc->running = 0;
>> >+	kcs_bmc_ipmi_force_abort(kcs_bmc);
>> >+	spin_unlock_irq(&kcs_bmc->lock);
>> >+
>> >+	devm_kfree(kcs_bmc->dev, kcs_bmc->kbuffer);
>> >+	devm_kfree(kcs_bmc->dev, kcs_bmc->data_out);
>> >+	devm_kfree(kcs_bmc->dev, kcs_bmc->data_in);
>> >+	devm_kfree(kcs_bmc->dev, kcs_bmc);
>> >+
>> >+	return 0;
>> > }
>> >-EXPORT_SYMBOL(kcs_bmc_ipmi_alloc);
>> >+EXPORT_SYMBOL(kcs_bmc_ipmi_detach_cdev);
>> >
>> > MODULE_LICENSE("GPL v2");
>> > MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
>> >diff --git a/drivers/char/ipmi/kcs_bmc_npcm7xx.c b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
>> >index 1f44aadec9e8..5d017498dc69 100644
>> >--- a/drivers/char/ipmi/kcs_bmc_npcm7xx.c
>> >+++ b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
>> >@@ -65,6 +65,8 @@ struct npcm7xx_kcs_reg {
>> > };
>> >
>> > struct npcm7xx_kcs_bmc {
>> >+	struct kcs_bmc kcs_bmc;
>> >+
>> > 	struct regmap *map;
>> >
>> > 	const struct npcm7xx_kcs_reg *reg;
>> >@@ -76,9 +78,14 @@ static const struct npcm7xx_kcs_reg npcm7xx_kcs_reg_tbl[KCS_CHANNEL_MAX] = {
>> > 	{ .sts = KCS3ST, .dob = KCS3DO, .dib = KCS3DI, .ctl = KCS3CTL, .ie = KCS3IE },
>> > };
>> >
>> >+static inline struct npcm7xx_kcs_bmc *to_npcm7xx_kcs_bmc(struct kcs_bmc *kcs_bmc)
>> >+{
>> >+	return container_of(kcs_bmc, struct npcm7xx_kcs_bmc, kcs_bmc);
>> >+}
>> >+
>> > static u8 npcm7xx_kcs_inb(struct kcs_bmc *kcs_bmc, u32 reg)
>> > {
>> >-	struct npcm7xx_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
>> >+	struct npcm7xx_kcs_bmc *priv = to_npcm7xx_kcs_bmc(kcs_bmc);
>> > 	u32 val = 0;
>> > 	int rc;
>> >
>> >@@ -90,7 +97,7 @@ static u8 npcm7xx_kcs_inb(struct kcs_bmc *kcs_bmc, u32 reg)
>> >
>> > static void npcm7xx_kcs_outb(struct kcs_bmc *kcs_bmc, u32 reg, u8 data)
>> > {
>> >-	struct npcm7xx_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
>> >+	struct npcm7xx_kcs_bmc *priv = to_npcm7xx_kcs_bmc(kcs_bmc);
>> > 	int rc;
>> >
>> > 	rc = regmap_write(priv->map, reg, data);
>> >@@ -99,7 +106,7 @@ static void npcm7xx_kcs_outb(struct kcs_bmc *kcs_bmc, u32 reg, u8 data)
>> >
>> > static void npcm7xx_kcs_updateb(struct kcs_bmc *kcs_bmc, u32 reg, u8 mask, u8 data)
>> > {
>> >-	struct npcm7xx_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
>> >+	struct npcm7xx_kcs_bmc *priv = to_npcm7xx_kcs_bmc(kcs_bmc);
>> > 	int rc;
>> >
>> > 	rc = regmap_update_bits(priv->map, reg, mask, data);
>> >@@ -108,7 +115,7 @@ static void npcm7xx_kcs_updateb(struct kcs_bmc *kcs_bmc, u32 reg, u8 mask, u8 da
>> >
>> > static void npcm7xx_kcs_enable_channel(struct kcs_bmc *kcs_bmc, bool enable)
>> > {
>> >-	struct npcm7xx_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
>> >+	struct npcm7xx_kcs_bmc *priv = to_npcm7xx_kcs_bmc(kcs_bmc);
>> >
>> > 	regmap_update_bits(priv->map, priv->reg->ctl, KCS_CTL_IBFIE,
>> > 			   enable ? KCS_CTL_IBFIE : 0);
>> >@@ -155,11 +162,10 @@ static int npcm7xx_kcs_probe(struct platform_device *pdev)
>> > 		return -ENODEV;
>> > 	}
>> >
>> >-	kcs_bmc = kcs_bmc_alloc(dev, sizeof(*priv), chan);
>> >-	if (!kcs_bmc)
>> >+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> >+	if (!priv)
>> > 		return -ENOMEM;
>> >
>> >-	priv = kcs_bmc_priv(kcs_bmc);
>> > 	priv->map = syscon_node_to_regmap(dev->parent->of_node);
>> > 	if (IS_ERR(priv->map)) {
>> > 		dev_err(dev, "Couldn't get regmap\n");
>> >@@ -167,6 +173,9 @@ static int npcm7xx_kcs_probe(struct platform_device *pdev)
>> > 	}
>> > 	priv->reg = &npcm7xx_kcs_reg_tbl[chan - 1];
>> >
>> >+	kcs_bmc = &priv->kcs_bmc;
>> >+	kcs_bmc->dev = &pdev->dev;
>> >+	kcs_bmc->channel = chan;
>> > 	kcs_bmc->ioreg.idr = priv->reg->dib;
>> > 	kcs_bmc->ioreg.odr = priv->reg->dob;
>> > 	kcs_bmc->ioreg.str = priv->reg->sts;
>> >@@ -174,31 +183,27 @@ static int npcm7xx_kcs_probe(struct platform_device *pdev)
>> > 	kcs_bmc->io_outputb = npcm7xx_kcs_outb;
>> > 	kcs_bmc->io_updateb = npcm7xx_kcs_updateb;
>> >
>> >-	dev_set_drvdata(dev, kcs_bmc);
>> >+	platform_set_drvdata(pdev, priv);
>> >
>> > 	npcm7xx_kcs_enable_channel(kcs_bmc, true);
>> > 	rc = npcm7xx_kcs_config_irq(kcs_bmc, pdev);
>> > 	if (rc)
>> > 		return rc;
>> >
>> >-	rc = misc_register(&kcs_bmc->miscdev);
>> >-	if (rc) {
>> >-		dev_err(dev, "Unable to register device\n");
>> >-		return rc;
>> >-	}
>> >
>> > 	pr_info("channel=%u idr=0x%x odr=0x%x str=0x%x\n",
>> > 		chan,
>> > 		kcs_bmc->ioreg.idr, kcs_bmc->ioreg.odr, kcs_bmc->ioreg.str);
>> >
>> >-	return 0;
>> >+	return kcs_bmc_add_device(kcs_bmc);
>> > }
>> >
>> > static int npcm7xx_kcs_remove(struct platform_device *pdev)
>> > {
>> >-	struct kcs_bmc *kcs_bmc = dev_get_drvdata(&pdev->dev);
>> >+	struct npcm7xx_kcs_bmc *priv = platform_get_drvdata(pdev);
>> >+	struct kcs_bmc *kcs_bmc = &priv->kcs_bmc;
>> >
>> >-	misc_deregister(&kcs_bmc->miscdev);
>> >+	kcs_bmc_remove_device(kcs_bmc);
>>
>> As with the corresponding aspeed code, should we propagate the return
>> value here?
>
>I'll address this.
>
>Thanks for the review!
>
>Andrew
