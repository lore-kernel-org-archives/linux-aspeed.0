From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 Mar 2023 23:19:59 +0100
Subject: [PATCH 00/22] drm/dma-helper: Add dedicated fbdev emulation
In-Reply-To: <20230301153101.4282-1-tzimmermann@suse.de>
References: <20230301153101.4282-1-tzimmermann@suse.de>
Message-ID: <CACRpkdawSQsNqKJkSSoSw3HmMHyNXFUywxkdszpTC-a_uZA+tQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 1, 2023 at 4:31?PM Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Add fbdev emulation that is optimized for DMA helpers, as used by most
> drivers. It operates directly on GEM DMA buffers in system memory.
> Memory pages are mmap'ed directly to userspace. No implicit shadow
> buffers need to be allocated; as can happen with the generic fbdev
> emulation. Convert drivers that fulfil the requirements.
>
> Tested with fbcon and IGT on vc4.
>
> Future direction: providing a dedicated fbdev emulation for GEM DMA
> helpers will allow us to remove this case from the generic fbdev code.
> The latter can then be simplified.

1) I love your work.

2) Why isn't this DRM driver changed?
drivers/gpu/drm/mcde/mcde_drv.c
AFAICT it also uses GEM buffers in system memory.

3) This one:
drivers/gpu/drm/pl111/pl111_drv.c
is also very similar, but can sometimes use a dedicated
RAM memory for allocations using CMA, does that make
it not a candidate?

They aren't much different in how they work from the TVE200.

Yours,
Linus Walleij
