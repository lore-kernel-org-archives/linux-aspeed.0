From: Javier Martinez Canillas <javierm@redhat.com>
Date: Fri, 4 Nov 2022 11:37:17 +0100
Subject: [PATCH v3 20/23] drm/fb-helper: Set flag in struct drm_fb_helper
 for leaking physical addresses
In-Reply-To: <20221103151446.2638-21-tzimmermann@suse.de>
References: <20221103151446.2638-1-tzimmermann@suse.de>
 <20221103151446.2638-21-tzimmermann@suse.de>
Message-ID: <ab8358a9-8450-0d49-627f-26afe7ba4f9d@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/3/22 16:14, Thomas Zimmermann wrote:
> Uncouple the parameter drm_leak_fbdev_smem from the implementation by
> setting a flag in struct drm_fb_helper. This will help to move the
> generic fbdev emulation into its own source file, while keeping the
> parameter in drm_fb_helper.c. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

