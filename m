From: Markus Elfring <Markus.Elfring@web.de>
Date: Sun, 27 Oct 2019 07:55:15 +0100
Subject: [PATCH] media: aspeed-video: Fix memory leaks in
 aspeed_video_probe
In-Reply-To: <20191026042519.29446-1-navid.emamdoost@gmail.com>
References: <20191026042519.29446-1-navid.emamdoost@gmail.com>
Message-ID: <bec85427-66b8-e0fa-9ee2-07cc77cf4a7e@web.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

?
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -1663,18 +1663,24 @@ static int aspeed_video_probe(struct platform_device *pdev)
?
> +free_video:
> +	kfree(video);
?

I am curious if there is a need for such a memory release at another place.
How do you think about to add this function call also to the implementation
of the function ?aspeed_video_remove??

Regards,
Markus
