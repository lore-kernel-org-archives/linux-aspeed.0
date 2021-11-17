From: Joel Stanley <joel@jms.id.au>
Date: Wed, 17 Nov 2021 04:09:44 +0000
Subject: [PATCH] aspeed-lpc-snoop: add 16-bit POST code support
In-Reply-To: <20210224090620.25419-1-govert.overgaauw@prodrive-technologies.com>
References: <20210224090620.25419-1-govert.overgaauw@prodrive-technologies.com>
Message-ID: <CACPK8XdLMVzRiYsfH9EUfcVcKR_4AyxVHR8qGs1hxYSsJXa41g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Govert,

On Wed, 24 Feb 2021 at 09:07, Govert Overgaauw
<govert.overgaauw@prodrive-technologies.com> wrote:
>
> Intel coffeelake plattform uses a 16-bit POST code format instead of 8-bit. Add
> a third FIFO for storing the combined 16-bit post codes.

Thanks for the patch. It slipped through the cracks. I would like to
merge it if we could get some review and/or testing.

Ryan, Zev, Oskar, Lei: please jump in if you're able to help.

Cheers,

Joel

>
> Signed-off-by: Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 117 +++++++++++++++++---------
>  1 file changed, 79 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 682ba0eb4eba..40d113d253fc 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -58,7 +58,7 @@ struct aspeed_lpc_snoop_model_data {
>         unsigned int has_hicrb_ensnp;
>  };
>
> -struct aspeed_lpc_snoop_channel {
> +struct aspeed_lpc_snoop_fifo {
>         struct kfifo            fifo;
>         wait_queue_head_t       wq;
>         struct miscdevice       miscdev;
> @@ -67,32 +67,39 @@ struct aspeed_lpc_snoop_channel {
>  struct aspeed_lpc_snoop {
>         struct regmap           *regmap;
>         int                     irq;
> -       struct aspeed_lpc_snoop_channel chan[NUM_SNOOP_CHANNELS];
> +       struct aspeed_lpc_snoop_fifo chan[NUM_SNOOP_CHANNELS];
> +
> +       /*
> +        * 16-bit postcodes are combination
> +        * of both channels written to a seperate device file, because
> +        * both bytes have to be added on the same interrupt.
> +        */
> +       struct aspeed_lpc_snoop_fifo combined;
>  };
>
> -static struct aspeed_lpc_snoop_channel *snoop_file_to_chan(struct file *file)
> +static struct aspeed_lpc_snoop_fifo *snoop_file_to_fifo(struct file *file)
>  {
>         return container_of(file->private_data,
> -                           struct aspeed_lpc_snoop_channel,
> +                           struct aspeed_lpc_snoop_fifo,
>                             miscdev);
>  }
>
>  static ssize_t snoop_file_read(struct file *file, char __user *buffer,
>                                 size_t count, loff_t *ppos)
>  {
> -       struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
> +       struct aspeed_lpc_snoop_fifo *fifo = snoop_file_to_fifo(file);
>         unsigned int copied;
>         int ret = 0;
>
> -       if (kfifo_is_empty(&chan->fifo)) {
> +       if (kfifo_is_empty(&fifo->fifo)) {
>                 if (file->f_flags & O_NONBLOCK)
>                         return -EAGAIN;
> -               ret = wait_event_interruptible(chan->wq,
> -                               !kfifo_is_empty(&chan->fifo));
> +               ret = wait_event_interruptible(fifo->wq,
> +                               !kfifo_is_empty(&fifo->fifo));
>                 if (ret == -ERESTARTSYS)
>                         return -EINTR;
>         }
> -       ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
> +       ret = kfifo_to_user(&fifo->fifo, buffer, count, &copied);
>
>         return ret ? ret : copied;
>  }
> @@ -100,10 +107,10 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
>  static __poll_t snoop_file_poll(struct file *file,
>                                     struct poll_table_struct *pt)
>  {
> -       struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
> +       struct aspeed_lpc_snoop_fifo *fifo = snoop_file_to_fifo(file);
>
> -       poll_wait(file, &chan->wq, pt);
> -       return !kfifo_is_empty(&chan->fifo) ? EPOLLIN : 0;
> +       poll_wait(file, &fifo->wq, pt);
> +       return !kfifo_is_empty(&fifo->fifo) ? EPOLLIN : 0;
>  }
>
>  static const struct file_operations snoop_fops = {
> @@ -113,21 +120,22 @@ static const struct file_operations snoop_fops = {
>         .llseek = noop_llseek,
>  };
>
> -/* Save a byte to a FIFO and discard the oldest byte if FIFO is full */
> -static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel *chan, u8 val)
> +/* Save data to a FIFO and discard the oldest byte if FIFO is full */
> +static void put_fifo_with_discard(struct aspeed_lpc_snoop_fifo *fifo, size_t len, u8 *buf)
>  {
> -       if (!kfifo_initialized(&chan->fifo))
> +       if (!kfifo_initialized(&fifo->fifo))
>                 return;
> -       if (kfifo_is_full(&chan->fifo))
> -               kfifo_skip(&chan->fifo);
> -       kfifo_put(&chan->fifo, val);
> -       wake_up_interruptible(&chan->wq);
> +       if (kfifo_is_full(&fifo->fifo))
> +               kfifo_skip(&fifo->fifo);
> +       kfifo_in(&fifo->fifo, buf, len);
> +       wake_up_interruptible(&fifo->wq);
>  }
>
>  static irqreturn_t aspeed_lpc_snoop_irq(int irq, void *arg)
>  {
>         struct aspeed_lpc_snoop *lpc_snoop = arg;
>         u32 reg, data;
> +       u16 postval = 0;
>
>         if (regmap_read(lpc_snoop->regmap, HICR6, &reg))
>                 return IRQ_NONE;
> @@ -140,20 +148,25 @@ static irqreturn_t aspeed_lpc_snoop_irq(int irq, void *arg)
>         /* Ack pending IRQs */
>         regmap_write(lpc_snoop->regmap, HICR6, reg);
>
> -       /* Read and save most recent snoop'ed data byte to FIFO */
> +       /* Read and save most recent snoop'ed data byte(s) to FIFO */
>         regmap_read(lpc_snoop->regmap, SNPWDR, &data);
>
>         if (reg & HICR6_STR_SNP0W) {
>                 u8 val = (data & SNPWDR_CH0_MASK) >> SNPWDR_CH0_SHIFT;
>
> -               put_fifo_with_discard(&lpc_snoop->chan[0], val);
> +               put_fifo_with_discard(&lpc_snoop->chan[0], sizeof(val), &val);
> +               postval |= val;
>         }
>         if (reg & HICR6_STR_SNP1W) {
>                 u8 val = (data & SNPWDR_CH1_MASK) >> SNPWDR_CH1_SHIFT;
>
> -               put_fifo_with_discard(&lpc_snoop->chan[1], val);
> +               put_fifo_with_discard(&lpc_snoop->chan[1], sizeof(val), &val);
> +               postval |= (val << 8);
>         }
>
> +       if (postval)
> +               put_fifo_with_discard(&lpc_snoop->combined, sizeof(postval), (u8 *)&postval);
> +
>         return IRQ_HANDLED;
>  }
>
> @@ -179,6 +192,34 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
>         return 0;
>  }
>
> +static int aspeed_lpc_create_fifo_chardev(struct aspeed_lpc_snoop_fifo *fifo,
> +       struct device *dev, int devnum)
> +{
> +       int rc = 0;
> +
> +       init_waitqueue_head(&fifo->wq);
> +       /* Create FIFO datastructure */
> +       rc = kfifo_alloc(&fifo->fifo,
> +                        SNOOP_FIFO_SIZE, GFP_KERNEL);
> +       if (rc)
> +               return rc;
> +
> +       fifo->miscdev.minor = MISC_DYNAMIC_MINOR;
> +       fifo->miscdev.name =
> +               devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, devnum);
> +       fifo->miscdev.fops = &snoop_fops;
> +       fifo->miscdev.parent = dev;
> +
> +       return misc_register(&fifo->miscdev);
> +}
> +
> +static void aspeed_lpc_destroy_fifo_chardev(struct aspeed_lpc_snoop_fifo *fifo)
> +{
> +
> +       kfifo_free(&fifo->fifo);
> +       misc_deregister(&fifo->miscdev);
> +}
> +
>  static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>                                    struct device *dev,
>                                    int channel, u16 lpc_port)
> @@ -188,19 +229,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>         const struct aspeed_lpc_snoop_model_data *model_data =
>                 of_device_get_match_data(dev);
>
> -       init_waitqueue_head(&lpc_snoop->chan[channel].wq);
> -       /* Create FIFO datastructure */
> -       rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
> -                        SNOOP_FIFO_SIZE, GFP_KERNEL);
> -       if (rc)
> -               return rc;
> -
> -       lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
> -       lpc_snoop->chan[channel].miscdev.name =
> -               devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
> -       lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
> -       lpc_snoop->chan[channel].miscdev.parent = dev;
> -       rc = misc_register(&lpc_snoop->chan[channel].miscdev);
> +       rc = aspeed_lpc_create_fifo_chardev(&lpc_snoop->chan[channel],
> +               dev, channel);
>         if (rc)
>                 return rc;
>
> @@ -250,8 +280,7 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>                 return;
>         }
>
> -       kfifo_free(&lpc_snoop->chan[channel].fifo);
> -       misc_deregister(&lpc_snoop->chan[channel].miscdev);
> +       aspeed_lpc_destroy_fifo_chardev(&lpc_snoop->chan[channel]);
>  }
>
>  static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
> @@ -295,9 +324,18 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
>                                        1, &port) == 0) {
>                 rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, 1, port);
>                 if (rc)
> -                       aspeed_lpc_disable_snoop(lpc_snoop, 0);
> +                       goto err_port1;
> +
> +               rc = aspeed_lpc_create_fifo_chardev(&lpc_snoop->combined, dev, 2);
> +               if (rc)
> +                       goto err_combined;
>         }
>
> +       return rc;
> +err_combined:
> +       aspeed_lpc_disable_snoop(lpc_snoop, 1);
> +err_port1:
> +       aspeed_lpc_disable_snoop(lpc_snoop, 0);
>         return rc;
>  }
>
> @@ -309,6 +347,9 @@ static int aspeed_lpc_snoop_remove(struct platform_device *pdev)
>         aspeed_lpc_disable_snoop(lpc_snoop, 0);
>         aspeed_lpc_disable_snoop(lpc_snoop, 1);
>
> +       /* disable combined fifo device */
> +       aspeed_lpc_destroy_fifo_chardev(&lpc_snoop->combined);
> +
>         return 0;
>  }
>
> --
> 2.20.1
>
