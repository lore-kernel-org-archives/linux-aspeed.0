From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 26 Oct 2023 08:44:52 +0300
Subject: [PATCH] drm: Use device_get_match_data()
In-Reply-To: <20231020125214.2930329-1-robh@kernel.org>
References: <20231020125214.2930329-1-robh@kernel.org>
Message-ID: <d1da5acd-384f-4ddd-a721-ce677cc38a3d@ideasonboard.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/10/2023 15:52, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data in a single step. With this, adjust the
> includes to explicitly include the correct headers. That also serves as
> preparation to remove implicit includes within the DT headers
> (of_device.h in particular).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/gpu/drm/armada/armada_crtc.c    | 24 +++++++-----------------
>   drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 10 ++++------
>   drivers/gpu/drm/exynos/exynos_drm_gsc.c |  9 +++++----
>   drivers/gpu/drm/imx/ipuv3/imx-ldb.c     |  9 ++++-----
>   drivers/gpu/drm/mxsfb/mxsfb_drv.c       | 10 +++-------
>   drivers/gpu/drm/omapdrm/dss/dispc.c     |  4 ++--
>   drivers/gpu/drm/omapdrm/dss/dss.c       |  5 +++--
>   7 files changed, 28 insertions(+), 43 deletions(-)

For omapdrm:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

