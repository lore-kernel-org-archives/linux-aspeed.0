From: Javier Martinez Canillas <javierm@redhat.com>
Date: Mon, 31 Oct 2022 12:59:34 +0100
Subject: [PATCH v2 02/21] drm/mcde: Don't set struct drm_driver.lastclose
In-Reply-To: <20221024111953.24307-3-tzimmermann@suse.de>
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-3-tzimmermann@suse.de>
Message-ID: <ae69e0c5-05ee-f0ef-a333-53bbaff5c3e8@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/24/22 13:19, Thomas Zimmermann wrote:
> Don't set struct drm_driver.lastclose. It's used to restore the
> fbdev console. But as mcde uses generic fbdev emulation, the
> console is being restored by the DRM client helpers already. See
> the call to drm_client_dev_restore() in drm_lastclose().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

