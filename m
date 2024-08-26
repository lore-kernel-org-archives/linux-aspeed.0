From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Aug 2024 10:37:17 +0200
Subject: [PATCH v1 2/2] gpio: Add G7 Aspeed gpio controller driver
In-Reply-To: <20240821070740.2378602-3-billy_tsai@aspeedtech.com>
References: <20240821070740.2378602-1-billy_tsai@aspeedtech.com> <20240821070740.2378602-3-billy_tsai@aspeedtech.com>
Message-ID: <CACRpkdY-sNVdb+nSG4WLZnkj+7jvQ1D0t0Sn+gvOBgCfzvr2fw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

thanks for your patch!

On Wed, Aug 21, 2024 at 9:07?AM Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> In the 7th generation of the SoC from Aspeed, the control logic of the
> GPIO controller has been updated to support per-pin control. Each pin now
> has its own 32-bit register, allowing for individual control of the pin?s
> value, direction, interrupt type, and other settings.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
(...)

> +static inline u32 field_get(u32 _mask, u32 _val)
> +{
> +       return (((_val) & (_mask)) >> (ffs(_mask) - 1));
> +}
> +
> +static inline u32 field_prep(u32 _mask, u32 _val)
> +{
> +       return (((_val) << (ffs(_mask) - 1)) & (_mask));
> +}

Can't you use FIELD_GET and FIELD_PREP from
<linux/bitfield.h> instead?

> +static inline void ast_write_bits(void __iomem *addr, u32 mask, u32 val)
> +{
> +       iowrite32((ioread32(addr) & ~(mask)) | field_prep(mask, val), addr);
> +}
> +
> +static inline void ast_clr_bits(void __iomem *addr, u32 mask)
> +{
> +       iowrite32((ioread32(addr) & ~(mask)), addr);
> +}

This as a whole looks a bit like a reimplementation of regmap-mmio, can you
look into using that instead?

Yours,
Linus Walleij
