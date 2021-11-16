From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Tue, 16 Nov 2021 07:18:12 +0000
Subject: [PATCH 3/4] drm/aspeed: Update INTR_STS handling
In-Reply-To: <CACPK8XembQc9vMZbschzC6NuXftcXAuzZbLw1ic==iXkK8c-PA@mail.gmail.com>
References: <20211101110107.29010-1-tommy_huang@aspeedtech.com>
 <20211101110107.29010-4-tommy_huang@aspeedtech.com>
 <CACPK8XembQc9vMZbschzC6NuXftcXAuzZbLw1ic==iXkK8c-PA@mail.gmail.com>
Message-ID: <HK2PR0601MB2033FCE058EDF32DC283372BE1999@HK2PR0601MB2033.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

	Thanks for your comment.
	I will modify the patch and send it again.

> -----Original Message-----
> From: Joel Stanley <joel@jms.id.au>
> Sent: Tuesday, November 16, 2021 2:19 PM
> To: Tommy Huang <tommy_huang@aspeedtech.com>
> Cc: David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Rob
> Herring <robh+dt@kernel.org>; Andrew Jeffery <andrew@aj.id.au>;
> linux-aspeed <linux-aspeed@lists.ozlabs.org>; open list:DRM DRIVERS
> <dri-devel@lists.freedesktop.org>; devicetree <devicetree@vger.kernel.org>;
> Linux ARM <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH 3/4] drm/aspeed: Update INTR_STS handling
> 
> On Mon, 1 Nov 2021 at 11:01, tommy-huang
> <tommy_huang@aspeedtech.com> wrote:
> >
> >     The V-sync INTR_STS is differnet on AST2600.
> >     Change into general rule to handle it.
> >
> > Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
> > ---
> >  drivers/gpu/drm/aspeed/aspeed_gfx.h     |  2 ++
> >  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 26
> > ++++++++++++++++++++++---
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > index 96501152bafa..5eed9275bce7 100644
> > --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > @@ -12,6 +12,8 @@ struct aspeed_gfx {
> >         struct regmap                   *scu;
> >
> >         u32                             dac_reg;
> > +       u32                             int_reg;
> > +       u32                             int_clr_reg;
> >         u32                             vga_scratch_reg;
> >         u32                             throd_val;
> >         u32                             scan_line_max;
> > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > index b53fee6f1c17..1092060cb59c 100644
> > --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > @@ -60,6 +60,8 @@
> >
> >  struct aspeed_gfx_config {
> >         u32 dac_reg;            /* DAC register in SCU */
> > +       u32 int_status_reg;     /* Interrupt status register */
> 
> This is the same for all supported chips; do you need to introduce the variable
> for it?
> 
> > +       u32 int_clear_reg;      /* Interrupt clear register */
> >         u32 vga_scratch_reg;    /* VGA scratch register in SCU */
> >         u32 throd_val;          /* Default Threshold Seting */
> >         u32 scan_line_max;      /* Max memory size of one scan line */
> > @@ -67,6 +69,8 @@ struct aspeed_gfx_config {
> >
> >  static const struct aspeed_gfx_config ast2400_config = {
> >         .dac_reg = 0x2c,
> > +       .int_status_reg = 0x60,
> > +       .int_clear_reg = 0x60,
> >         .vga_scratch_reg = 0x50,
> >         .throd_val = CRT_THROD_LOW(0x1e) | CRT_THROD_HIGH(0x12),
> >         .scan_line_max = 64,
> > @@ -74,14 +78,26 @@ static const struct aspeed_gfx_config
> > ast2400_config = {
> >
> >  static const struct aspeed_gfx_config ast2500_config = {
> >         .dac_reg = 0x2c,
> > +       .int_status_reg = 0x60,
> > +       .int_clear_reg = 0x60,
> >         .vga_scratch_reg = 0x50,
> >         .throd_val = CRT_THROD_LOW(0x24) | CRT_THROD_HIGH(0x3c),
> >         .scan_line_max = 128,
> >  };
> >
> > +static const struct aspeed_gfx_config ast2600_config = {
> > +       .dac_reg = 0xc0,
> > +       .int_status_reg = 0x60,
> > +       .int_clear_reg = 0x68,
> > +       .vga_scratch_reg = 0x50,
> > +       .throd_val = CRT_THROD_LOW(0x50) | CRT_THROD_HIGH(0x70),
> > +       .scan_line_max = 128,
> > +};
> 
> This patch combines adding the clear_reg functionality with support for the
> 2600. Can you split them out; add int_clear_reg first, and then add support for
> the 2600 in the following patch?
> 
> 
> > +
> >  static const struct of_device_id aspeed_gfx_match[] = {
> >         { .compatible = "aspeed,ast2400-gfx", .data = &ast2400_config },
> >         { .compatible = "aspeed,ast2500-gfx", .data = &ast2500_config
> > },
> > +       { .compatible = "aspeed,ast2600-gfx", .data = &ast2600_config
> > + },
> >         { },
> >  };
> >  MODULE_DEVICE_TABLE(of, aspeed_gfx_match); @@ -113,13 +129,15 @@
> > static irqreturn_t aspeed_gfx_irq_handler(int irq, void *data)  {
> >         struct drm_device *drm = data;
> >         struct aspeed_gfx *priv = to_aspeed_gfx(drm);
> > -       u32 reg;
> > +       u32 reg, clr_reg;
> >
> > -       reg = readl(priv->base + CRT_CTRL1);
> > +       reg = readl(priv->base + priv->int_reg);
> >
> >         if (reg & CRT_CTRL_VERTICAL_INTR_STS) {
> >                 drm_crtc_handle_vblank(&priv->pipe.crtc);
> > -               writel(reg, priv->base + CRT_CTRL1);
> > +               clr_reg = (readl(priv->base + priv->int_clr_reg) |
> > +                       CRT_CTRL_VERTICAL_INTR_STS);
> > +               writel(clr_reg, priv->base + priv->int_clr_reg);
> You do not need to do read-modify-write.
> 
> On the 2500 you're writing back the value you read. On the 2600 all of the bits
> are read only except the INTR_STS bit, which is W1C, so you can use the value
> you read from CRT_CTRL1, so this should be enough:
> 
>  writel(reg, priv->base + priv->int_clr_reg);
> 
> >                 return IRQ_HANDLED;
> >         }
> >
> > @@ -147,6 +165,8 @@ static int aspeed_gfx_load(struct drm_device *drm)
> >         config = match->data;
> >
> >         priv->dac_reg = config->dac_reg;
> > +       priv->int_reg = config->int_status_reg;
> > +       priv->int_clr_reg = config->int_clear_reg;
> >         priv->vga_scratch_reg = config->vga_scratch_reg;
> >         priv->throd_val = config->throd_val;
> >         priv->scan_line_max = config->scan_line_max;
> > --
> > 2.17.1
> >
