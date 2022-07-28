From: Dhananjay Phadke <dphadke@linux.microsoft.com>
Date: Wed, 27 Jul 2022 23:18:22 -0700
Subject: [PATCH v8 5/5] crypto: aspeed: add HACE crypto driver
In-Reply-To: <TY2PR06MB32137A54B483D6D700BDE7EC80979@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <20220726113448.2964968-1-neal_liu@aspeedtech.com>
 <20220726113448.2964968-6-neal_liu@aspeedtech.com>
 <9d6beefe-9974-22f8-750c-68c9acb707ab@linux.microsoft.com>
 <TY2PR06MB32137A54B483D6D700BDE7EC80979@TY2PR06MB3213.apcprd06.prod.outlook.com>
Message-ID: <450dee2f-63bf-51a7-730e-b780b594c1c5@linux.microsoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/26/2022 10:31 PM, Neal Liu wrote:
>> Why are separate options required for hash and crypto algorithms, if hace is
>> only hw crypto on the SoCs?
>>
>> Looks like that's requiring unnecessary __weak register / unregister functions
>> [see below].
>>
>> Couldn't just two options CONFIG_CRYPTO_DEV_ASPEED and
>> CONFIG_CRYPTO_DEV_ASPEED_DEBUG be simpler to set for downstream
>> defconfigs?
> I would like to separate different algorithms by different options for more convenient for further use and debug.
> We also have RSA engine named ACRY, and would upstream once hash & crypto being accepted.
> So combined them into one option seems not a good choice for multiple hw crypto, do you agree?

Not sure what's the use case of just enabling crypto or hash separately
out of same HW engine and esp. when there's no alternative accel 
available, but that's fine.

If ARCY is different HW engine (interface) then having separate config
sounds logical.

Multiplying DEBUG configs seems unnecessary though. With dynamic debug
any of the dev_dbg could be turned on. Suggest using single one for
the module, if not drop it altogether. Following code is still not
covered by Kconfig, it in common code.

 > +#ifdef ASPEED_HACE_DEBUG
 > +#define HACE_DBG(d, fmt, ...)	\
 > +	dev_info((d)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
 > +#else
 > +#define HACE_DBG(d, fmt, ...)	\
 > +	dev_dbg((d)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
 > +#endif

Regards,
Dhananjay


