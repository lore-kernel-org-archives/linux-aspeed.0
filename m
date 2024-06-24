From: Andreas Klinger <ak@it-klinger.de>
Date: Mon, 24 Jun 2024 06:15:14 -0000
Subject: [PATCH 02/10] iio: adc: hx711: use
 devm_regulator_get_enable_read_voltage()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-2-49e50cd0b99a@baylibre.com>
Message-ID: <ZnkMSO_dPWNY712F@mail.your-server.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-06-21 at 22:11 +0000, David Lechner wrote:
> Use the devm_regulator_get_enable_read_voltage() helper to simplify the
> code.
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Andreas Klinger <ak@it-klinger.de>

-- 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 659 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240624/08c9a91b/attachment-0001.sig>
