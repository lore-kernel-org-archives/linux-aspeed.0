From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 05 Oct 2023 13:44:54 +1030
Subject: [PATCH v2] pinctrl: aspeed: Allow changing SPI mode from
 hardware strap defaults
In-Reply-To: <20231005030849.11352-2-zev@bewilderbeest.net>
References: <20231005030849.11352-2-zev@bewilderbeest.net>
Message-ID: <3bf55144b8169a8f44c67e9a6b63cc67a2edfa50.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2023-10-04 at 20:08 -0700, Zev Weiss wrote:
> Some platforms unfortunately have their SPI mode selection bits
> strapped incorrectly (such as being configured for passthrough mode
> when master mode is in fact the only useful configuration for it) and
> thus require correction in software.  Add the SPI mode bits to the
> GPIO passthrough bits as the exceptions to the read-only rule for the
> hardware strap register so that the pinctrl subsystem can be used for
> such corrections.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks!
