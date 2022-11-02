From: Javier Martinez Canillas <javierm@redhat.com>
Date: Wed, 2 Nov 2022 10:40:15 +0100
Subject: [PATCH v2 19/21] drm/fb-helper: Always initialize generic fbdev
 emulation
In-Reply-To: <20221024111953.24307-20-tzimmermann@suse.de>
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-20-tzimmermann@suse.de>
Message-ID: <7ac0da2c-0a43-4c02-4199-f48a50347171@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/24/22 13:19, Thomas Zimmermann wrote:
> Initialize the generic fbdev emulation even if it has been disabled
> on the kernel command line. The hotplug and mode initialization will
> fail accordingly.
> 
> The kernel parameter can still be changed at runtime and the emulation
> will initialize after hotplugging the connector.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

