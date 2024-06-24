From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 24 Jun 2024 09:58:17 +0930
Subject: [PATCH 01/10] iio: adc: aspeed_adc: use
 devm_regulator_get_enable_read_voltage()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-1-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
	 <20240621-iio-regulator-refactor-round-2-v1-1-49e50cd0b99a@baylibre.com>
Message-ID: <b522733009008a22dd8975a92ad6d0b1c038c452.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-06-21 at 17:11 -0500, David Lechner wrote:
> This makes use of the devm_regulator_get_enable_read_voltage() helper
> function to simplify the code.
> 
> The error return is moved closer to the function call to make it easier
> to follow the logic. And a few blank lines are added for readability.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Nice cleanup!

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

