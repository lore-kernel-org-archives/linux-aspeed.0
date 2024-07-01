From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Date: Mon, 01 Jul 2024 16:14:18 -0000
Subject: [PATCH 2/9] mtd: add mtd_is_master helper
In-Reply-To: <20240701-b4-v6-10-topic-usbc-tcpci-v1-2-3fd5f4a193cc@pengutronix.de>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
 <20240701-b4-v6-10-topic-usbc-tcpci-v1-2-3fd5f4a193cc@pengutronix.de>
Message-ID: <b97bf565-bef5-fbc7-63c5-f174880ad9ab@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/1/24 4:53 PM, Marco Felsch wrote:

> Provide a simple helper to make it easy to detect an master mtd device.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  include/linux/mtd/mtd.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 8d10d9d2e830..bf3fc2ea7230 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -408,6 +408,11 @@ static inline struct mtd_info *mtd_get_master(struct mtd_info *mtd)
>  	return mtd;
>  }
>  
> +static inline bool mtd_is_master(struct mtd_info *mtd)
> +{
> +	return mtd->parent ? false : true;

   Perhaps:

	return !mtd->parent;

[...]

MBR, Sergey
