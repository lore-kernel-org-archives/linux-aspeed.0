From: Andreas Klinger <ak@it-klinger.de>
Date: Mon, 24 Jun 2024 06:15:11 -0000
Subject: [PATCH 03/10] iio: adc: hx711: remove hx711_remove()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-3-49e50cd0b99a@baylibre.com>
Message-ID: <ZnkMZIKpmn8HOKN8@mail.your-server.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-06-21 at 22:11 +0000, David Lechner wrote:
> By using a few more devm_ functions, we can remove the hx711_remove()
> function in the hx711 driver.
> 
> platform_set_drvdata() is also removed since there are no more
> callers of platform_get_drvdata().
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Andreas Klinger <ak@it-klinger.de>

-- 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 659 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240624/858fb007/attachment-0001.sig>
