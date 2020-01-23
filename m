From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 23 Jan 2020 12:23:29 +1030
Subject: [PATCH 1/2] hwrng: Add support for ASPEED RNG
In-Reply-To: <4446ffb694c7742ca9492c7360856789@neuralgames.com>
References: <20200120150113.2565-1-linux@neuralgames.com>
 <CACPK8XfuVN3Q=npEoOP-amQS0-wemxcx6LKaHHZEsBAHzq1wzA@mail.gmail.com>
 <4446ffb694c7742ca9492c7360856789@neuralgames.com>
Message-ID: <575811fd-24ca-409c-8d33-c2152ee401d7@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> Thanks for reviewing the patch.
> 
> The RNG on Aspeed hardware allows eight different modes for combining 
> its four internal Ring Oscillators that together generate a stream of 
> random bits. However, the timeriomem-rng driver does not allow for mode 
> selection so, the Aspeed RNG with this generic driver runs always on 
> mode 'seven' (The default value for mode according to the AspeedTech 
> datasheets).
> 
> I've performed some testings on this Aspeed RNG using the NIST 
> Statistical Test Suite (NIST 800-22r1a) and, the results I got show that 
> the default mode 'seven' isn't producing the best entropy and linear 
> rank when compared against the other modes available on these SOCs.  On 
> the other hand, the driver that I'm proposing here allows for mode 
> selection which would help improve the random output for those looking 
> to get the best out of this Aspeed RNG.

Have you published the data and results of this study somewhere? This
really should be mentioned in the commit message as justification for
not using timeriomem-rng.

Andrew
