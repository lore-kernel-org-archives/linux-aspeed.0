From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 2 Feb 2023 11:25:33 +0800
Subject: [PATCH-next] crypto: aspeed: fix type warnings
In-Reply-To: <TY2PR06MB321395387369059BC9F9722E80D69@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <20230202025600.2598548-1-neal_liu@aspeedtech.com>
 <Y9spg/66x/wQ3x+g@gondor.apana.org.au>
 <TY2PR06MB321395387369059BC9F9722E80D69@TY2PR06MB3213.apcprd06.prod.outlook.com>
Message-ID: <Y9stLeguRuQVpbiD@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 02, 2023 at 03:23:29AM +0000, Neal Liu wrote:
>
> I cannot tell which way is better. Do you prefer to keep the iomem marker?

The whole point of iomem is to prevent you from directly
dereferencing that memory.  So casting it away to remove the
warning simply defeats its purpose.

If you're worried about the overhead of readb perhaps you can
look into readb_relaxed after considering the effects of the
barriers.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
