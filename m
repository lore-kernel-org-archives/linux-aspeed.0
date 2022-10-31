From: Javier Martinez Canillas <javierm@redhat.com>
Date: Mon, 31 Oct 2022 13:21:48 +0100
Subject: [PATCH v2 09/21] drm/panel-ili9341: Include <linux/backlight.h>
In-Reply-To: <20221024111953.24307-10-tzimmermann@suse.de>
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-10-tzimmermann@suse.de>
Message-ID: <e9192382-f04c-4ebd-ca1c-b2fceaa29f86@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/24/22 13:19, Thomas Zimmermann wrote:
> Include <linux/backlight.h> for devm_of_find_backlight().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

