From: linux@neuralgames.com <linux@neuralgames.com>
Date: Tue, 28 Jan 2020 18:26:35 -0600
Subject: [PATCH 1/2] hwrng: Add support for ASPEED RNG
In-Reply-To: <b83f2a1f-e1be-433c-8dc8-c469cb38f423@www.fastmail.com>
References: <20200120150113.2565-1-linux@neuralgames.com>
 <CACPK8XfuVN3Q=npEoOP-amQS0-wemxcx6LKaHHZEsBAHzq1wzA@mail.gmail.com>
 <4446ffb694c7742ca9492c7360856789@neuralgames.com>
 <575811fd-24ca-409c-8d33-c2152ee401d7@www.fastmail.com>
 <136bbab84d13d8d56a5ac297e415975e@neuralgames.com>
 <b83f2a1f-e1be-433c-8dc8-c469cb38f423@www.fastmail.com>
Message-ID: <27c5505acd8d09f70ec9cd12982b2e3e@neuralgames.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2020-01-27 18:53, Andrew Jeffery wrote:
> On Sat, 25 Jan 2020, at 11:40, linux at neuralgames.com wrote:
>> On 2020-01-22 19:53, Andrew Jeffery wrote:
>> >> Thanks for reviewing the patch.
>> >>
>> >> The RNG on Aspeed hardware allows eight different modes for combining
>> >> its four internal Ring Oscillators that together generate a stream of
>> >> random bits. However, the timeriomem-rng driver does not allow for
>> >> mode
>> >> selection so, the Aspeed RNG with this generic driver runs always on
>> >> mode 'seven' (The default value for mode according to the AspeedTech
>> >> datasheets).
>> >>
>> >> I've performed some testings on this Aspeed RNG using the NIST
>> >> Statistical Test Suite (NIST 800-22r1a) and, the results I got show
>> >> that
>> >> the default mode 'seven' isn't producing the best entropy and linear
>> >> rank when compared against the other modes available on these SOCs.
>> >> On
>> >> the other hand, the driver that I'm proposing here allows for mode
>> >> selection which would help improve the random output for those looking
>> >> to get the best out of this Aspeed RNG.
>> >
>> > Have you published the data and results of this study somewhere? This
>> > really should be mentioned in the commit message as justification for
>> > not using timeriomem-rng.
>> >
>> > Andrew
>> 
>> Hi Andrew,
>> 
>> I have uploaded the results of my tests to my GitHub, along with all 
>> the
>> binaries
>> containing the random bits that I collected from this Aspeed RNG using
>> all 8 modes.
>> You can also find in this repository a patch for the hw_random core
>> driver that
>> I've been using to collect this data. Here is the link:
>>    https://github.com/operezmuena/aspeed-rng-testing
>> 
>> You can see in the reports that when using large enough samples (40Mb 
>> in
>> size)
>> this Aspeed RNG consistently fails the linear rank and entropy tests, 
>> no
>> matter
>> what RNG mode is selected. However, modes 2, 4 and 6 produce better
>> entropy than
>> the rest.
>> I'm now collecting rng data from 2 other AST2520 SOCs that I have in
>> order to
>> compare results.
> 
> Nice work. Eyeballing the summaries, it seems mode 6 or mode 4 may be
> improvements over 7? What's your analysis? It would be nice to have the
> data from your other two SoCs to corroborate. Again, going forward, 
> please
> point to your measurements in your commit message.
> 

Hi Andrew,

I pushed to my GitHub repository the RNG dumps and NIST reports from the 
other 2 SOCs. The results are similar to the first SOC. None of the 
modes passed the NIST test for linear rank and approximate entropy. 
Also, these SOCs show that mode 6 produces better results than mode 7. 
However, having only a sample of 3 SOCs isn't going to give us 
statistical significance about which mode would be the best one on these 
SOCs but, it is hinting us that perhaps allowing the selection of other 
RNG modes would be a good feature to have in a driver.
Now, I must say that this is the first RO-based RNG that I have tested 
and I'm a bit concerned about the results I've been getting. I'm now 
wondering how RNGs from other SOC vendors would perform with this same 
test suite.

> Not that I've looked, but is it feasible to augment timeriomem-rng with
> the ability to configure the RNG rather than implement a new driver? 
> Why
> didn't you go that route?
> 
> Andrew

I decided to wrote the Aspeed-RNG driver because was under the 
impression that the community would prefer dedicated drivers over 
generic ones for these SOCs.  However, enhancing timeriomem-rng module 
is not hard at all.  As I matter of fact, I'm currently testing changes 
to timeriomem-rng and so far so good. If you would like to have a quick 
look to my changes, I just pushed patches to the same repo a couple of 
hours ago:  
https://github.com/operezmuena/aspeed-rng-testing/tree/master/patches

Thanks
Oscar
