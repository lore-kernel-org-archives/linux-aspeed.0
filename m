From: Andi Shyti <andi.shyti@kernel.org>
Date: Wed, 31 Jul 2024 00:53:50 +0200
Subject: [PATCH] i2c: don't use ',' after delimiters
In-Reply-To: <20240730220401.3649-2-wsa+renesas@sang-engineering.com>
References: <20240730220401.3649-2-wsa+renesas@sang-engineering.com>
Message-ID: <emgv23ln3n7kut7pc3xj2xynge3arjmeddhbd5jowsp62t4k2r@es6i352stdpk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Wolfram,

On Wed, Jul 31, 2024 at 12:01:59AM GMT, Wolfram Sang wrote:
> Delimiters are meant to be last, no need for a ',' there. Remove a
> superfluous newline in the ali1535 driver while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> @Andi: These changes are super trivial so I put them into one patch. Let
> me know if you prefer broken out patches. I think it is better if it
> goes through your tree, but I can also take if you prefer.

It's OK... I will leave it for a few days more and then merge it.

Thanks,
Andi
