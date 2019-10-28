From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Mon, 28 Oct 2019 11:30:06 -0500
Subject: [PATCH] media: aspeed-video: Fix memory leaks in
 aspeed_video_probe
In-Reply-To: <d9c04318-586a-bfc2-fce6-6218c6bab1d6@linux.intel.com>
References: <20191026042519.29446-1-navid.emamdoost@gmail.com>
 <d9c04318-586a-bfc2-fce6-6218c6bab1d6@linux.intel.com>
Message-ID: <CAEkB2EQXmHJoMJJJULHHFy4gp6a=QiCe5SoxkWehnpKWNVw=_A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 28, 2019 at 11:27 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> Hi Navid,
>
> On 10/25/2019 9:25 PM, Navid Emamdoost wrote:
> > In the implementation of aspeed_video_probe() the allocated memory for
> > video should be released in case of failure. Release video if either
> > devm_ioremap_resource() or aspeed_video_init() or
> > aspeed_video_setup_video() fails.
> >
> > Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >   drivers/media/platform/aspeed-video.c | 14 ++++++++++----
> >   1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> > index eb12f3793062..8c473356132d 100644
> > --- a/drivers/media/platform/aspeed-video.c
> > +++ b/drivers/media/platform/aspeed-video.c
> > @@ -1663,18 +1663,24 @@ static int aspeed_video_probe(struct platform_device *pdev)
> >
> >       video->base = devm_ioremap_resource(video->dev, res);
> >
> > -     if (IS_ERR(video->base))
> > -             return PTR_ERR(video->base);
> > +     if (IS_ERR(video->base)) {
> > +             rc = PTR_ERR(video->base);
> > +             goto free_video;
> > +     }
> >
> >       rc = aspeed_video_init(video);
> >       if (rc)
> > -             return rc;
> > +             goto free_video;
> >
> >       rc = aspeed_video_setup_video(video);
> >       if (rc)
> > -             return rc;
> > +             goto free_video;
> >
> >       return 0;
> > +
> > +free_video:
> > +     kfree(video);
> > +     return rc;
> >   }
> >
> >   static int aspeed_video_remove(struct platform_device *pdev)
> >
>
> Can we simply change kzalloc in aspeed_video_probe with devm_kzalloc
> so that we don't need to take care of freeing of video? I think it would
> be more simpler.

Sounds a neat plan, will send v2.

>
> Cheers,
>
> Jae



-- 
Navid.
