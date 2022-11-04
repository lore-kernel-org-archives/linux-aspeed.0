From: Javier Martinez Canillas <javierm@redhat.com>
Date: Fri, 4 Nov 2022 11:38:07 +0100
Subject: [PATCH v3 23/23] drm/fb-helper: Clarify use of last_close and
 output_poll_changed
In-Reply-To: <20221103151446.2638-24-tzimmermann@suse.de>
References: <20221103151446.2638-1-tzimmermann@suse.de>
 <20221103151446.2638-24-tzimmermann@suse.de>
Message-ID: <1f5e6de4-3fe2-7933-f8c0-5f13564595cc@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/3/22 16:14, Thomas Zimmermann wrote:
> Clarify documentation in the use of struct drm_driver.last_close and
> struct drm_mode_config_funcs.output_poll_changed. Those callbacks should
> not be said for fbdev implementations on top of struct drm_client_funcs.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

