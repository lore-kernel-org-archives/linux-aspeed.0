From: Joel Stanley <joel@jms.id.au>
Date: Mon, 10 Jan 2022 23:29:30 +0000
Subject: [PATCH 3/3] ARM: aspeed: Add secure boot controller support
In-Reply-To: <20211117035106.321454-4-joel@jms.id.au>
References: <20211117035106.321454-1-joel@jms.id.au>
 <20211117035106.321454-4-joel@jms.id.au>
Message-ID: <CACPK8XcSPiOoJZ4jyJySvCiW+EXxSVsxiEcK2eOZjGY9b1vrjA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Arnd,

On Wed, 17 Nov 2021 at 03:51, Joel Stanley <joel@jms.id.au> wrote:
>
> This reads out the status of the secure boot controller and exposes it
> in sysfs.
>
> An example on a AST2600A3 QEMU model:
>
>  # grep . /sys/bus/soc/devices/soc0/*
>  /sys/bus/soc/devices/soc0/abr_image:0
>  /sys/bus/soc/devices/soc0/family:AST2600
>  /sys/bus/soc/devices/soc0/low_security_key:0
>  /sys/bus/soc/devices/soc0/machine:Rainier 2U
>  /sys/bus/soc/devices/soc0/otp_protected:0
>  /sys/bus/soc/devices/soc0/revision:A3
>  /sys/bus/soc/devices/soc0/secure_boot:1
>  /sys/bus/soc/devices/soc0/serial_number:888844441234abcd
>  /sys/bus/soc/devices/soc0/soc_id:05030303
>  /sys/bus/soc/devices/soc0/uart_boot:1

Quoting from your response to my pull request:

> - I actually want to avoid custom attributes on soc device instances as much
>   as possible. I have not looked in detail at what you add here, but the
>   number of custom attributes means we should discuss this properly.

Can you explain the reasoning here?

I am a bit surprised given we have this nice feature in struct
soc_device_attribute:

struct soc_device_attribute {
...
        const struct attribute_group *custom_attr_group;
};

Cheers,

Joel


>
> On boot the state of the system according to the secure boot controller
> will be printed:
>
>  [    0.037634] AST2600 secure boot enabled
>
> or
>
>  [    0.037935] AST2600 secure boot disabled
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/soc/aspeed/aspeed-socinfo.c | 73 +++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
> index 1ca140356a08..6faf2c199c90 100644
> --- a/drivers/soc/aspeed/aspeed-socinfo.c
> +++ b/drivers/soc/aspeed/aspeed-socinfo.c
> @@ -9,6 +9,8 @@
>  #include <linux/slab.h>
>  #include <linux/sys_soc.h>
>
> +static u32 security_status;
> +
>  static struct {
>         const char *name;
>         const u32 id;
> @@ -74,6 +76,54 @@ static const char *siliconid_to_rev(u32 siliconid)
>         return "??";
>  }
>
> +#define SEC_STATUS             0x14
> +#define ABR_IMAGE_SOURCE       BIT(13)
> +#define OTP_PROTECTED          BIT(8)
> +#define LOW_SEC_KEY            BIT(7)
> +#define SECURE_BOOT            BIT(6)
> +#define UART_BOOT              BIT(5)
> +
> +static ssize_t abr_image_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%d\n", !!(security_status & ABR_IMAGE_SOURCE));
> +}
> +static DEVICE_ATTR_RO(abr_image);
> +
> +static ssize_t low_security_key_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%d\n", !!(security_status & LOW_SEC_KEY));
> +}
> +static DEVICE_ATTR_RO(low_security_key);
> +
> +static ssize_t otp_protected_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%d\n", !!(security_status & OTP_PROTECTED));
> +}
> +static DEVICE_ATTR_RO(otp_protected);
> +
> +static ssize_t secure_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%d\n", !!(security_status & SECURE_BOOT));
> +}
> +static DEVICE_ATTR_RO(secure_boot);
> +
> +static ssize_t uart_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       /* Invert the bit, as 1 is boot from SPI/eMMC */
> +       return sprintf(buf, "%d\n", !(security_status & UART_BOOT));
> +}
> +static DEVICE_ATTR_RO(uart_boot);
> +
> +static struct attribute *aspeed_attrs[] = {
> +       &dev_attr_abr_image.attr,
> +       &dev_attr_low_security_key.attr,
> +       &dev_attr_otp_protected.attr,
> +       &dev_attr_secure_boot.attr,
> +       &dev_attr_uart_boot.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(aspeed);
> +
>  static int __init aspeed_socinfo_init(void)
>  {
>         struct soc_device_attribute *attrs;
> @@ -81,6 +131,7 @@ static int __init aspeed_socinfo_init(void)
>         struct device_node *np;
>         void __iomem *reg;
>         bool has_chipid = false;
> +       bool has_sbe = false;
>         u32 siliconid;
>         u32 chipid[2];
>         const char *machine = NULL;
> @@ -109,6 +160,20 @@ static int __init aspeed_socinfo_init(void)
>         }
>         of_node_put(np);
>
> +       /* AST2600 only */
> +       np = of_find_compatible_node(NULL, NULL, "aspeed,ast2600-sbc");
> +       if (of_device_is_available(np)) {
> +               void *base = of_iomap(np, 0);
> +               if (!base) {
> +                       of_node_put(np);
> +                       return -ENODEV;
> +               }
> +               security_status = readl(base + SEC_STATUS);
> +               has_sbe = true;
> +               iounmap(base);
> +               of_node_put(np);
> +       }
> +
>         attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
>         if (!attrs)
>                 return -ENODEV;
> @@ -135,6 +200,9 @@ static int __init aspeed_socinfo_init(void)
>                 attrs->serial_number = kasprintf(GFP_KERNEL, "%08x%08x",
>                                                  chipid[1], chipid[0]);
>
> +       if (has_sbe)
> +               attrs->custom_attr_group = aspeed_groups[0];
> +
>         soc_dev = soc_device_register(attrs);
>         if (IS_ERR(soc_dev)) {
>                 kfree(attrs->soc_id);
> @@ -148,6 +216,11 @@ static int __init aspeed_socinfo_init(void)
>                         attrs->revision,
>                         attrs->soc_id);
>
> +       if (has_sbe) {
> +               pr_info("AST2600 secure boot %s\n",
> +                       (security_status & SECURE_BOOT) ? "enabled" : "disabled");
> +       }
> +
>         return 0;
>  }
>  early_initcall(aspeed_socinfo_init);
> --
> 2.33.0
>
