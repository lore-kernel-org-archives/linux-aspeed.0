From: Javier Martinez Canillas <javierm@redhat.com>
Date: Wed, 2 Nov 2022 11:02:28 +0100
Subject: [PATCH v2 21/21] drm/fb-helper: Remove unnecessary include
 statements
In-Reply-To: <20221024111953.24307-22-tzimmermann@suse.de>
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-22-tzimmermann@suse.de>
Message-ID: <68309442-ad39-36da-b1ec-680dd4129a7f@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/24/22 13:19, Thomas Zimmermann wrote:
> Remove include statements for <drm/drm_fb_helper.h> where it is not
> required (i.e., most of them). In a few places include other header
> files that are required by the source code.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

