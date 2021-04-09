From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Apr 2021 10:24:08 +0300
Subject: [PATCH v5 2/4] drivers/tty/serial/8250: refactor sirq and lpc
 address setting code
In-Reply-To: <20210408011637.5361-3-zev@bewilderbeest.net>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-3-zev@bewilderbeest.net>
Message-ID: <CAHp75Vd6kk0E-kALEGOhsg=YHKhmKLY6cpCTdviOFenO4p1-2A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thursday, April 8, 2021, Zev Weiss <zev@bewilderbeest.net> wrote:

> This splits dedicated aspeed_vuart_set_{sirq,lpc_address}() functions
> out of the sysfs store functions in preparation for adding DT
> properties that will be poking the same registers.  While we're at it,
> these functions now provide some basic bounds-checking on their
> arguments.
>
>

Please, use prefix ?serial: 8250_aspeed_vuart:? instead of what you have in
the subject line. I think I have told this already


> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 51 ++++++++++++++-------
>  1 file changed, 35 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index c33e02cbde93..8433f8dbb186 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -72,22 +72,31 @@ static ssize_t lpc_address_show(struct device *dev,
>         return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
>  }
>
> +static int aspeed_vuart_set_lpc_address(struct aspeed_vuart *vuart, u32
> addr)
> +{
> +       if (addr > U16_MAX)
> +               return -EINVAL;
> +
> +       writeb(addr >> 8, vuart->regs + ASPEED_VUART_ADDRH);
> +       writeb(addr >> 0, vuart->regs + ASPEED_VUART_ADDRL);
> +
> +       return 0;
> +}
> +
>  static ssize_t lpc_address_store(struct device *dev,
>                                  struct device_attribute *attr,
>                                  const char *buf, size_t count)
>  {
>         struct aspeed_vuart *vuart = dev_get_drvdata(dev);
> -       unsigned long val;
> +       u32 val;
>         int err;
>
> -       err = kstrtoul(buf, 0, &val);
> +       err = kstrtou32(buf, 0, &val);
>         if (err)
>                 return err;
>
> -       writeb(val >> 8, vuart->regs + ASPEED_VUART_ADDRH);
> -       writeb(val >> 0, vuart->regs + ASPEED_VUART_ADDRL);
> -
> -       return count;
> +       err = aspeed_vuart_set_lpc_address(vuart, val);
> +       return err ? : count;
>  }
>
>  static DEVICE_ATTR_RW(lpc_address);
> @@ -105,27 +114,37 @@ static ssize_t sirq_show(struct device *dev,
>         return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg);
>  }
>
> +static int aspeed_vuart_set_sirq(struct aspeed_vuart *vuart, u32 sirq)
> +{
> +       u8 reg;
> +
> +       if (sirq > (ASPEED_VUART_GCRB_HOST_SIRQ_MASK >>
> ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT))
> +               return -EINVAL;
> +
> +       sirq <<= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
> +       sirq &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
> +
> +       reg = readb(vuart->regs + ASPEED_VUART_GCRB);
> +       reg &= ~ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
> +       reg |= sirq;
> +       writeb(reg, vuart->regs + ASPEED_VUART_GCRB);
> +
> +       return 0;
> +}
> +
>  static ssize_t sirq_store(struct device *dev, struct device_attribute
> *attr,
>                           const char *buf, size_t count)
>  {
>         struct aspeed_vuart *vuart = dev_get_drvdata(dev);
>         unsigned long val;
>         int err;
> -       u8 reg;
>
>         err = kstrtoul(buf, 0, &val);
>         if (err)
>                 return err;
>
> -       val <<= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
> -       val &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
> -
> -       reg = readb(vuart->regs + ASPEED_VUART_GCRB);
> -       reg &= ~ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
> -       reg |= val;
> -       writeb(reg, vuart->regs + ASPEED_VUART_GCRB);
> -
> -       return count;
> +       err = aspeed_vuart_set_sirq(vuart, val);
> +       return err ? : count;
>  }
>
>  static DEVICE_ATTR_RW(sirq);
> --
> 2.31.1
>
>

-- 
With Best Regards,
Andy Shevchenko
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210409/2ee011bb/attachment.htm>
