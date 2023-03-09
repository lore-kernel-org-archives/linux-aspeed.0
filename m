From: Javier Martinez Canillas <javierm@redhat.com>
Date: Thu, 09 Mar 2023 12:26:53 +0100
Subject: [PATCH 16/22] drm/sun4i: Use GEM DMA fbdev emulation
In-Reply-To: <20230301153101.4282-17-tzimmermann@suse.de>
References: <20230301153101.4282-1-tzimmermann@suse.de>
 <20230301153101.4282-17-tzimmermann@suse.de>
Message-ID: <87mt4m6u82.fsf@minerva.mail-host-address-is-not-set>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the fbdev emulation that is optimized for DMA helpers. Avoids
> possible shadow buffering and makes the code simpler.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

