From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 24 Oct 2023 10:43:55 +1030
Subject: [PATCH] drm: Use device_get_match_data()
In-Reply-To: <20231020125214.2930329-1-robh@kernel.org>
References: <20231020125214.2930329-1-robh@kernel.org>
Message-ID: <d4f77e13d3c5de613877450fd25bf5f77f1331a2.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2023-10-20 at 07:52 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data in a single step. With this, adjust the
> includes to explicitly include the correct headers. That also serves as
> preparation to remove implicit includes within the DT headers
> (of_device.h in particular).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/drm/armada/armada_crtc.c    | 24 +++++++-----------------
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 10 ++++------

For Aspeed:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks!
