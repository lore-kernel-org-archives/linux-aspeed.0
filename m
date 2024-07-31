From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 31 Jul 2024 15:31:25 +0930
Subject: [PATCH] i2c: don't use ',' after delimiters
In-Reply-To: <20240730220401.3649-2-wsa+renesas@sang-engineering.com>
References: <20240730220401.3649-2-wsa+renesas@sang-engineering.com>
Message-ID: <25b2bc6b5b4aec33396f4d6960654e65bf1c3d6e.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-07-31 at 00:01 +0200, Wolfram Sang wrote:
> Delimiters are meant to be last, no need for a ',' there. Remove a
> superfluous newline in the ali1535 driver while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> @Andi: These changes are super trivial so I put them into one patch. Let
> me know if you prefer broken out patches. I think it is better if it
> goes through your tree, but I can also take if you prefer.
> 
>  drivers/i2c/busses/i2c-ali1535.c      | 3 +--
>  drivers/i2c/busses/i2c-amd-mp2-plat.c | 2 +-
>  drivers/i2c/busses/i2c-aspeed.c       | 2 +-

Thanks for the cleanup.

For the Aspeed portion:

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
