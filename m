From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Tue, 7 Jun 2022 01:30:18 +0000
Subject: [PATCH v1 2/2] drm/aspeed: Add 1024x768 mode for AST2600
In-Reply-To: <SG2PR06MB48187B873F1B0B8FD7A119A5E1FB9@SG2PR06MB4818.apcprd06.prod.outlook.com>
References: <20220304063137.12970-1-tommy_huang@aspeedtech.com>
 <20220304063137.12970-3-tommy_huang@aspeedtech.com>
 <CACPK8XfeRGU4ZySfO8vMf71wy-=PcdetvFAwAE9gaSz-NPK6Fg@mail.gmail.com>
 <SG2PR06MB48187B873F1B0B8FD7A119A5E1FB9@SG2PR06MB4818.apcprd06.prod.outlook.com>
Message-ID: <SG2PR06MB4818ED730BFADDE19DA967D3E1A59@SG2PR06MB4818.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

	We have released related datasheet and update these registers description.

	SCU300: Clock Selection Register
	...
	10:8 Soc display clock selection
	000b: D-PLL
	001b: Reserved
	010b: 40MHz from USB 2.0 port1 PHY
	011b: GPIOC6
	100b: Reserved
	101b: E-PLL divided by SCU308[17:12]
	110b: M-PLL divided by SCU308[17:12]
	111b: H-PLL divided by SCU308[17:12]

	SCU308: Clock Selection Register Set 3
	17:12 Soc display clock divider selection
	000000b: div 1
	011011b: div 16

	Thanks,

	By Tommy

> -----Original Message-----
> From: Tommy Huang
> Sent: Tuesday, April 26, 2022 4:28 PM
> To: Joel Stanley <joel@jms.id.au>
> Cc: David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Rob
> Herring <robh+dt@kernel.org>; Andrew Jeffery <andrew@aj.id.au>;
> linux-aspeed <linux-aspeed@lists.ozlabs.org>; open list:DRM DRIVERS
> <dri-devel@lists.freedesktop.org>; devicetree <devicetree@vger.kernel.org>;
> Linux ARM <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: RE: [PATCH v1 2/2] drm/aspeed: Add 1024x768 mode for AST2600
> 
> 
> 
> > -----Original Message-----
> > From: Joel Stanley <joel@jms.id.au>
> > Sent: Tuesday, April 26, 2022 3:48 PM
> > To: Tommy Huang <tommy_huang@aspeedtech.com>
> > Cc: David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>;
> > Rob Herring <robh+dt@kernel.org>; Andrew Jeffery <andrew@aj.id.au>;
> > linux-aspeed <linux-aspeed@lists.ozlabs.org>; open list:DRM DRIVERS
> > <dri-devel@lists.freedesktop.org>; devicetree
> > <devicetree@vger.kernel.org>; Linux ARM
> > <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; BMC-SW <BMC-SW@aspeedtech.com>
> > Subject: Re: [PATCH v1 2/2] drm/aspeed: Add 1024x768 mode for AST2600
> >
> > On Fri, 4 Mar 2022 at 06:32, Tommy Haung
> <tommy_huang@aspeedtech.com>
> > wrote:
> > >
> > > Update the aspeed_gfx_set_clk with display width.
> > > At AST2600, the display clock could be coming from HPLL clock / 16 =
> > > 75MHz. It would fit 1024x768 at 70Hz.
> > > Another chip will still keep 800x600.
> > >
> > > Signed-off-by: Tommy Haung <tommy_huang@aspeedtech.com>
> > > ---
> > >  drivers/gpu/drm/aspeed/aspeed_gfx.h      | 12 ++++++----
> > >  drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 29
> > > ++++++++++++++++++++----  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> |
> > > 16 +++++++++++--  drivers/gpu/drm/aspeed/aspeed_gfx_out.c  | 14
> > > +++++++++++-
> > >  4 files changed, 60 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > index eb4c267cde5e..c7aefee0657a 100644
> > > --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > @@ -109,11 +109,15 @@ int aspeed_gfx_create_output(struct drm_device
> > *drm);
> > >  #define CRT_THROD_HIGH(x)              ((x) << 8)
> > >
> > >  /* SCU control */
> > > -#define SCU_G6_CLK_COURCE              0x300
> > > +#define G6_CLK_SOURCE                  0x300
> > > +#define G6_CLK_SOURCE_MASK             (BIT(8) | BIT(9) | BIT(10))
> > > +#define G6_CLK_SOURCE_HPLL             (BIT(8) | BIT(9) | BIT(10))
> > > +#define G6_CLK_SOURCE_USB              BIT(9)
> > > +#define G6_CLK_SEL3                    0x308
> > > +#define G6_CLK_DIV_MASK                        0x3F000
> >
> > This register is defined in the data sheet as:
> >
> > 17:12 SOC Display clock selection when source is from DisplayPort PHY
> >
> > That doesn't match with what the code is doing. Can you clarify the
> > register definition?
> 
> OK. I will clarify it and response it to you.
> 
> >
> > > +#define G6_CLK_DIV_16
> > (BIT(16)|BIT(15)|BIT(13)|BIT(12))
> > > +#define G6_USB_40_CLK                  BIT(9)
> > >
> > >  /* GFX FLAGS */
> > >  #define CLK_MASK                       BIT(0)
> > >  #define CLK_G6                         BIT(0)
> > > -
> > > -#define G6_CLK_MASK                    (BIT(8) | BIT(9) | BIT(10))
> > > -#define G6_USB_40_CLK                  BIT(9)
> > > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> > > b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> > > index a24fab22eac4..5829be9c7c67 100644
> > > --- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> > > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> > > @@ -23,6 +23,28 @@ drm_pipe_to_aspeed_gfx(struct
> > drm_simple_display_pipe *pipe)
> > >         return container_of(pipe, struct aspeed_gfx, pipe);  }
> > >
> > > +static void aspeed_gfx_set_clock_source(struct aspeed_gfx *priv,
> > > +int
> > > +mode_width) {
> > > +       regmap_update_bits(priv->scu, G6_CLK_SOURCE,
> > G6_CLK_SOURCE_MASK, 0x0);
> > > +       regmap_update_bits(priv->scu, G6_CLK_SEL3,
> G6_CLK_DIV_MASK,
> > > +0x0);
> > > +
> > > +       switch (mode_width) {
> > > +       case 1024:
> > > +               /* hpll div 16 = 75Mhz */
> > > +               regmap_update_bits(priv->scu, G6_CLK_SOURCE,
> > > +               G6_CLK_SOURCE_MASK, G6_CLK_SOURCE_HPLL);
> > > +               regmap_update_bits(priv->scu, G6_CLK_SEL3,
> > > +               G6_CLK_DIV_MASK, G6_CLK_DIV_16);
> > > +               break;
> > > +       case 800:
> > > +       default:
> > > +               /* usb 40Mhz */
> > > +               regmap_update_bits(priv->scu, G6_CLK_SOURCE,
> > > +               G6_CLK_SOURCE_MASK, G6_CLK_SOURCE_USB);
> > > +               break;
> > > +       }
> > > +}
> > > +
> > >  static int aspeed_gfx_set_pixel_fmt(struct aspeed_gfx *priv, u32
> > > *bpp)  {
> > >         struct drm_crtc *crtc = &priv->pipe.crtc; @@ -77,12 +99,11
> > > @@ static void aspeed_gfx_disable_controller(struct aspeed_gfx *priv)
> > >         regmap_update_bits(priv->scu, priv->dac_reg, BIT(16), 0);  }
> > >
> > > -static void aspeed_gfx_set_clk(struct aspeed_gfx *priv)
> > > +static void aspeed_gfx_set_clk(struct aspeed_gfx *priv, int
> > > +mode_width)
> > >  {
> > >         switch (priv->flags & CLK_MASK) {
> > >         case CLK_G6:
> > > -               regmap_update_bits(priv->scu, SCU_G6_CLK_COURCE,
> > G6_CLK_MASK, 0x0);
> > > -               regmap_update_bits(priv->scu, SCU_G6_CLK_COURCE,
> > G6_CLK_MASK, G6_USB_40_CLK);
> > > +               aspeed_gfx_set_clock_source(priv, mode_width);
> > >                 break;
> > >         default:
> > >                 break;
> > > @@ -99,7 +120,7 @@ static void aspeed_gfx_crtc_mode_set_nofb(struct
> > aspeed_gfx *priv)
> > >         if (err)
> > >                 return;
> > >
> > > -       aspeed_gfx_set_clk(priv);
> > > +       aspeed_gfx_set_clk(priv, m->hdisplay);
> > >
> > >  #if 0
> > >         /* TODO: we have only been able to test with the 40MHz USB
> > > clock. The diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > > b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > > index af56ffdccc65..e1a814aebc2d 100644
> > > --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > > @@ -110,6 +110,7 @@ static const struct drm_mode_config_funcs
> > > aspeed_gfx_mode_config_funcs = {
> > >
> > >  static int aspeed_gfx_setup_mode_config(struct drm_device *drm)  {
> > > +       struct aspeed_gfx *priv = to_aspeed_gfx(drm);
> > >         int ret;
> > >
> > >         ret = drmm_mode_config_init(drm); @@ -118,8 +119,18 @@
> > static
> > > int aspeed_gfx_setup_mode_config(struct drm_device *drm)
> > >
> > >         drm->mode_config.min_width = 0;
> > >         drm->mode_config.min_height = 0;
> > > -       drm->mode_config.max_width = 800;
> > > -       drm->mode_config.max_height = 600;
> > > +
> > > +       switch (priv->flags & CLK_MASK) {
> > > +       case CLK_G6:
> > > +               drm->mode_config.max_width = 1024;
> > > +               drm->mode_config.max_height = 768;
> > > +               break;
> > > +       default:
> > > +               drm->mode_config.max_width = 800;
> > > +               drm->mode_config.max_height = 600;
> > > +               break;
> > > +       }
> > > +
> > >         drm->mode_config.funcs = &aspeed_gfx_mode_config_funcs;
> > >
> > >         return ret;
> > > @@ -167,6 +178,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
> > >         priv->vga_scratch_reg = config->vga_scratch_reg;
> > >         priv->throd_val = config->throd_val;
> > >         priv->scan_line_max = config->scan_line_max;
> > > +       priv->flags = config->gfx_flags;
> > >
> > >         priv->scu = syscon_regmap_lookup_by_phandle(np, "syscon");
> > >         if (IS_ERR(priv->scu)) {
> > > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
> > > b/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
> > > index 6759cb88415a..5d5e04f15c59 100644
> > > --- a/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
> > > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
> > > @@ -10,7 +10,19 @@
> > >
> > >  static int aspeed_gfx_get_modes(struct drm_connector *connector)  {
> > > -       return drm_add_modes_noedid(connector, 800, 600);
> > > +       struct aspeed_gfx *priv = container_of(connector, struct
> > aspeed_gfx, connector);
> > > +       int mode_count = 0;
> > > +
> > > +       switch (priv->flags & CLK_MASK) {
> > > +       case CLK_G6:
> > > +               mode_count = drm_add_modes_noedid(connector,
> 1024,
> > 768);
> > > +               break;
> > > +       default:
> > > +               mode_count = drm_add_modes_noedid(connector,
> 800,
> > 600);
> > > +               break;
> > > +       }
> > > +
> > > +       return mode_count;
> > >  }
> > >
> > >  static const struct
> > > --
> > > 2.17.1
> > >
