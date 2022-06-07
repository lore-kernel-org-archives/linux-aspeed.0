From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 7 Jun 2022 02:52:04 +0000
Subject: [PATCH v2 5/5] crypto: aspeed: add HACE crypto driver
In-Reply-To: <8f4176e7-87b0-1cf9-bcef-6a423d17fd6a@infradead.org>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-6-neal_liu@aspeedtech.com>
 <8f4176e7-87b0-1cf9-bcef-6a423d17fd6a@infradead.org>
Message-ID: <HK0PR06MB3202B0A8DEF448B14A070E6080A59@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Hi--
> 
> On 6/5/22 23:49, Neal Liu wrote:
> > diff --git a/drivers/crypto/aspeed/Kconfig
> > b/drivers/crypto/aspeed/Kconfig index 17b800286a51..5e4d18288bf1
> > 100644
> > --- a/drivers/crypto/aspeed/Kconfig
> > +++ b/drivers/crypto/aspeed/Kconfig
> > @@ -20,3 +20,19 @@ config CRYPTO_DEV_ASPEED_HACE_HASH
> >  	  hash driver.
> >  	  Supports multiple message digest standards, including
> >  	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.
> > +
> > +config CRYPTO_DEV_ASPEED_HACE_CRYPTO
> > +        bool "Enable ASPEED Hash & Crypto Engine (HACE) crypto"
> > +        depends on CRYPTO_DEV_ASPEED
> 
> The 2 lines above should be indented with one tab instead of multiple spaces.

Thanks for the notice. I'll revise it in next patch.

