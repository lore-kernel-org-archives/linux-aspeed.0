From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Fri, 22 May 2020 11:22:07 +0300
Subject: [PATCH 4/5] iio: light: lm3533-als: remove explicit parent assignment
In-Reply-To: <20200522082208.383631-1-alexandru.ardelean@analog.com>
References: <20200522082208.383631-1-alexandru.ardelean@analog.com>
Message-ID: <20200522082208.383631-4-alexandru.ardelean@analog.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This assignment is the more peculiar of the bunch as it assigns the parent
of the platform-device's device (i.e. pdev->dev.parent) as the IIO device's
parent.

It's unclear whether this is intentional or not.
Hence it is in it's own patch.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/light/lm3533-als.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index bc196c212881..0f380ec8d30c 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -852,7 +852,6 @@ static int lm3533_als_probe(struct platform_device *pdev)
 	indio_dev->channels = lm3533_als_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
 	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->dev.parent = pdev->dev.parent;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	als = iio_priv(indio_dev);
-- 
2.25.1

