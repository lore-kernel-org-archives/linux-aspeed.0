From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 28 Apr 2020 19:03:26 +0200
Subject: [PATCH 56/59] drm/aspeed: Use managed drmm_mode_config_cleanup
In-Reply-To: <20200428141221.GM3456981@phenom.ffwll.local>
References: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
 <20200415074034.175360-57-daniel.vetter@ffwll.ch>
 <20200424181002.GL7074@ravnborg.org>
 <20200428141221.GM3456981@phenom.ffwll.local>
Message-ID: <20200428170326.GB27234@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 28, 2020 at 04:12:21PM +0200, Daniel Vetter wrote:
> On Fri, Apr 24, 2020 at 08:10:02PM +0200, Sam Ravnborg wrote:
> > On Wed, Apr 15, 2020 at 09:40:31AM +0200, Daniel Vetter wrote:
> > > Since aspeed doesn't use devm_kzalloc anymore we can use the managed
> > > mode config cleanup.
> > > 
> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > Cc: Joel Stanley <joel@jms.id.au>
> > > Cc: Andrew Jeffery <andrew@aj.id.au>
> > > Cc: linux-aspeed at lists.ozlabs.org
> > > Cc: linux-arm-kernel at lists.infradead.org
> > 
> > Hmm, the helper function makes no sense, maybe embed it?
> > 
> > One Q below. Whith Q addressed:
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > 
> > > ---
> > >  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > > index 6b27242b9ee3..6e464b84a256 100644
> > > --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > > @@ -63,15 +63,15 @@ static const struct drm_mode_config_funcs aspeed_gfx_mode_config_funcs = {
> > >  	.atomic_commit		= drm_atomic_helper_commit,
> > >  };
> > >  
> > > -static void aspeed_gfx_setup_mode_config(struct drm_device *drm)
> > > +static int aspeed_gfx_setup_mode_config(struct drm_device *drm)
> > >  {
> > > -	drm_mode_config_init(drm);
> > > -
> > >  	drm->mode_config.min_width = 0;
> > >  	drm->mode_config.min_height = 0;
> > >  	drm->mode_config.max_width = 800;
> > >  	drm->mode_config.max_height = 600;
> > >  	drm->mode_config.funcs = &aspeed_gfx_mode_config_funcs;
> > > +
> > > +	return drmm_mode_config_init(drm);
> > 
> > I do not see anything that documents that it is OK to init min/max
> > width/heigh not funcs before drmm_mode_config_init() is called.
> > Maybe drmm_mode_config_init() gain an memset(drm->mode_config),
> > and we loose all the assingments from before the call to init().
> > 
> > Also most (all?) other users of drmm_mode_config_init()
> > set them after the call to drmm_mode_config_init().
> > So re-order here and then embed while you are touching the code again.
> 
> Only reason I've done it like this is that it saves a few lines of diff
> compared to other options.
> 
> Wrt calling stuff the wrong way round: We pretty much assume throughout
> that structures are allocated with kzalloc, none of our _init() functions
> in drm have a memset. We'd break the world if we start doing memset() in
> random _init() functions I think.
> 
> Also the main aspeed_gfx_load() function is quite long already, smashing
> more random stuff in there won't help it's readability.
> 
> Anyway I don't care, if you insist I'm happy to repaint this in whatever
> color choice you deem best :-)

From the principle of least suprises, you should at least call init and
then set min_width and friends.
This is easy to do in the helper, so easy to avoid the inlining I
suggested.

	Sam
