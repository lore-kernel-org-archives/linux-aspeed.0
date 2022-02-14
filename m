From: Joel Stanley <joel@jms.id.au>
Date: Mon, 14 Feb 2022 06:34:54 +0000
Subject: [PATCH] media: aspeed: Use of_device_get_match_data() helper
In-Reply-To: <20220214032708.854-1-jammy_huang@aspeedtech.com>
References: <20220214032708.854-1-jammy_huang@aspeedtech.com>
Message-ID: <CACPK8XcLJuWitefi8LTAxDrhzAVe3b88haQYAJRLX5M=ceDg5g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 14 Feb 2022 at 03:27, Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>
> Use of_device_get_match_data() to simplify the code.
>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  drivers/media/platform/aspeed-video.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 3904ded2052a..d4acf84cda9b 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
> @@ -2451,7 +2452,6 @@ MODULE_DEVICE_TABLE(of, aspeed_video_of_match);
>  static int aspeed_video_probe(struct platform_device *pdev)
>  {
>         const struct aspeed_video_config *config;
> -       const struct of_device_id *match;
>         struct aspeed_video *video;
>         int rc;
>
> @@ -2463,11 +2463,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
>         if (IS_ERR(video->base))
>                 return PTR_ERR(video->base);
>
> -       match = of_match_node(aspeed_video_of_match, pdev->dev.of_node);
> -       if (!match)
> -               return -EINVAL;
> -
> -       config = match->data;
> +       config = of_device_get_match_data(&pdev->dev);

While normally this driver won't have probed without matching on some
data, it would be sensible to add a check for a null pointer here.

>         video->version = config->version;
>         video->jpeg_mode = config->jpeg_mode;
>         video->comp_size_read = config->comp_size_read;
> --
> 2.25.1
>
