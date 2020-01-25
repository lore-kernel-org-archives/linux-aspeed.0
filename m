From: linux@neuralgames.com <linux@neuralgames.com>
Date: Fri, 24 Jan 2020 19:10:05 -0600
Subject: [PATCH 1/2] hwrng: Add support for ASPEED RNG
In-Reply-To: <575811fd-24ca-409c-8d33-c2152ee401d7@www.fastmail.com>
References: <20200120150113.2565-1-linux@neuralgames.com>
 <CACPK8XfuVN3Q=npEoOP-amQS0-wemxcx6LKaHHZEsBAHzq1wzA@mail.gmail.com>
 <4446ffb694c7742ca9492c7360856789@neuralgames.com>
 <575811fd-24ca-409c-8d33-c2152ee401d7@www.fastmail.com>
Message-ID: <136bbab84d13d8d56a5ac297e415975e@neuralgames.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2020-01-22 19:53, Andrew Jeffery wrote:
>> Thanks for reviewing the patch.
>> 
>> The RNG on Aspeed hardware allows eight different modes for combining
>> its four internal Ring Oscillators that together generate a stream of
>> random bits. However, the timeriomem-rng driver does not allow for 
>> mode
>> selection so, the Aspeed RNG with this generic driver runs always on
>> mode 'seven' (The default value for mode according to the AspeedTech
>> datasheets).
>> 
>> I've performed some testings on this Aspeed RNG using the NIST
>> Statistical Test Suite (NIST 800-22r1a) and, the results I got show 
>> that
>> the default mode 'seven' isn't producing the best entropy and linear
>> rank when compared against the other modes available on these SOCs.  
>> On
>> the other hand, the driver that I'm proposing here allows for mode
>> selection which would help improve the random output for those looking
>> to get the best out of this Aspeed RNG.
> 
> Have you published the data and results of this study somewhere? This
> really should be mentioned in the commit message as justification for
> not using timeriomem-rng.
> 
> Andrew

Hi Andrew,

I have uploaded the results of my tests to my GitHub, along with all the 
binaries
containing the random bits that I collected from this Aspeed RNG using 
all 8 modes.
You can also find in this repository a patch for the hw_random core 
driver that
I've been using to collect this data. Here is the link:
   https://github.com/operezmuena/aspeed-rng-testing

You can see in the reports that when using large enough samples (40Mb in 
size)
this Aspeed RNG consistently fails the linear rank and entropy tests, no 
matter
what RNG mode is selected. However, modes 2, 4 and 6 produce better 
entropy than
the rest.
I'm now collecting rng data from 2 other AST2520 SOCs that I have in 
order to
compare results.

Regards,
Oscar



