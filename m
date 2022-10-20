From: Sergey Shtylyov <s.shtylyov@omp.ru>
Date: Thu, 20 Oct 2022 13:55:44 +0300
Subject: [PATCH 03/21] drm/ingenic: Don't set struct drm_driver.lastclose
In-Reply-To: <20221020103755.24058-4-tzimmermann@suse.de>
References: <20221020103755.24058-1-tzimmermann@suse.de>
 <20221020103755.24058-4-tzimmermann@suse.de>
Message-ID: <013ea55b-3d51-c89c-eff8-b8d355ded352@omp.ru>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello!

On 10/20/22 1:37 PM, Thomas Zimmermann wrote:

> Don't set struct drm_mode_config.output_poll_changed. It's used to
> inform the fbdev console about conncetor changes. But as ingenic

   Connector. :-)

> uses generic fbdev emulation, the console is being informed by the
> DRM client helpers already. See the calls to drm_client_dev_hotplug()
> in drm_probe_helper.c.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
[...]

MBR, Sergey
