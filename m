From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 7 Mar 2023 09:55:29 +0100
Subject: [PATCH 00/22] drm/dma-helper: Add dedicated fbdev emulation
In-Reply-To: <CACRpkdawSQsNqKJkSSoSw3HmMHyNXFUywxkdszpTC-a_uZA+tQ@mail.gmail.com>
References: <20230301153101.4282-1-tzimmermann@suse.de>
 <CACRpkdawSQsNqKJkSSoSw3HmMHyNXFUywxkdszpTC-a_uZA+tQ@mail.gmail.com>
Message-ID: <0e789778-03ca-e3cb-9c94-e8b55573894c@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Am 06.03.23 um 23:19 schrieb Linus Walleij:
> On Wed, Mar 1, 2023 at 4:31?PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> 
>> Add fbdev emulation that is optimized for DMA helpers, as used by most
>> drivers. It operates directly on GEM DMA buffers in system memory.
>> Memory pages are mmap'ed directly to userspace. No implicit shadow
>> buffers need to be allocated; as can happen with the generic fbdev
>> emulation. Convert drivers that fulfil the requirements.
>>
>> Tested with fbcon and IGT on vc4.
>>
>> Future direction: providing a dedicated fbdev emulation for GEM DMA
>> helpers will allow us to remove this case from the generic fbdev code.
>> The latter can then be simplified.
> 
> 1) I love your work.

Thank you. :)

> 
> 2) Why isn't this DRM driver changed?
> drivers/gpu/drm/mcde/mcde_drv.c
> AFAICT it also uses GEM buffers in system memory.

This driver requires damage handling

 
https://elixir.bootlin.com/linux/v6.2/source/drivers/gpu/drm/mcde/mcde_drv.c#L97

for which we have to call the framebuffer's dirty callback

 
https://elixir.bootlin.com/linux/v6.2/source/drivers/gpu/drm/drm_gem_framebuffer_helper.c#L285

after each write.

Doing this with fbdev emulation requires tracking of mmap'ed pages via 
fbdev's deferred-I/O mechanisms. That makes the fbdev-emulation code 
more complex. AFAICT, the existing generic fbdev emulation already 
implements this case 'good enough.'

> 
> 3) This one:
> drivers/gpu/drm/pl111/pl111_drv.c
> is also very similar, but can sometimes use a dedicated
> RAM memory for allocations using CMA, does that make
> it not a candidate?

Thanks, I think I simply missed pl111.

Best regards
Thomas

> 
> They aren't much different in how they work from the TVE200.
> 
> Yours,
> Linus Walleij

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N?rnberg, Germany
(HRB 36809, AG N?rnberg)
Gesch?ftsf?hrer: Ivo Totev
-------------- next part --------------
A non-text attachment was scrubbed...
Name: OpenPGP_signature
Type: application/pgp-signature
Size: 840 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230307/f4147fe7/attachment.sig>
