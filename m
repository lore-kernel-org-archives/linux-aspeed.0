From: Dhananjay Phadke <dphadke@linux.microsoft.com>
Date: Fri, 16 Sep 2022 10:21:03 -0700
Subject: [PATCH v2] crypto: aspeed: fix build module error
In-Reply-To: <YyRS/71B4veWJgyl@gondor.apana.org.au>
References: <20220905025433.1610696-1-neal_liu@aspeedtech.com>
 <YxXXuyNrQIcMZBLI@gondor.apana.org.au>
 <HK0PR06MB3202F47019416BA40859C7D4807E9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <YyRS/71B4veWJgyl@gondor.apana.org.au>
Message-ID: <4dc8b1a8-d7ef-844d-b48e-76fb8b91d96a@linux.microsoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/16/2022 3:42 AM, Herbert Xu wrote:
>>> Does this still build if both HASH and CRYPTO are off?
>>>
>>> I think this it's best if you do:
>>>
>>> hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=
>>> aspeed-hace-hash.o
>>> hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) :=
>>> aspeed-hace-crypto.o
>>>
>>> obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
>>> aspeed_crypto-objs := aspeed-hace.o	\
>>> 		      $(hace-hash-y)	\
>>> 		      $(hace-crypto-y)
>>>
>> aspeed-hace.o effects only if either hace-hash-y or hace-crypto-y.
>> If we put aspeed-hace.o in aspeed_crypto-objs, but hace-hash-y and hace-crypto-y are empty, apseed-hace.o is just an useless driver which might still occupy system resources.
> Apparently it doesn't build after all, at least not on m68k.
> 
> So please either adopt my suggestion above, or come up with another
> way of preventing the build failure on m68k with both HASH and CRYPTO
> disabled.

Curious why compiled on m68k? It's embedded controller in ARM based
Aspeed SoCs. And there's "depends on ARCH_ASPEED" in Kconfig, need
some additional dependencies?

Regards,
Dhananjay
