From: Nuno Sá <noname.nuno@gmail.com>
Date: Mon, 24 Jun 2024 08:16:07 -0000
Subject: [PATCH 06/10] iio: adc: max1363: use
 devm_regulator_get_enable_read_voltage()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-6-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
	 <20240621-iio-regulator-refactor-round-2-v1-6-49e50cd0b99a@baylibre.com>
Message-ID: <ae9ba7ceab932277703c048d80b49af4cfff439b.camel@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-06-21 at 17:11 -0500, David Lechner wrote:
> Use devm_regulator_get_enable_read_voltage() to simplify the code.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


