From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 13 Oct 2023 18:38:35 +0800
Subject: [PATCH] crypto: aspeed-hace: Use device_get_match_data()
In-Reply-To: <20231006213917.333702-1-robh@kernel.org>
References: <20231006213917.333702-1-robh@kernel.org>
Message-ID: <ZSkeK2bbjbRljkaB@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 06, 2023 at 04:39:17PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/crypto/aspeed/aspeed-hace.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
