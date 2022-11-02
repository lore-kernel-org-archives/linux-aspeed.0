From: Javier Martinez Canillas <javierm@redhat.com>
Date: Wed, 2 Nov 2022 11:01:22 +0100
Subject: [PATCH v2 20/21] drm/fb-helper: Move generic fbdev emulation into
 separate source file
In-Reply-To: <20221024111953.24307-21-tzimmermann@suse.de>
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-21-tzimmermann@suse.de>
Message-ID: <1d2b9809-857f-48cc-1177-72e6fc67b8e5@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/24/22 13:19, Thomas Zimmermann wrote:
> Move the generic fbdev implementation into its own source and header
> file. Adapt drivers. No functonal changes, but some of the internal
> helpers have been renamed to fit into the drm_fbdev_ naming scheme.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

