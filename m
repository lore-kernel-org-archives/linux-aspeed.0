From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Mar 2023 09:17:16 +0100
Subject: [PATCH 00/22] drm/dma-helper: Add dedicated fbdev emulation
In-Reply-To: <0e789778-03ca-e3cb-9c94-e8b55573894c@suse.de>
References: <20230301153101.4282-1-tzimmermann@suse.de> <CACRpkdawSQsNqKJkSSoSw3HmMHyNXFUywxkdszpTC-a_uZA+tQ@mail.gmail.com>
 <0e789778-03ca-e3cb-9c94-e8b55573894c@suse.de>
Message-ID: <CACRpkdYUVBq_-iZxtoe65eh3ruUOprF_JEG-sZfUSNVhjacVLA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 7, 2023 at 9:55?AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 06.03.23 um 23:19 schrieb Linus Walleij:

> > 2) Why isn't this DRM driver changed?
> > drivers/gpu/drm/mcde/mcde_drv.c
> > AFAICT it also uses GEM buffers in system memory.
>
> This driver requires damage handling
> https://elixir.bootlin.com/linux/v6.2/source/drivers/gpu/drm/mcde/mcde_drv.c#L97
>
> for which we have to call the framebuffer's dirty callback

Oh that one is on me ... I no longer remember exactly why I used
drm_gem_fb_create_with_dirty() but I think it was because I had the
ambition that the driver would only send out updates to DSI command
displays whenever something changed, so as to minimize traffic.

It turns out this ambition with command mode isn't working in
practice because all the MCDE does is to create a continuous stream
of DSI commands and while it is possible to send single frame
updates with it, it's not working in practice. So we are just setting
up continuous updates. We turn of the VBLANK IRQs a bit, but I
guess the DRM framework does that for us when nothing goes on.

I tested to replace this with drm_gem_fb_create and it works just
fine. I'll send out a patch so you can make this change also to the
MCDE driver.

Yours,
Linus Walleij
