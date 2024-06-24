From: Andreas Klinger <ak@it-klinger.de>
Date: Mon, 24 Jun 2024 06:05:15 -0000
Subject: [PATCH 04/10] iio: adc: hx711: use dev_err_probe()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-4-49e50cd0b99a@baylibre.com>
Message-ID: <ZnkMlWIewq8s_XeS@mail.your-server.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-06-21 at 22:11 +0000, David Lechner wrote:
> Use dev_err_probe() to simplify error returns in the probe function.
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Andreas Klinger <ak@it-klinger.de>

-- 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 659 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240624/a7c142d8/attachment-0001.sig>
