From: Joel Stanley <joel@jms.id.au>
Date: Thu, 25 Jul 2019 02:52:27 +0000
Subject: [PATCH 03/12] drm: aspeed_gfx: Fix misuse of GENMASK macro
In-Reply-To: <4e5bc8d61436024a30a8fb6a1516e29e23a75ede.camel@perches.com>
References: <cover.1562734889.git.joe@perches.com>
 <cddd7ad7e9f81dec1e86c106f04229d21fc21920.1562734889.git.joe@perches.com>
 <2a0c5ef5c7e20b190156908991e4c964a501d80a.camel@perches.com>
 <4f6709f8-381f-415c-8569-798b074b66c5@www.fastmail.com>
 <4e5bc8d61436024a30a8fb6a1516e29e23a75ede.camel@perches.com>
Message-ID: <CACPK8Xd3+iwkuw-Ofwf+Hy1Ez5-1pBvnk_G4xT72ZQdOVd7Sag@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2019 at 01:18, Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-07-25 at 10:40 +0930, Andrew Jeffery wrote:
> >
> > On Thu, 25 Jul 2019, at 02:46, Joe Perches wrote:
> > > On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> > > > Arguments are supposed to be ordered high then low.
> > > >
> > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > ---
> > > >  drivers/gpu/drm/aspeed/aspeed_gfx.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > index a10358bb61ec..095ea03e5833 100644
> > > > --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > @@ -74,7 +74,7 @@ int aspeed_gfx_create_output(struct drm_device *drm);
> > > >  /* CTRL2 */
> > > >  #define CRT_CTRL_DAC_EN                  BIT(0)
> > > >  #define CRT_CTRL_VBLANK_LINE(x)          (((x) << 20) & CRT_CTRL_VBLANK_LINE_MASK)
> > > > -#define CRT_CTRL_VBLANK_LINE_MASK        GENMASK(20, 31)
> > > > +#define CRT_CTRL_VBLANK_LINE_MASK        GENMASK(31, 20)
> >
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>
> This hardly needs a review, it needs to be applied.
> There's a nominal git tree for aspeed here:
>
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
>
> But who's going to do apply this?

This is a DRM patch, so it goes through the DRM tree. I am a
co-maintainer there and can apply it once I remember how to drive the
tools.

(FYI, this macro is not used by the current driver).

Cheers,

Joel
